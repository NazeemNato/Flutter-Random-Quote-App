import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

void main(){
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data;
  var my_data;
  var c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Use future builder and DefaultAssetBundle to load the local JSON file
       body:Center(
         child: Stack(
         children: <Widget>[
           SizedBox(height: 40),
            Container(
           decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
           child: FutureBuilder(
           future: DefaultAssetBundle.of(context).loadString('assets/json/q.json'),
           builder: (context, snapshot){
             my_data = json.decode(snapshot.data.toString());
             var range = new Random();
             c = range.nextInt(my_data.length);
             return Ui_Card(c);
           },
          ),
         ),
         Positioned(
           child: AppBar(
              title: Text("__QUOTAPP__"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,)
         )
         ],
       ),
       ),
       bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
         child: Container(
           margin: const EdgeInsets.only(left: 40.0,right: 40.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                tooltip:'Copy',
                icon: Icon(Icons.content_copy) ,
                iconSize: 40,
                color: Colors.white,
                onPressed: () async {
                  final data = ClipboardData(
                    text: my_data[c]['quoteText']+'\n'+my_data[c]['quoteAuthor'],
                  );
                  Clipboard.setData(data);
                },
              ),IconButton(
                tooltip:'Coming Soon',
                icon: Icon(Icons.notifications) ,
                iconSize: 40,
                color: Colors.white,
                onPressed: null,
              ),
              IconButton(
                tooltip:'Random Quotes',
                icon: Icon(Icons.format_quote) ,
                iconSize: 40,
                color: Colors.white,
                onPressed: (){
                  setState(() {
             var range = new Random();
             c = range.nextInt(my_data.length);
           });
                },
              ),
            ],
           ),
         ),
       ),
    );
  }
  Widget Ui_Card(index){
    return new Container(

      child:  Center(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Text(" "),
           Text(" "),
          Padding(
              padding: const EdgeInsets.all(70.0),
              child: Text(my_data[c]['quoteText'], style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22.0, color: Colors.white, fontFamily: 'Raleway-Italic',fontStyle: FontStyle.italic,),textScaleFactor: 1.0,)),
              Text(my_data[c]['quoteAuthor'],style:TextStyle(
      fontWeight: FontWeight.w500,
       color: Colors.white,
       fontFamily: 'Raleway-Bold',
       fontSize: 18.0
    ),
    textAlign: TextAlign.left,
          ),
         ],
       ),
      ),
    );
  }
  
}