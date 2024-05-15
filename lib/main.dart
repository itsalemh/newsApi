import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    const apiKey = '8c8b13c8e83d48808854a85f49358e26';
    const apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _articles = jsonData['articles'];
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (context, index) {
            final article = _articles[index];
            return ListTile(
              title: Text(article['title'] ?? 'No title available'),
              subtitle:
                  Text(article['description'] ?? 'No description available'),
            );
          },
        ),
      ),
    );
  }
}
