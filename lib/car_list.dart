import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'car_details.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<dynamic> cars = [];
  List<dynamic> originalCars = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final response = await http.get(Uri.parse('http://45.87.173.234:10/car'));
    if (response.statusCode == 200) {
      setState(() {
        cars = json.decode(response.body)['cars'];
        originalCars = List.from(cars);
      });
    }
  }

  void searchCars(String query) {
    List<dynamic> searchResults = originalCars.where((car) {
      final title = car['title'].toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    setState(() {
      cars = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000'),
                  radius: 25.0,
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: Text(
                            'Welcome👋',
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Shahinur Rahman',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(
                  width: 110,
                ),
                Icon(Icons.notifications_off_outlined)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Your Car',
                        ),
                        onChanged: (query) {
                          searchCars(query);
                        },
                      ),
                    ),
                  ),
                ),
                Icon(Icons.tune)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://e0.pxfuel.com/wallpapers/145/566/desktop-wallpaper-tesla-logo-on-black-a-tesla-logo-i-madetraced-from-origio.jpg'),
                      radius: 30.0,
                    ),
                    SizedBox(height: 8),
                    Text('TESLA')
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/736x/41/69/37/41693710d7a8fa5ffe3399be78c4a5e2.jpg'),
                      radius: 30.0,
                    ),
                    SizedBox(height: 8),
                    Text('MERCEDES')
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://c8.alamy.com/zooms/9/39e52a3de7f544b6bacacc35a93bcdd7/2jj4b1n.jpg'),
                      radius: 30.0,
                    ),
                    SizedBox(height: 8),
                    Text('BMW')
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/020/500/327/non_2x/ferrari-logo-brand-car-symbol-with-name-design-italian-automobile-illustration-with-black-background-free-vector.jpg'),
                      radius: 30.0,
                    ),
                    SizedBox(height: 8),
                    Text('FERRARI')
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Text(
                  'POPULAR CAR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 20),
                child: Text('VIew All'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (cars.length / 2).ceil(),
              itemBuilder: (BuildContext context, int index) {
                final firstCarIndex = index * 2;
                final secondCarIndex = firstCarIndex + 1;
                List<Widget> carWidgets = [];

                carWidgets.add(
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CarDetailsPage(car: cars[firstCarIndex]),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              cars[firstCarIndex]['image'],
                              width: 150.0,
                              height: 150.0,
                            ),
                          ),
                          Text(
                            cars[firstCarIndex]['title'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            '\$${cars[firstCarIndex]['price']}',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                if (secondCarIndex < cars.length) {
                  carWidgets.add(
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                CarDetailsPage(car: cars[secondCarIndex]),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Container(
                              child: ClipOval(
                                child: Image.network(
                                  cars[secondCarIndex]['image'],
                                  width: 150.0,
                                  height: 150.0,
                                ),
                              ),
                            ),
                            Text(
                              cars[secondCarIndex]['title'],
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              '\$${cars[secondCarIndex]['price']}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: carWidgets,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
