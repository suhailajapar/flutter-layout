import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'bySuhaila',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _persons = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('asset/MOCK_DATA.json');
    final data = await json.decode(response);
    setState(() {
      _persons = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Last Seen: Who & when',
        ),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder:(context, data) {
          return ListView.builder(
                      itemCount: _persons.length,
                      itemBuilder: (context, id) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.network("${_persons[id]["avatar"]}")
                              ),
                              Container(
                                child: Text(_persons[id]["first_name"])
                              ),
                              Container(
                                child: Text(_persons[id]["last_name"])
                              ),
                            ],
                          ),
                        );
                      },
                    );
          
        },
        
      ),
    );
  }
}