import 'package:calculator_application/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String inputText = '';
  String resultText = '0';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kBgDarkColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: kBgDarkColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 16),
                      Center(
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: kKeyBgDarkColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.light_mode_outlined,
                                color: kWhiteColor.withOpacity(.5),
                              ),
                              Icon(
                                Icons.dark_mode_outlined,
                                color: kWhiteColor.withOpacity(1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          inputText,
                          style: TextStyle(
                            fontSize: 32,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          resultText,
                          style: TextStyle(
                            fontSize: 52,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: kKeyBgDarkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(42),
                      topRight: Radius.circular(42),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 1),
                      _getKeysRow('AC', 'CE', '%', '/', kActionCyanColor),
                      _getKeysRow('7', '8', '9', '*', kWhiteColor),
                      _getKeysRow('4', '5', '6', '-', kWhiteColor),
                      _getKeysRow('1', '2', '3', '+', kWhiteColor),
                      _getKeysRow('00', '0', '.', '=', kWhiteColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buttonPressed({required text}) {
    setState(() {
      inputText = inputText + text;
    });
  }

  _getKeysRow(
      String text1, String text2, String text3, String text4, Color textC) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            elevation: 0,
            backgroundColor: kBgDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            if (text1 == 'AC') {
              setState(() {
                inputText = '';
                resultText = '0';
              });
            } else
              (_buttonPressed(text: text1));
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text1,
                style: TextStyle(
                  color: textC,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            elevation: 0,
            backgroundColor: kBgDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            if (text2 == 'CE') {
              if (inputText.length > 0)
                setState(() {
                  inputText = inputText.substring(0, inputText.length - 1);
                });
            } else
              (_buttonPressed(text: text2));
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text2,
                style: TextStyle(
                  color: textC,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            elevation: 0,
            backgroundColor: kBgDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            _buttonPressed(text: text3);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text3,
                style: TextStyle(
                  color: textC,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            elevation: 0,
            backgroundColor: kBgDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            if (text4 == '=') {
              Parser parser = Parser();
              Expression expression = parser.parse(inputText);
              ContextModel contextModel = ContextModel();
              double evaluation =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                resultText = evaluation.toString();
              });
            } else
              (_buttonPressed(text: text4));
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text4,
                style: TextStyle(
                  color: kActionRedColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
