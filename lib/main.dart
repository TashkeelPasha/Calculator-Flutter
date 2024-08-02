import 'package:calculator/Home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(calculator());
}

class calculator extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}