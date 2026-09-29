import 'package:flutter/material.dart';

void main() {
  runApp(const DailyUseVendingApp());
}

// ============================================================
// APP
// ============================================================

class DailyUseVendingApp extends StatelessWidget {
  const DailyUseVendingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Use Vending Machine',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorSchemeSeed: Colors.blue,
      ),
      home: const VendingMachinePage(),
    );
  }
}

// ============================================================
// PRODUCT MODEL
// ============================================================

class Product {
  final String code;
  final String name;
  final int price;
  final String image;
  int stock;

  Product({
    required this.code,
    required this.name,
    required this.price,
    required this.image,
    required this.stock,
  });
}

// ============================================================
// CART ITEM MODEL
// ============================================================

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  int get total => product.price * quantity;
}

// ============================================================
// VENDING MACHINE PAGE
// ============================================================

class VendingMachinePage extends StatefulWidget {
  const VendingMachinePage({super.key});

  @override
  State<VendingMachinePage> createState() => _VendingMachinePageState();
}

class _VendingMachinePageState extends State<VendingMachinePage> {
  // ----------------------------------------------------------
  // เครื่องเสีย
  // ----------------------------------------------------------

  bool machineError = false;

  // ----------------------------------------------------------
  // เปิด / ปิดเครื่อง
  // ----------------------------------------------------------

  bool machineOn = true;

  // ----------------------------------------------------------
  // เงิน
  // ----------------------------------------------------------

  int money = 0;

  // ----------------------------------------------------------
  // ตะกร้า
  // ----------------------------------------------------------

  final List<CartItem> cart = [];

  // ----------------------------------------------------------
  // รายการสินค้า 20 รายการ
  // ----------------------------------------------------------

  final List<Product> products = [
    Product(
      code: 'A1',
      name: 'สบู่ล้างมือ',
      price: 25,
      image: 'assets/products/soap.jpg',
      stock: 5,
    ),
    Product(
      code: 'A2',
      name: 'ทิชชู่',
      price: 20,
      image: 'assets/products/tissue.jpg',
      stock: 5,
    ),
    Product(
      code: 'A3',
      name: 'แปรงสีฟัน',
      price: 35,
      image: 'assets/products/toothbrush.jpg',
      stock: 5,
    ),
    Product(
      code: 'A4',
      name: 'เจลแอลกอฮอล์',
      price: 30,
      image: 'assets/products/hand_sanitizer.jpg',
      stock: 5,
    ),
    Product(
      code: 'A5',
      name: 'หน้ากากอนามัย',
      price: 25,
      image: 'assets/products/mask.jpg',
      stock: 5,
    ),
    Product(
      code: 'A6',
      name: 'สำลีก้าน',
      price: 20,
      image: 'assets/products/cotton_buds.jpg',
      stock: 5,
    ),
    Product(
      code: 'A7',
      name: 'สำลีแผ่น',
      price: 25,
      image: 'assets/products/cotton_pads.jpg',
      stock: 5,
    ),
    Product(
      code: 'A8',
      name: 'ยาสีฟัน',
      price: 40,
      image: 'assets/products/toothpaste.jpg',
      stock: 0,
    ),
    Product(
      code: 'A9',
      name: 'หวีพกพา',
      price: 25,
      image: 'assets/products/comb.jpg',
      stock: 5,
    ),
    Product(
      code: 'A10',
      name: 'กระจกพกพา',
      price: 30,
      image: 'assets/products/mirror.jpg',
      stock: 5,
    ),
    Product(
      code: 'A11',
      name: 'ที่เช็ดแว่น',
      price: 20,
      image: 'assets/products/glasses_cloth.jpg',
      stock: 5,
    ),
    Product(
      code: 'A12',
      name: 'ที่อุดหู',
      price: 25,
      image: 'assets/products/earplugs.jpg
      stock: 5,
    ),
    Product(
      code: 'A13',
      name: 'ผ้าเช็ดหน้า',
      price: 35,
      image: 'assets/products/handkerchief.jpg',
      stock: 5,
    ),
    Product(
      code: 'A14',
      name: 'ชุดเย็บผ้า',
      price: 45,
      image: 'assets/products/sewing_kit.jpg',
      stock: 0,
    ),
    Product(
      code: 'A15',
      name: 'ทิชชู่เปียก',
      price: 25,
      image: 'assets/products/wet_tissue.jpg',
      stock: 5,
    ),
    Product(
      code: 'A16',
      name: 'ถุงผ้า',
      price: 50,
      image: 'assets/products/tote_bag.jpg',
      stock: 5,
    ),
    Product(
      code: 'A17',
      name: 'ถุงขยะ',
      price: 20,
      image: 'assets/products/trash_bag.jpg',
      stock: 5,
    ),
    Product(
      code: 'A18',
      name: 'ร่มพกพา',
      price: 80,
      image: 'assets/products/umbrella.jpg',
      stock: 0,
    ),
    Product(
      code: 'A19',
      name: 'สเปรย์ทำความสะอาด',
      price: 45,
      image: 'assets/products/cleaning_spray.jpg',
      stock: 5,
    ),
    Product(
      code: 'A20',
      name: 'ถุงซิปล็อก',
      price: 25,
      image: 'assets/products/zip_bag.jpg',
      stock: 5,
    ),
  ];

  // ==========================================================
  // คำนวณราคารวม
  // ==========================================================

  int get cartTotal {
    int total = 0;

    for (final item in cart) {
      total += item.total;
    }

    return total;
  }

  // ==========================================================
  // จำนวนสินค้าในตะกร้า
  // ==========================================================

  int get cartCount {
    int count = 0;

    for (final item in cart) {
      count += item.quantity;
    }

    return count;
  }

  // ==========================================================
  // เพิ่มสินค้าเข้าตะกร้า
  // ==========================================================

  void selectProduct(Product product) {
    if (machineError) {
      showMessage('เครื่องเสีย ไม่สามารถเลือกสินค้าได้');
      return;
    }

    if (!machineOn) {
      showMessage('เครื่องปิดอยู่ กรุณาเปิดเครื่องก่อน');
      return;
    }

    if (product.stock <= 0) {
      showMessage('สินค้าหมด');
      return;
    }

    final existingIndex =
        cart.indexWhere((item) => item.product.code == product.code);

    if (existingIndex >= 0) {
      final item = cart[existingIndex];

      if (item.quantity >= product.stock) {
        showMessage('ไม่สามารถเลือกเกินจำนวน Stock ได้');
        return;
      }

      setState(() {
        item.quantity++;
      });
    } else {
      setState(() {
        cart.add(
          CartItem(
            product: product,
            quantity: 1,
          ),
        );
      });
    }
  }

  // ==========================================================
  // เพิ่มจำนวนสินค้า
  // ==========================================================

  void increaseQuantity(CartItem item) {
    if (machineError) {
      showMessage('เครื่องเสีย');
      return;
    }

    if (!machineOn) {
      showMessage('เครื่องปิดอยู่ กรุณาเปิดเครื่องก่อน');
      return;
    }

    if (item.quantity >= item.product.stock) {
      showMessage('จำนวนสินค้าไม่เพียงพอ');
      return;
    }

    setState(() {
      item.quantity++;
    });
  }

  // ==========================================================
  // ลดจำนวนสินค้า
  // ==========================================================

  void decreaseQuantity(CartItem item) {
    if (machineError) {
      showMessage('เครื่องเสีย');
      return;
    }

    if (!machineOn) {
      showMessage('เครื่องปิดอยู่ กรุณาเปิดเครื่องก่อน');
      return;
    }

    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        cart.remove(item);
      }
    });
  }

  // ==========================================================
  // ล้างตะกร้า
  // ==========================================================

  void clearCart() {
    if (machineError) {
      showMessage('เครื่องเสีย');
      return;
    }

    if (!machineOn) {
      showMessage('เครื่องปิดอยู่ กรุณาเปิดเครื่องก่อน');
      return;
    }

    setState(() {
      cart.clear();
    });
  }

  // ==========================================================
  // ใส่เงิน
  // ==========================================================

  void insertMoney(int amount) {
    if (machineError) {
      showMessage('เครื่องเสีย ไม่สามารถรับเงินได้');
      return;
    }

    if (!machineOn) {
      showMessage('เครื่องปิดอยู่ กรุณาเปิดเครื่องก่อน');
      return;
    }

    setState(() {
      money += amount;
    });
  }

  // ==========================================================
  // ยกเลิกและคืนเงิน
  // ==========================================================

  void cancelTransaction() {
    if (money > 0 || cart.isNotEmpty) {
      final refund = money;

      setState(() {
        cart.clear();
        money = 0;
      });

      if (refund > 0) {
        showMessage('ยกเลิกรายการ คืนเงิน $refund บาท');
      } else {
        showMessage('ยกเลิกรายการแล้ว');
      }
    } else {
      showMessage('ไม่มีรายการที่ต้องยกเลิก');
    }
  }

  // ==========================================================
  // ซื้อสินค้าทั้งหมด
  // ==========================================================

  void buyAll() {
    if (machineError) {
      showMessage('เครื่องเสีย ไม่สามารถซื้อสินค้าได้');
      return;
    }

    if (!machineOn) {
      showMessage('เครื่องปิดอยู่ กรุณาเปิดเครื่องก่อน');
      return;
    }

    if (cart.isEmpty) {
      showMessage('กรุณาเลือกสินค้าก่อน');
      return;
    }

    // ตรวจสอบ Stock อีกครั้งก่อนซื้อ
    for (final item in cart) {
      if (item.quantity > item.product.stock) {
        showMessage(
          '${item.product.name} มีสินค้าไม่เพียงพอ',
        );
        return;
      }
    }

    // ตรวจสอบเงิน
    if (money < cartTotal) {
      final needMore = cartTotal - money;

      showMessage(
        'เงินไม่พอ ต้องเพิ่มอีก $needMore บาท',
      );

      return;
    }

    final change = money - cartTotal;

    // ตัด Stock
    for (final item in cart) {
      item.product.stock -= item.quantity;
    }

    final purchasedItems = List<CartItem>.from(cart);

    final purchasedTotal = cartTotal;

    setState(() {
      cart.clear();
      money = 0;
    });

    showPurchaseSuccess(
      purchasedItems,
      purchasedTotal,
      change,
    );
  }

  // ==========================================================
  // แสดงข้อความ
  // ==========================================================

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  // ==========================================================
  // แสดงผลซื้อสำเร็จ
  // ==========================================================

  void showPurchaseSuccess(
    List<CartItem> items,
    int total,
    int change,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 8),
              Text('ซื้อสำเร็จ'),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'รายการสินค้า',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${item.product.name} x${item.quantity}',
                          ),
                        ),
                        Text(
                          '${item.total} บาท',
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'รวมทั้งหมด',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$total บาท',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('เงินทอน'),
                    Text(
                      '$change บาท',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // เปิด/ปิดโหมดเครื่องเสีย
  // ==========================================================

  void toggleMachineError() {
    setState(() {
      machineError = !machineError;
    });

    if (machineError) {
      showMessage('เครื่องเสีย กรุณาติดต่อเจ้าหน้าที่');
    } else {
      showMessage('เครื่องกลับมาใช้งานได้แล้ว');
    }
  }

  // ==========================================================
  // เปิด / ปิดเครื่อง
  // ==========================================================

  void toggleMachine() {
    setState(() {
      machineOn = !machineOn;
    });

    if (machineOn) {
      showMessage('เปิดเครื่องแล้ว พร้อมให้บริการ');
    } else {
      showMessage('ปิดเครื่องแล้ว');
    }
  }

  // ==========================================================
  // สร้างการ์ดสินค้า
  // ==========================================================

  Widget buildProductCard(Product product) {
    final cartItemIndex =
        cart.indexWhere((item) => item.product.code == product.code);

    final selectedQuantity = cartItemIndex >= 0
        ? cart[cartItemIndex].quantity
        : 0;

    final isSoldOut = product.stock <= 0;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: machineError || !machineOn || isSoldOut
            ? null
            : () {
                selectProduct(product);
              },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // รูปสินค้า
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 45,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // รหัสสินค้า
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.code,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  // ชื่อสินค้า
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 3),

                  // ราคา
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${product.price} บาท',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 3),

                  // Stock
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isSoldOut
                          ? 'สินค้าหมด'
                          : 'เหลือ ${product.stock} ชิ้น',
                      style: TextStyle(
                        color: isSoldOut
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  if (selectedQuantity > 0)
                    Container(
                      margin:
                          const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        'เลือกแล้ว $selectedQuantity ชิ้น',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ป้ายสินค้าหมด
            if (isSoldOut)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.75),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'สินค้าหมด',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // ป้ายเครื่องเสีย
            if (machineError)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.45),
                  child: const Center(
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ),

            // ป้ายเครื่องปิด
            if (!machineOn)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.45),
                  child: const Center(
                    child: Text(
                      'เครื่องปิดอยู่',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // ตะกร้า
  // ==========================================================

  Widget buildCartPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.blue,
                  size: 28,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'ตะกร้าสินค้า',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$cartCount ชิ้น',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Divider(height: 25),

            // รายการในตะกร้า
            Expanded(
              child: cart.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 55,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'ยังไม่มีสินค้าในตะกร้า',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: cart.length,
                      separatorBuilder:
                          (context, index) =>
                              const Divider(),
                      itemBuilder: (context, index) {
                        final item = cart[index];

                        return Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:
                                    Colors.grey.shade100,
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                item.product.image,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (context, error,
                                        stackTrace) {
                                  return const Icon(
                                    Icons.image,
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 8),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    maxLines: 1,
                                    overflow:
                                        TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${item.total} บาท',
                                    style: TextStyle(
                                      color: Colors
                                          .grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: machineError || !machineOn
                                  ? null
                                  : () {
                                      decreaseQuantity(
                                          item);
                                    },
                              icon: const Icon(
                                Icons.remove_circle,
                              ),
                              color: Colors.red,
                            ),

                            Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: machineError || !machineOn
                                  ? null
                                  : () {
                                      increaseQuantity(
                                          item);
                                    },
                              icon: const Icon(
                                Icons.add_circle,
                              ),
                              color: Colors.green,
                            ),
                          ],
                        );
                      },
                    ),
            ),

            const Divider(height: 20),

            // ยอดรวม
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ราคารวม',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '$cartTotal บาท',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // เงินที่ใส่
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'เงินที่ใส่',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$money บาท',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ปุ่มใส่เงิน
            Wrap(
              spacing: 6,
              runSpacing: 6,
              alignment: WrapAlignment.center,
              children: [
                moneyButton(1),
                moneyButton(5),
                moneyButton(10),
                moneyButton(20),
                moneyButton(50),
                moneyButton(100),
              ],
            ),

            const SizedBox(height: 12),

            // ซื้อทั้งหมด
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: machineError || !machineOn
                    ? null
                    : () {
                        buyAll();
                      },
                icon: const Icon(
                  Icons.shopping_cart_checkout,
                ),
                label: const Text(
                  'ซื้อสินค้าทั้งหมด',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ล้างตะกร้า + ยกเลิก
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: machineError || !machineOn
                        ? null
                        : () {
                            clearCart();
                          },
                    child: const Text(
                      'ล้างตะกร้า',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      cancelTransaction();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text(
                      'ยกเลิก / คืนเงิน',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // ปุ่มเงิน
  // ==========================================================

  Widget moneyButton(int amount) {
    return OutlinedButton(
      onPressed: machineError || !machineOn
          ? null
          : () {
              insertMoney(amount);
            },
      child: Text(
        '$amount',
      ),
    );
  }

  // ==========================================================
  // แผงควบคุมเครื่อง
  // ==========================================================

  Widget buildMachineStatus() {
    return Column(
      children: [
        // Display
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.grey.shade700,
              width: 3,
            ),
          ),
          child: Column(
            children: [
              Text(
                machineError
                    ? 'MACHINE ERROR'
                    : !machineOn
                        ? 'MACHINE OFF'
                        : 'READY',
                style: TextStyle(
                  color: machineError
                      ? Colors.red
                      : !machineOn
                          ? Colors.orange
                          : Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                machineError
                    ? 'เครื่องขัดข้อง'
                    : !machineOn
                        ? 'เครื่องปิดอยู่'
                        : 'พร้อมให้บริการ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ปุ่มเครื่องเสีย
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: toggleMachineError,
            icon: Icon(
              machineError
                  ? Icons.build
                  : Icons.warning_amber_rounded,
            ),
            label: Text(
              machineError
                  ? 'เปิดเครื่องกลับมาใช้งาน'
                  : 'เครื่องเสีย',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  machineError
                      ? Colors.green
                      : Colors.red,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // ==========================================================
        // ปุ่มเปิด / ปิดเครื่อง
        // ==========================================================

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: toggleMachine,
            icon: Icon(
              machineOn
                  ? Icons.power_settings_new
                  : Icons.power_off,
            ),
            label: Text(
              machineOn
                  ? 'ปิดเครื่อง'
                  : 'เปิดเครื่อง',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  machineOn ? Colors.orange : Colors.green,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        if (machineError) ...[
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'เครื่องขัดข้อง กรุณาติดต่อเจ้าหน้าที่',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef3f8),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.storefront),
            SizedBox(width: 10),
            Text(
              'Daily Use Vending Machine',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '20 PRODUCTS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 950;

            if (isWide) {
              return Row(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  // ------------------------------------------------
                  // ฝั่งสินค้า
                  // ------------------------------------------------
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          buildMachineStatus(),

                          const SizedBox(height: 15),

                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.72,
                              ),
                              itemCount: products.length,
                              itemBuilder:
                                  (context, index) {
                                return buildProductCard(
                                  products[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ------------------------------------------------
                  // ฝั่งตะกร้า
                  // ------------------------------------------------
                  SizedBox(
                    width: 390,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        18,
                        18,
                        18,
                      ),
                      child: buildCartPanel(),
                    ),
                  ),
                ],
              );
            }

            // ------------------------------------------------------
            // หน้าจอเล็ก
            // ------------------------------------------------------

            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  buildMachineStatus(),

                  const SizedBox(height: 15),

                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          constraints.maxWidth > 600
                              ? 3
                              : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return buildProductCard(
                        products[index],
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 650,
                    child: buildCartPanel(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
