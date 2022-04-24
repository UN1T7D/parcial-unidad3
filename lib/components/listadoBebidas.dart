import 'package:flutter/material.dart';

List<Widget> listadoBebidas(data) {
  List<Widget> bebidas = [];
  for (var item in data) {
    bebidas.add(Card(
      elevation: 0,
      color: Colors.black12,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(item.strDrinkThumb),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ]),
            child: Container(
              padding: EdgeInsets.all(5),
              width: 200,
              child: Text(
                item.strDrink,
                style: TextStyle(
                  backgroundColor: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return bebidas;
}
