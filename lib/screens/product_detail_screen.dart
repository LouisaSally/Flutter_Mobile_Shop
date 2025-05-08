import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Function(Product, String) onAddToCart;

  const ProductDetailScreen({required this.product, required this.onAddToCart});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedSize;

  void showWarning(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Notice"),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK", style: TextStyle(color: Colors.pink)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void handleAdd() {
    if (selectedSize == null) {
      showWarning("Please select a size before adding to cart.");
    } else {
      widget.onAddToCart(widget.product, selectedSize!);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Added to cart 💖"),
          actions: [
            TextButton(
              child: Text("OK", style: TextStyle(color: Colors.pink)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(product.image, height: 200),
            SizedBox(height: 20),
            Text(product.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("\$${product.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Select Size:", style: TextStyle(fontSize: 16)),
                SizedBox(width: 20),
                DropdownButton<String>(
                  value: selectedSize,
                  hint: Text("Choose"),
                  items: ["S", "M", "L"].map((size) {
                    return DropdownMenuItem(value: size, child: Text(size));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: handleAdd,
              child: Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
