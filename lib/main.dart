import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:parcial_unidad_3/models/Bebidas.dart';
import 'package:http/http.dart' as http;
import 'components/listadoBebidas.dart';

void main() {
  runApp(ParcialUnidad3());
}

class ParcialUnidad3 extends StatefulWidget {
  @override
  State<ParcialUnidad3> createState() => _ParcialUnidad3State();
}

class _ParcialUnidad3State extends State<ParcialUnidad3> {
  late Future<List<Bebidas>> _listadoBebidas;

  Future<List<Bebidas>> _getBebidas() async {
    final response = await http.get(Uri.parse(
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final jsonBebidas = jsonResponse['drinks'];
      List<Bebidas> lista = [];
      for (var item in jsonBebidas) {
        lista.add(
            Bebidas(item["strDrink"], item["strDrinkThumb"], item["idDrink"]));
      }
      return lista;
    } else {
      throw Exception('Failed to load Bebidas');
    }
  }

  void initState() {
    super.initState();
    _listadoBebidas = _getBebidas();
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: _listadoBebidas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: listadoBebidas(snapshot.data),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("Error");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PARCIAL UNIDAD III',
      home: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            backgroundColor: Colors.black12,
            title: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bebidas alcohólicas",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://th.bing.com/th/id/OIP.qwt3hK5jPKJZq5iV_b0ERAHaEx?pid=ImgDet&rs=1"),
                    radius: 20,
                  )
                ],
              ),
            ),
          ),
          body: futureBuilder),
    );
  }
}
