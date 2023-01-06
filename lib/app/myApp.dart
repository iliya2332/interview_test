// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:interview_test/app/image_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final url =
      'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9';

  var _postJson = [];

  void fetchPost() async {
    final request = await get(Uri.parse(url));
    final responce = jsonDecode(request.body) as List;

    setState(() {
      _postJson = responce;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: ListView.builder(
            itemCount: _postJson.length,
            itemBuilder: (context, i) {
              final post = _postJson[i];
              var image = post["urls"]["small"];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageScreen(
                                      imageUrl: post,
                                    )));
                      },
                      icon: Image.network(image)),
                  Text('${post["user"]["name"]}'),
                ],
              );
            }),
      ),
    );
  }
}
