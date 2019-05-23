import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

void main() => runApp(MaterialApp(home: myApp(todos:getData())));

Future <Todos> getData()async {  
  final resp = await http.get('https://jsonplaceholder.typicode.com/todos/1');
   if(resp.statusCode==200){ 
     return Todos.fromJson(json.decode(resp.body));
   }else{  
     throw Exception('No response fromt he server');
   }
}
class Todos{   
  final int user;
  final int id;
  final String title;
  final bool completed;

  Todos({this.user,this.id,this.title,this.completed});

  factory Todos.fromJson(Map<String,dynamic>json){  
    return Todos(   
      user:json['userId'],
      id:json['id'],
      title:json['title'],
      completed:json['completed'],
    );
  }
}


class myApp extends StatelessWidget{
  Future<Todos>todos;
  myApp({Key key,this.todos})  :super(key:key);
  Widget build(BuildContext context){  
    return Scaffold(  
    appBar:new AppBar(   
      title:new Text('Random Flutter Application'),
    ),
    body:Center(
      child:FutureBuilder<Todos>(   
      future:todos,
      builder:(context,snapshot){  
      if(snapshot.hasData){  
        return Text('snapshot.data.title');
      }else if(snapshot.hasError){
        return Text("${snapshot.error}");
      }
      }
      )
        
      )
    );
  }
}