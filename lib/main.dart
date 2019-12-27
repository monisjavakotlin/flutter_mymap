import 'package:flutter/material.dart';
import 'package:flutter_mymap/pages/my_map.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.map)),
              Tab(icon: Icon(Icons.restaurant)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            MyMap(),
            Icon(Icons.restaurant),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
