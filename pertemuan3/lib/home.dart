import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  final Category category;

  const HomePage({this.category = Category.all, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Warna Pastel yang digunakan (ganti sesuai keinginan)
    Color pastelColor = Color(0xFF64CCC5); // Contoh warna pastel

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: pastelColor, // Ganti warna background app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          color: pastelColor.withOpacity(0.5), // Ganti warna background page
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: ProductsRepository.loadProducts(category).length,
          itemBuilder: (context, index) {
            final product = ProductsRepository.loadProducts(category)[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullScreenImagePage(product: product),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: 'product_${product.id}',
                      child: AspectRatio(
                        aspectRatio: 18 / 11,
                        child: Image.asset(
                          product.assetName,
                          package: product.assetPackage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.category.toString(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final Product product;

  const FullScreenImagePage({required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'product_${product.id}',
                child: Image.asset(
                  product.assetName,
                  package: product.assetPackage,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8.0),
              Text(
                formatter.format(product.price),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
