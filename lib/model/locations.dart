import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

//part 'locations.g.dart';

class Locations {
  List<Offices> offices;
  List<Regions> regions;

  Locations({this.offices, this.regions});

  Locations.fromJson(Map<String, dynamic> json) {
    if (json['offices'] != null) {
      offices = new List<Offices>();
      json['offices'].forEach((v) {
        offices.add(new Offices.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      regions = new List<Regions>();
      json['regions'].forEach((v) {
        regions.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offices != null) {
      data['offices'] = this.offices.map((v) => v.toJson()).toList();
    }
    if (this.regions != null) {
      data['regions'] = this.regions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offices {
  String address;
  String id;
  String image;
  var lat;
  var lng;
  String name;
  String phone;
  String region;

  Offices(
      {this.address,
      this.id,
      this.image,
      this.lat,
      this.lng,
      this.name,
      this.phone,
      this.region});

  Offices.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    phone = json['phone'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['region'] = this.region;
    return data;
  }
}

class Regions {
  Coords coords;
  String id;
  String name;
  var zoom;

  Regions({this.coords, this.id, this.name, this.zoom});

  Regions.fromJson(Map<String, dynamic> json) {
    coords =
        json['coords'] != null ? new Coords.fromJson(json['coords']) : null;
    id = json['id'];
    name = json['name'];
    zoom = json['zoom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coords != null) {
      data['coords'] = this.coords.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['zoom'] = this.zoom;
    return data;
  }
}

class Coords {
  var lat;
  var lng;

  Coords({this.lat, this.lng});

  Coords.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

/*@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class Region {
  Region({
    this.coords,
    this.id,
    this.name,
    this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Office {
  Office({
    this.address,
    this.id,
    this.image,
    this.lat,
    this.lng,
    this.name,
    this.phone,
    this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({
    this.offices,
    this.regions,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
  final List<Region> regions;
}*/

Locations data;

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  final response = await http.get(googleLocationsURL);
  if (response.statusCode == 200) {
    var decodeJson = jsonDecode(response.body);
    data = Locations.fromJson(decodeJson);
//    data.offices.map((f) => print(f.name)).toList();
    return Locations.fromJson(jsonDecode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
        ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
