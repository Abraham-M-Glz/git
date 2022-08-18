import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Data extends StatefulWidget {
  const Data({
    Key? key,
  }) : super(key: key);

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  dataAPI() async {
    var response = await http.get(
      Uri.parse("https://coderbyte.com/api/challenges/json/json-cleaning"),
      headers: {"Content-type": "application/json"},
    );
    print(json.decode(response.body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      cleaningData(data);
    } else {
      print("Some faliure, try again");
    }
  }

  cleaningData(data) {
    var dataCleaned = {};
    var aux = {};
    var aux2 = [];
    data.forEach((k, v) {
      //check if the keys have list or map
      if (v.runtimeType == String || v.runtimeType == int) {
        if (v == "-" || v == "N/A" || v == "") {
        } else {
          dataCleaned[k] = v;
        }
      } else {
        //check if is a list
        if (v.runtimeType == List<dynamic>) {
          v.forEach((i) {
            if (i != "-" && i != "N/A" && i != "") {
              aux2.add(i);
              dataCleaned[k] = aux2;
            }
          });
          //if is a map
        } else {
          v.forEach((k1, v1) {
            if (v1.runtimeType == String || v1.runtimeType == int) {
              if (v1 == "-" || v1 == "N/A" || v1 == "") {
              } else {
                aux[k1] = v1;
                dataCleaned[k] = aux;
              }
            }
          });
        }
      }

      aux = {};
      aux2 = [];
    });

    print("Oginal Data:");
    print(data);
    print("cleaned Data:");
    print(dataCleaned);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ElevatedButton(
            child: Text("Data"),
            onPressed: () {
              dataAPI();
            },
          ),
        ),
      ),
    );
  }
}
