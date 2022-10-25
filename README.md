# Base Map Osm Google

## Capturas

|[<img src="https://raw.githubusercontent.com/danielquisbert/base_map_osm_google/main/images/google.png" width="150" />](https://github.com/danielquisbert/base_map_osm_google)|[<img src="https://raw.githubusercontent.com/danielquisbert/base_map_osm_google/main/images/osm.png" width="150" />](https://github.com/danielquisbert/base_map_osm_google)|




## Forma de uso

Crear un nuevo proyecto y agregar el package

```dart
import 'package:base_map_osm_google/base_map_osm_google.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basemap OSM Google',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ejemplo Base Map OSM - Google'),
        ),
        body: Column(
          children: [
            BaseMapOsmGoogle(typeMap: TypeMap.osm),
          ],
        ),
      ),
    );
  }
}

```