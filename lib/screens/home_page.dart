// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_new,unused_local_variable
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sih22/components/colors.dart';
import 'package:sih22/components/size_config.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _initialCameraPosition = CameraPosition(
    // target: LatLng(23.251270, 77.473770),
    target: LatLng(17.4435, 78.3772),
    zoom: 14.5,
  );
  Location currentLocation = Location();

  /// Set of displayed markers and cluster markers on the map
  final Set<Marker> _markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<MarkerId> listMarkerIds = List<MarkerId>.empty(growable: true);
  bool isSearched = false;

  late GoogleMapController _googleMapController;

  void _currentLocation() async {
    var location = await currentLocation.getLocation();

    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(location.latitude!, location.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;

    MarkerId markerId1 = MarkerId("1");
    MarkerId markerId2 = MarkerId("2");
    MarkerId markerId3 = MarkerId("3");

    listMarkerIds.add(markerId1);
    listMarkerIds.add(markerId2);
    listMarkerIds.add(markerId3);

    Marker marker1 = Marker(
      markerId: markerId1,
      position: LatLng(17.4435, 78.3772),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      infoWindow: InfoWindow(
          title: "Hytech City",
          onTap: () {
            // var bottomSheetController = scaffoldKey.currentState!
            //     .showBottomSheet((context) => Container(
            //           child: getBottomSheet("17.4435, 78.3772"),
            //           height: 250,
            //           color: Colors.transparent,
            //         ));
          },
          snippet: "Snipet Hitech City"),
    );

    Marker marker2 = Marker(
      markerId: markerId2,
      position: LatLng(17.4837, 78.3158),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    Marker marker3 = Marker(
      markerId: markerId3,
      position: LatLng(17.5169, 78.3428),
      infoWindow:
          InfoWindow(title: "Miyapur", onTap: () {}, snippet: "Miyapur"),
    );

    setState(() {
      markers[markerId1] = marker1;
      markers[markerId2] = marker2;
      markers[markerId3] = marker3;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // getLocation();
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight,
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.blockHeight * 92,
                    // Main map
                    child: GoogleMap(
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      initialCameraPosition: _initialCameraPosition,
                      onMapCreated: _onMapCreated,
                      // markers: _markers,
                      markers: Set<Marker>.of(markers.values),
                    ),
                  ),
                  Container(
                    height: SizeConfig.blockHeight * 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(left: SizeConfig.blockWidth * 8),
                          child: Icon(
                            AntIcons.userOutlined,
                            size: SizeConfig.blockWidth * 8,
                            color: COLORS.black,
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: SizeConfig.blockWidth * 8),
                          child: Icon(
                            AntIcons.funnelPlotOutlined,
                            size: SizeConfig.blockWidth * 8,
                            color: COLORS.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: SizeConfig.blockHeight * 15,
                right: SizeConfig.blockWidth * 5,
                child: InkWell(
                  onTap: () {
                    _currentLocation();
                  },
                  child: Container(
                    height: SizeConfig.blockHeight * 6,
                    width: SizeConfig.blockHeight * 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.location_on,
                      // size: SizeConfig.blockHeight * 0.4,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: SizeConfig.blockWidth * 40,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isSearched = !isSearched;
                    });
                    // getLocation();
                  },
                  child: Container(
                    height: SizeConfig.blockWidth * 20,
                    width: SizeConfig.blockWidth * 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.blockWidth * 20),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     blurRadius: 2.0,
                      //   ),
                      // ],
                    ),
                    child: Center(
                      child: (isSearched)
                          ? CircularProgressIndicator(
                              color: Colors.grey[800],
                            )
                          : Icon(
                              Icons.search,
                              size: SizeConfig.blockWidth * 8,
                              color: COLORS.black,
                            ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockHeight * 5,
                    left: SizeConfig.blockWidth * 5,
                  ),
                  height: SizeConfig.blockHeight * 8,
                  width: SizeConfig.blockWidth * 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockWidth * 76,
                        // height: SizeConfig.blockHeight * 6,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            // fontFamily: 'Rubik',
                            fontSize: SizeConfig.blockWidth * 4.5,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  // color: COLORS.black,
                                  ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  // color: COLORS.black,
                                  ),
                            ),
                            hintText: "Enter Location",
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              height: 1,
                              fontFamily: 'Rubik',
                              fontSize: SizeConfig.blockWidth * 4.3,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: SizeConfig.blockWidth * 4,
                              top: SizeConfig.blockHeight * 1.5,
                              bottom: SizeConfig.blockHeight * 1.5,
                            ),
                            // prefix: Container(
                            //   height: SizeConfig.blockHeight * 3.2,
                            //   width: SizeConfig.blockWidth * 14,
                            //   child: Icon(
                            //     Icons.search,
                            //     color: Colors.black,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockHeight * 6,
                        width: SizeConfig.blockHeight * 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          // border: Border.all(color: COLORS.black),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3.0,
                            ),
                          ],
                        ),
                        child: Icon(Icons.mic),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
