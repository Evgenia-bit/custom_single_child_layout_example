import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _offsetX = 0.0;
  var _offsetY = 0.0;

  @override
  Widget build(BuildContext context) {
    const parentSize = Size(300, 500.0);
    const childHeigth = 100.0;
    final childSize = Size(
      childHeigth,
      childHeigth * parentSize.height / parentSize.width,
    );

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Center(
                child: ColoredBox(
                  color: Colors.lightBlue,
                  child: CustomSingleChildLayout(
                    delegate: _Delegate(
                      parentSize: parentSize,
                      childOffset: Offset(_offsetX, _offsetY),
                      childSize: childSize,
                    ),
                    child: const ColoredBox(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Slider(
                value: _offsetX,
                onChanged: (value) => setState(() => _offsetX = value),
                min: 0,
                max: parentSize.width - childSize.width,
              ),
              const SizedBox(height: 20),
              Slider(
                value: _offsetY,
                onChanged: (value) => setState(() => _offsetY = value),
                min: 0,
                max: parentSize.height - childSize.height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Delegate extends SingleChildLayoutDelegate {
  final Size parentSize;
  final Offset childOffset;
  final Size childSize;

  _Delegate({
    required this.parentSize,
    required this.childOffset,
    required this.childSize,
  });

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return this != oldDelegate;
  }

  @override
  Size getSize(BoxConstraints constraints) => parentSize;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.tight(childSize);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return childOffset;
  }
}
