import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert'; // For jsonDecode

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  runApp(ToggleButtonRun(theme: theme));
}

class ToggleButtonRun extends StatefulWidget {
  final ThemeData theme;
  const ToggleButtonRun({Key? key, required this.theme}) : super(key: key);

  @override
  _ToggleButtonRunState createState() => _ToggleButtonRunState();
}

class _ToggleButtonRunState extends State<ToggleButtonRun> {
  final List<bool> _selections = List.generate(3, (_) => false);

  FontWeight txtBold = FontWeight.normal;
  FontStyle txtItalic = FontStyle.normal;
  TextDecoration txtUnder = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget.theme,
      title: 'PoC Toggle Buttons',
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Toggle Buttons PoC Demo"),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(20),
                  child: ToggleButtons(
                    children: const <Widget>[
                      Icon(Icons.format_bold, size: 100),
                      Icon(Icons.format_italic, size: 100),
                      Icon(Icons.format_underlined, size: 100),
                    ],

                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() {
                        _selections[index] = !_selections[index];

                        if (index == 0 && _selections[index]) {
                          txtBold = FontWeight.bold;
                        } else if (index == 0 && !_selections[index]) {
                          txtBold = FontWeight.normal;
                        }

                        if (index == 1 && _selections[index]) {
                          txtItalic = FontStyle.italic;
                        } else if (index == 1 && !_selections[index]) {
                          txtItalic = FontStyle.normal;
                        }

                        if (index == 2 && _selections[index]) {
                          txtUnder = TextDecoration.underline;
                        } else if (index == 2 && !_selections[index]) {
                          txtUnder = TextDecoration.none;
                        }
                      });
                    },
                    // color: Colors.teal,
                    // fillColor: Colors.deepPurple,
                  )),
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "This is a demonstration and proof of concept for using toggle buttons. click/tap a button to activate it. do the same to deactivate it.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: txtBold,
                      fontStyle: txtItalic,
                      decoration: txtUnder,
                    ),
                    textAlign: TextAlign.center,
                  ))
            ],
          )),
    );
  }
}
