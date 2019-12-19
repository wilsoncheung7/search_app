import 'package:flutter/material.dart';

void main() => runApp(MyApp());



  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Search App',
    theme: ThemeData(
    primarySwatch: Colors.blue,
    ),
    home: MyHomePage(title: "Search App"),
    );
   }
  }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String>{

  final cities=[
    "Vancouver",
    "Toronto",
    "Montreal",
    "New York",
    "Seattle",
    "LA"
  ];

  final recentCities=[
    "Toronto",
    "Seattle",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(icon: Icon(Icons.clear),onPressed: (){
       query="";
      })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Center(
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Card(
          color: Colors.yellow,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when some searches for something
    final suggestionList=query.isEmpty?recentCities:cities.where((p)=>p.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context,index) => ListTile(
      onTap: (){
        showResults(context);
      },
      leading: Icon(Icons.location_city),
      title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ]
          )),
    ),
    itemCount: suggestionList.length,
    );
  }
}
