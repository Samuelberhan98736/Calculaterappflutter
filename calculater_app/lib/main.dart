//homework1 


import 'package:flutter/material.dart';

void main(){
  runApp(CalculaterApp());
}


class CalculaterApp extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    reutrn MaterialApp(
      title: 'Calculater App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDesity:VisualDensity.adaptivePlatformDesity,
      ),

      home: CalculatorScreen(),
      debugShowChackedModeBanner: false,


    );

  }
}



class CalculaterScreen extends StatefulWidget{
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();

}

class _CalculatorScreenState extends State<CalculatorScreen>{


  //Display variables
  String displayText = '0';
  String currentInput = '';
  String operator = '';
  double firstOperand = 0.0;
  bool isOperatorPressed = false;
  bool isResultDisplayed = false;
  bool hasDecimalPoint = false;


  //method to handle number button presses

  void onNumberPressed(String number){
    setState((){
      if (isResultDisplayed){
        clear();
      }

      if(isOperatorPressed){
        //start new number after after operator

        currentInput = number;
        
      }
    })
  }


}



