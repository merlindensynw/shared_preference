import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sp(),
    );
  }
}

class Sp extends StatefulWidget {
  Sp({super.key});

  @override
  State<Sp> createState() => _SpState();
}

class _SpState extends State<Sp> {
  final SharedAction sp = SharedAction();
  String value = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSp() ;
  }

  Future<void> initSp() async {
    await sp.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(45.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  sp.addString();
                },
                child: Text('add String'),
              ),
              ElevatedButton(
                onPressed: () {
                  sp.addInt();
                },
                child: Text('add int'),
              ),
              ElevatedButton(
                onPressed: () {
                  sp.addBoolean();
                },
                child: Text('add boolean'),
              ),
              ElevatedButton(
                onPressed: () {
                  sp.addDouble();
                },
                child: Text('add double'),
              ),
              ElevatedButton(
                onPressed: () async {
                  value = (await sp.getBoolValuesSF()).toString() ?? "";
                  setState(() {});
                },
                child: Text('get bool'),
              ),
              ElevatedButton(
                onPressed: () async {
                  value = (await sp.getDoubleValuesSF()).toString() ?? '';
                  setState(() {});
                },
                child: Text('get double'),
              ),
              ElevatedButton(
                onPressed: () async {
                  value = (await sp.getIntValuesSF()).toString() ?? '';
                  setState(() {});
                },
                child: Text('get int'),
              ),
              ElevatedButton(
                onPressed: () async {
                  value = await sp.getStringValuesSF() ?? '';
                  setState(() {});
                },
                child: Text('get string'),
              ),
              Text(value.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class SharedAction {
  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  addString() async {
    prefs.setString('stringvalue', 'abc');
  }

  addInt() async {
    prefs.setInt('intvalue', 123);
  }

  addDouble() async {
    prefs.setDouble('doublevalue', 22.22);
  }

  addBoolean() async {
    prefs.setBool('boolvalue', false);
  }

  Future<String?> getStringValuesSF() async {
    //Return String
    String? stringValue = prefs.getString('stringvalue');
    return stringValue;
  }

  Future<bool?> getBoolValuesSF() async {
    //Return bool
    bool? boolValue = prefs.getBool('boolvalue');
    return boolValue;
  }

  Future<int?> getIntValuesSF() async {
    //Return int
    int? intValue = prefs.getInt('intvalue');
    return intValue;
  }

  Future<double?> getDoubleValuesSF() async {
    //Return double
    double? doubleValue = prefs.getDouble('doublevalue');
    return doubleValue;
  }
}
