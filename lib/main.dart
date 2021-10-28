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
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: const Text(
          'The last time I saw you',
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
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[

                                // For Avatar
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Center(
                                    child: _persons[id]['avatar'] != null ? 
                                      Image.network("${_persons[id]["avatar"]}") 
                                      : Icon(
                                          Icons.account_circle, 
                                          color: Colors.pink, 
                                          size: 50
                                        )
                                  )
                                ),

                                // For user details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          _persons[id]["first_name"] + " " + _persons[id]["last_name"],
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          _persons[id]["username"],
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ),
                                      Container(
                                        child: _persons[id]['status'] != null ? 
                                          Text('"${_persons[id]["status"]}"') 
                                          : Text(
                                              'No Status', 
                                              style: TextStyle(color: Colors.grey),
                                            )
                                      )
                                    ],
                                  ),
                                ),

                                // For last seen & messages
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          _persons[id]["last_seen_time"],
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        )
                                      ),
                                      Container(
                                        child: _persons[id]['messages'] != null ? 
                                          CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.pinkAccent,
                                            child: Text(
                                                _persons[id]["messages"].toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ) 
                                          : Container(
                                              width: 24,
                                              height: 24,
                                            )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        );
                      },
                    );
          
        },
        
      ),
    );
  }
}