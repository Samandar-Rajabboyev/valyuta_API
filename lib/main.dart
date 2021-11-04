import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flag/flag.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RestAPI());
  }
}

class RestAPI extends StatefulWidget {
  RestAPI({Key? key}) : super(key: key);

  @override
  _RestAPIState createState() => _RestAPIState();
}

class _RestAPIState extends State<RestAPI> {
  List json = [];
  var url = Uri.parse('https://nbu.uz/uz/exchange-rates/json/');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse();
  }

  Future<void> getResponse() async {
    var response = await http.get(url);

    json = jsonDecode(response.body);
    this.json = json;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // TextButton(
            //   child: Text('Get'),
            //   onPressed: () {
            //     // setState(() {
            //     getResponse();
            //     // });
            //   },
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: json.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // DropdownButton(items: List<DropdownMenuItem<dynamic>> [
                      //   json[index]['code'],
                      // ]),
                      ListTile(
                        leading: Flag.fromString(
                          json[index]['code'],
                          height: 10,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        title: Text(json[index]['title'].toString()),
                        subtitle: Text(json[index]['cb_price'] + "so'm"),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
