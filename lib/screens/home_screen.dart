import 'package:ecommtest/controllers/product_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());
  final List categories = [
    "T-Shirt",
    "Pants",
    "Jeans",
    "Jackets",
    "Shirt",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildTop(),
            _buildCategoriesRow(),
            Expanded(child: Obx((() {
              if (productsController.loading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (productsController.products.isEmpty) {
                return Center(
                  child: Text("No Products Found"),
                );
              }

              if (productsController.showGrid.value) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemCount: productsController.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 0,
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.only(bottom: 8),
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      productsController.products[index]
                                          ['image'],
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productsController.products[index]
                                          ["title"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        productsController.products[index]
                                            ['description'],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                        "\$${productsController.products[index]['price']}"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return _buildProductsList();
            }))),
          ],
        ),
      ),
    );
  }

  ListView _buildProductsList() {
    return ListView.builder(
      itemCount: productsController.products.length,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: ((context, index) => Card(
            elevation: 0,
            child: Container(
              height: 150,
              padding: EdgeInsets.only(bottom: 8),
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                          image: NetworkImage(
                            productsController.products[index]['image'],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsController.products[index]["title"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              productsController.products[index]['description'],
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                              "\$${productsController.products[index]['price']}"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Row _buildTop() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cloths",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            productsController.toggleGrid();
          },
          icon: Icon(Icons.filter_list),
        ),
      ],
    );
  }

  Container _buildCategoriesRow() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index == 0 ? Colors.black87 : Colors.transparent),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            categories[index],
            style: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      leading: BackButton(),
      elevation: 0,
      title: Text(
        'E-bazar',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }
}
