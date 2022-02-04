// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // TODO: Make a collection of cards (102)
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products =
        ProductsRepository.loadProducts(Category.all); // all products

    if (products.isEmpty) {
      // if no products
      return const <Card>[]; // empty array
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Column(
          // TODO: Center items on the card (103)
          // TODO: Center items on the card (103)
          crossAxisAlignment:
              CrossAxisAlignment.center, // align to the leading edge (left)
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 /
                  11.0, // what shape the image takes no matter what kind of image is supplied
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                // TODO: Adjust the box size (102)
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0,
                    8.0), // brings the text in from the side a little.

                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // TODO: Change innermost Column (103)
                  children: <Widget>[
                    // TODO: Handle overflowing labels (103)
                    Text(
                      product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      // removed const
      // TODO: Add app bar (102)
      appBar: AppBar(
        // TODO: Add buttons and title (102)
        title: const Text('SHRINE'),
        leading: IconButton(
          // leading = left, trailing = right
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        // TODO: Add trailing buttons (102)
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print('Search button');
              },
              icon: const Icon(
                Icons.search,
                semanticLabel: 'search', // accessibility
              )),
          IconButton(
            icon: const Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      // TODO: Add a grid view (102)
      body: GridView.count(
          // .count constructor for displaying a finite number of items
          crossAxisCount: 2, // 2 columns (non-scrolling axis)
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 /
              9.0, // identifies the size of the items based on an aspect ratio (width over height)
          // TODO: Build a grid of cards (102)
          // card's size is width = width of the grid - padding(left+right) / columns(2)
          // height = card's width * 9/8 (childAspectRatio flipped)
          children: _buildGridCards(context)),
      // TODO: Set resizeToAvoidBottomInset (101)
      resizeToAvoidBottomInset:
          false, // ensures that the keyboard's appearance does not alter the size of the home page or its widgets.
    );
  }
}
