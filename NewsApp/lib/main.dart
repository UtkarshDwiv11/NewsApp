import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: CharacterList(),
    ));

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  List<dynamic> characters = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  fetchCharacters() async {
    var response =
        await http.get('https://api.sampleapis.com/futurama/characters');
    setState(() {
      characters = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Futurama Characters"),
        ),
        body: characters == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(characters[index]['name'].toString() ?? ''),
                    subtitle:
                        Text(characters[index]['species'].toString() ?? ''),
                  );
                },
              ));
  }
}
