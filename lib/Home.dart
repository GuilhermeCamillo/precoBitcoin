import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _precoBit = "0";

  void _recuperarPreco() async {
    var url = Uri.parse("https://blockchain.info/ticker");
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _precoBit = retorno["BRL"]["buy"].toString();
    });


    //print("Resultado: " + retorno["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset("images/bitcoin.png")),
              Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "R\$ " + _precoBit,
                    style: TextStyle(fontSize: 26),
                  )),
              RaisedButton(
                  color: Colors.orange,
                  child: Text(
                    "Atualizar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  onPressed: _recuperarPreco)
            ],
          )),
    );
  }
}
