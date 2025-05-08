import 'package:flutter/material.dart';
import '../models/product.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> cart = [];
  List<Product> products = [
    Product(name: "Summer Dress", price: 49.99, image: "assets/images/dress1.png"),
    Product(name: "Winter Coat", price: 89.99, image: "assets/images/coat1.png"),
    Product(name: "Men Shirt", price: 29.99, image: "assets/images/shirt1.png"),
  ];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fashion Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen(cart: cart)),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    product: product,
                    onAddToCart: (prod, size) {
                      setState(() {
                        cart.add(prod); // 可拓展为带 size 的 model
                      });
                    },
                  ),
                ),
              );

            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Image.asset(product.image, width: 80),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("\$${product.price.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => addToCart(product),
                    child: Text("Add"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
