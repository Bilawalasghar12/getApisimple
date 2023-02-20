import 'package:flutter/material.dart';
import 'model class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Result> resultinfo = [];

  @override
  void initstate() {
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return Scaffold(
            body: ListView.builder(
                itemCount: resultinfo.length,
                itemBuilder: (context, index) {
                  print(resultinfo);
                  return Column(
                    children: [Text(resultinfo[index].name.toString())],
                  );
                }),
          );
        });
  }

  Future getData() async {
    final response = await http.get(Uri.parse('https://rawg.io/api/games?key=00587b1fbd604384827b9b1c1c0326ea'));
    var data = http.jsonDecode(response.body.toString());
    print(response);
    if (response.statusCode == 200) {

      for (Map<String, dynamic> index in data ['results'] ) { print(index);
        resultinfo.add(Result.fromMap(index ));
      }
      print('hii');
      print(resultinfo.length);
      return resultinfo;
    }
  }
}
