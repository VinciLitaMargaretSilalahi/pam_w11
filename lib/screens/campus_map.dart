
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class _Place {
  final String name;
  final LatLng point;

  const _Place(this.name, this.point);
}

// Koordinat perkiraan area Institut Teknologi Del.
// Sesuaikan dengan titik lokasi sebenarnya.
const _places = [
  _Place(
    'Institut Teknologi Del',
    LatLng(2.384957, 99.148028),
  ),
  _Place(
    'Gedung Perkuliahan',
    LatLng(2.385300, 99.148500),
  ),
  _Place(
    'Area Kampus',
    LatLng(2.384500, 99.147500),
  ),
];

class CampusMap extends StatelessWidget {
  const CampusMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _places.first.point,
        initialZoom: 17,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.pam_notes',
        ),

        MarkerLayer(
          markers: _places.map((place) {
            return Marker(
              point: place.point,
              width: 150,
              height: 60,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(place.name),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        place.name,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              '© OpenStreetMap contributors',
            ),
          ],
        ),
      ],
    );
  }
}
