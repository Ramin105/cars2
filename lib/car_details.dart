import 'package:flutter/material.dart';

class CarDetailsPage extends StatelessWidget {
  final dynamic car;

  CarDetailsPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['title']),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(car['image']),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 270),
                  child: Text(
                    '${car['title']}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 580, left: 10),
                  child: Text(
                    'Price:',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 600, left: 10),
                  child: Text(
                    '\$${car['price']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 310, left: 10),
                  child: Text(
                    '${car['description']}',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
