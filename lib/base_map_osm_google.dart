import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// [TypeMap] es el enum para definir el tipo de mapa
// que puede ser  de OSM o Google
enum TypeMap { osm, google }

// ignore: must_be_immutable
class BaseMapOsmGoogle extends StatelessWidget {
  // [TypeMap] es el enum para definir el tipo de map
  final TypeMap typeMap;
  //[mapCenter] variable para definir el centro del mapa,
  // es un Objeto LatLng
  LatLng? mapCenter;
  // [attrib] el parámetro para definir el Attribution del mapa
  String? attrib;
  // [initialZoom] parámetro para definir el zoom inicial del mapa
  double? initialZoom;
  // [mapController] parámetro del controller
  MapController? mapController;
  // [otherLayers] lista de las otras posibles capas para el mapa
  List<Widget>? otherLayers;

  BaseMapOsmGoogle(
      {Key? key,
      required this.typeMap,
      this.mapCenter,
      this.attrib,
      this.otherLayers,
      this.mapController,
      this.initialZoom})
      : super(key: key);

  String urlGoogle = "http://mt{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}";
  String urlOsm = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";

  @override
  Widget build(BuildContext context) {
    mapCenter = mapCenter ?? LatLng(-16.480954, -68.189594);
    otherLayers = otherLayers ?? [];
    mapController = mapController ?? MapController();
    initialZoom = initialZoom ?? 12;
    attrib = attrib ?? 'ge0tic.github.io';
    return addBaseLayer();
  }

  Widget addBaseLayer() {
    List<Widget> listLayers = [];
    MapOptions mOpts = MapOptions(
      center: mapCenter,
      maxZoom: 22,
      minZoom: 2,
    );
    listLayers.add(
      TileLayer(
        urlTemplate: typeMap == TypeMap.osm ? urlOsm : urlGoogle,
        subdomains: typeMap == TypeMap.osm ? ['a', 'b', 'c'] : [],
      ),
    );
    for (var l in otherLayers!) {
      listLayers.add(l);
    }

    return Flexible(
      child: FlutterMap(
        mapController: mapController,
        options: mOpts,
        nonRotatedChildren: [
          Atribuciones.defaultWidget(
            source: attrib.toString(),
            typeMap: typeMap,
            onSourceTapped: () {},
          )
        ],
        children: listLayers,
      ),
    );
  }
}

class Atribuciones {
  Atribuciones();
  static Widget defaultWidget({
    required String source,
    required TypeMap typeMap,
    void Function()? onSourceTapped,
    TextStyle sourceTextStyle =
        const TextStyle(color: Color(0xFF0078a8), fontSize: 10),
    Alignment alignment = Alignment.bottomLeft,
  }) =>
      Align(
        alignment: alignment,
        child: ColoredBox(
          color: const Color(0xCCFFFFFF),
          child: GestureDetector(
            onTap: onSourceTapped,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MouseRegion(
                    cursor: onSourceTapped == null
                        ? MouseCursor.defer
                        : SystemMouseCursors.click,
                    child: Text(
                      typeMap == TypeMap.osm
                          ? 'OpenStreetMap  $source'
                          : 'GoogleMap $source',
                      style: onSourceTapped == null ? null : sourceTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
