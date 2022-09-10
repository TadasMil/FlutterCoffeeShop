import 'dart:convert';

import 'datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = response.body;
      var menuJson = jsonDecode(json) as List<dynamic>;
      _menu = menuJson.map((c) => Category.fromJson(c)).toList();
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }

    return _menu!;
  }

  addToCart(Product product) {
    bool found = false;
    var isEmpty = cart.isEmpty;

    if (isEmpty) {
      cart.add(ItemInCart(product: product, quantity: 1));
    } else {
      for (var item in cart) {
        if (item.product.id == product.id) {
          item.quantity++;
          found = true;
          break;
        }
      }

      if (!found) {
        cart.add(ItemInCart(product: product, quantity: 1));
      }
    }
  }

  removeFromCart(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
  }

  clearCart() {
    cart.clear();
  }

  double cartTotal() {
    double total = 0;

    for (var item in cart) {
      total += item.product.price * item.quantity;
    }

    return total;
  }
}
