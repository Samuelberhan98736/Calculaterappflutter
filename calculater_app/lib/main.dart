//homework1 


import 'package:flutter/material.dart';

void main(){
  runApp(CalculatorApp());
}


class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
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
     if(isResultDisplayed) {
        // If result was just displayed, start fresh calculation
        clear();
      }
      
      if (isOperatorPressed) {
        // Start new number after operator
        currentInput = number;
        displayText = number;
        isOperatorPressed = false;
        hasDecimalPoint = false;
      } else {
        // Continue building current number
        if (displayText == '0') {
          displayText = number;
          currentInput = number;
        } else {
          displayText += number;
          currentInput += number;
        }
      }
    });
  }


   // Method to handle decimal point button press
  void onDecimalPressed() {
    setState(() {
      if (isResultDisplayed) {
        // If result was just displayed, start fresh with decimal
        clear();
        displayText = '0.';
        currentInput = '0.';
        hasDecimalPoint = true;
      } else if (isOperatorPressed) {
        // Start new decimal number after operator
        displayText = '0.';
        currentInput = '0.';
        isOperatorPressed = false;
        hasDecimalPoint = true;
      } else if (!hasDecimalPoint) {
        // Add decimal point to current number if it doesn't have one
        displayText += '.';
        currentInput += '.';
        hasDecimalPoint = true;
      }
      // If decimal point already exists, do nothing
    });
  }

  // Method to handle operator button presses
  void onOperatorPressed(String op) {
    setState(() {
      if (currentInput.isNotEmpty && !isOperatorPressed) {
        if (operator.isNotEmpty && !isResultDisplayed) {
          // Chain calculations: calculate previous operation first
          calculateResult();
        } else {
          // Store first operand
          firstOperand = double.parse(currentInput);
        }
      }
      
      operator = op;
      isOperatorPressed = true;
      isResultDisplayed = false;
      hasDecimalPoint = false;
      
      // Update display to show operation
      if (firstOperand == firstOperand.toInt()) {
        displayText = '${firstOperand.toInt()} $op';
      } else {
        displayText = '$firstOperand $op';
      }
    });
  }

  // Method to calculate and display result
  void calculateResult() {
    if (operator.isEmpty || currentInput.isEmpty) return;

    setState(() {
      double secondOperand = double.parse(currentInput);
      double result = 0.0;
      String errorMessage = '';

      // Perform calculation based on operator
      switch (operator) {
        case '+':
          result = firstOperand + secondOperand;
          break;
        case '-':
          result = firstOperand - secondOperand;
          break;
        case '*':
          result = firstOperand * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            errorMessage = 'Error: Division by zero';
          } else {
            result = firstOperand / secondOperand;
          }
          break;
      }

      // Handle division by zero error
      if (errorMessage.isNotEmpty) {
        displayText = errorMessage;
        clear();
        return;
      }

      // Update display with result
      if (result == result.toInt()) {
        displayText = result.toInt().toString();
      } else {
        displayText = result.toString();
      }

      // Store result as first operand for chaining calculations
      firstOperand = result;
      currentInput = result.toString();
      operator = '';
      isResultDisplayed = true;
      hasDecimalPoint = displayText.contains('.');
    });
  }

  // Method to clear calculator (reset all values)
  void clear() {
    setState(() {
      displayText = '0';
      currentInput = '';
      operator = '';
      firstOperand = 0.0;
      isOperatorPressed = false;
      isResultDisplayed = false;
      hasDecimalPoint = false;
    });
  }

  // Method to build number buttons
  Widget buildNumberButton(String number) {
    return Expanded(
      child: Container(
        height: 70,
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => onNumberPressed(number),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            number,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  // Method to build operator buttons
  Widget buildOperatorButton(String op, {Color? color}) {
    return Expanded(
      child: Container(
        height: 70,
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => onOperatorPressed(op),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            op,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Method to build special function buttons
  Widget buildSpecialButton(String label, VoidCallback onPressed, {Color? color}) {
    return Expanded(
      child: Container(
        height: 70,
        margin: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Display Area
            Container(
              width: double.infinity,
              height: 120,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    displayText,
                    style: TextStyle(
                      fontSize: displayText.length > 12 ? 28 : 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ),

            // Button Grid
            Expanded(
              child: Column(
                children: [
                  // Row 1: Clear and operators
                  Row(
                    children: [
                      buildSpecialButton('Clear', clear, color: Colors.red.shade600),
                      buildOperatorButton('/', color: Colors.orange.shade600),
                    ],
                  ),
                  
                  // Row 2: 7, 8, 9, *
                  Row(
                    children: [
                      buildNumberButton('7'),
                      buildNumberButton('8'),
                      buildNumberButton('9'),
                      buildOperatorButton('*', color: Colors.orange.shade600),
                    ],
                  ),
                  
                  // Row 3: 4, 5, 6, -
                  Row(
                    children: [
                      buildNumberButton('4'),
                      buildNumberButton('5'),
                      buildNumberButton('6'),
                      buildOperatorButton('-', color: Colors.orange.shade600),
                    ],
                  ),
                  
                  // Row 4: 1, 2, 3, +
                  Row(
                    children: [
                      buildNumberButton('1'),
                      buildNumberButton('2'),
                      buildNumberButton('3'),
                      buildOperatorButton('+', color: Colors.orange.shade600),
                    ],
                  ),
                  
                  // Row 5: 0, ., =
                  Row(
                    children: [
                      // 0 button takes double width
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () => onNumberPressed('0'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              '0',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      // Decimal point button
                      Expanded(
                        child: Container(
                          height: 70,
                          margin: EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: onDecimalPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              '.',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // Equals button
                      buildSpecialButton('=', calculateResult, color: Colors.green.shade600),
                    ],
                  ),
                ],
              ),
            ),
            
            // Footer with instructions
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Supports decimal operations • Prevents division by zero',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



