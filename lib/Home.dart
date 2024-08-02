// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userInput = "";
  String Result = "0";
  List<String> buttonList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    'DEL',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height / 2.9,
              child: result(),
            ),
            Expanded(child: buttonWidget()),
          ],
        ),
      ),
    );
  }

  Widget result() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            userInput,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          Text(
            Result,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: buttonList.length,
        itemBuilder: (context, index) {
          return button(buttonList[index]);
        },
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "*" ||
        text == "(" ||
        text == ")") {
      return const Color.fromARGB(255, 163, 39, 30);
    }
    if (text == "=" || text == "DEL") {
      return Colors.white;
    }
    return Colors.indigo;
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handlePress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBGcolor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getBGcolor(String text) {
    if (text == "DEL") {
      return Colors.red;
    }
    if (text == "=") {
      return const Color.fromARGB(255, 122, 219, 125);
    }
    return Colors.white;
  }

  void handlePress(String text) {
    if (text == "DEL") {
      setState(() {
        userInput = "";
        Result = "0";
      });
      return;
    }

    if (text == "C") {
      setState(() {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      });
      return;
    }

    if (text == "=") {
      setState(() {
        Result = calculate();
        userInput = Result;
        if (userInput.endsWith(".0")) {
          userInput = userInput.replaceAll(".0", "");
        }
        if (Result.endsWith(".0")) {
          Result = Result.replaceAll(".0", "");
        }
      });
      return;
    }

    setState(() {
      userInput += text;
    });
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var final_result = exp.evaluate(EvaluationType.REAL, ContextModel());
      return final_result.toString();
    } catch (e) {
      return "Error";
    }
  }
}
