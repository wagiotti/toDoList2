import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _toDoList = ["flutter", "VueJS", "Electron", "Javascript", "Bootstrap"];

  //Obter arquivo
  Future<File> _getFile() async {
    final diretory = await getApplicationDocumentsDirectory();
    return File("${diretory.path}/data.json");
  }

  // Salvar arquivo
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  // Ler arquivo
  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDoList"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nova ToDO",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (conxtet, index) {
                return CheckboxListTile(
                  title: Text(_toDoList[index]["title"]),
                  value: _toDoList.[index]["ok"],
                  secondary: CircleAvatar(child:Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),), 
                  onChanged: null)(
                  
                );
              },
              itemCount: _toDoList.length,
              padding: EdgeInsets.only(top: 5),
            ),
          ),
        ],
      ),
    );
  }
}
