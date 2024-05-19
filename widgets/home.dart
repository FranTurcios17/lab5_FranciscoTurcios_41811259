import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:s5_lab/Types/launch.dart';

class MyOwnWidget extends StatefulWidget {
  const MyOwnWidget({super.key});

  @override
  State<MyOwnWidget> createState() => _MyOwnWidgetState();
}

class _MyOwnWidgetState extends State<MyOwnWidget> {
  @override

  List <Launch> launches = [];
  //Map launchMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async
  {
    print('se estan obteniendo los datos');
    String url = 'https://api.spacexdata.com/v5/launches';
    var response = await http.get(Uri.parse(url));

    
    

    if(response.statusCode == 200)
    {
      
        launches = launchFromJson(response.body);
        //launches = json.decode(response.body) as List<Launch>;
        setState(() {
          
        });
        print('se obtuvieron con exito');
    }
    else
    {
        print('no pudimos tener una respuesta de la API');
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Space API'),
      ),

      body: (launches.isEmpty) ? const Center(child: Text('no se pudieron conseguir los datos'),) : ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index)
        {
          return  ListTile(
              title: Text('Mision: ${launches[index].name}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Fecha de lanzamiento: ${launches[index].dateLocal}'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Estado: ${launches[index].details}'),
                  ),
                ],
              ),
              leading: Icon(Icons.abc_rounded),
          );
        },
        )
    );
  }
}