import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dot_info.dart';
import '../utils/drawing_provider.dart';

class PromiseScreen extends StatefulWidget {
  // 그림판 기능 구현, 선 두께 & 색 변경 가능
  const PromiseScreen({Key? key}) : super(key: key);

  @override
  State<PromiseScreen> createState() => _PromiseScreenState();
}

class _PromiseScreenState extends State<PromiseScreen> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DrawingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Promise Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                    child: CustomPaint(
                  painter: DrawingPainter(
                    p.lines,
                  ),
                )),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onPanStart: (s) {
                    if (p.eraseMode) {
                      p.erase(s.localPosition);
                    } else {
                      p.drawStart(s.localPosition);
                    }
                  },
                  onPanUpdate: (s) {
                    if (p.eraseMode) {
                      p.erase(s.localPosition);
                    } else {
                      p.drawing(s.localPosition);
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[900],
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _colorWidget(Colors.black),
                      _colorWidget(Colors.red),
                      _colorWidget(Colors.yellow),
                      _colorWidget(Colors.green),
                      _colorWidget(Colors.blue),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 5,
                        ),
                        child: Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                          value: p.size,
                          onChanged: (size) {
                            p.changeSize = size;
                          },
                          min: 3,
                          max: 15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        p.changeEraseMode();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          '지우개',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight:
                                p.eraseMode ? FontWeight.w900 : FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        p.print_value();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          '출력',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight:
                                p.eraseMode ? FontWeight.w900 : FontWeight.w300,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorWidget(Color color) {
    var p = Provider.of<DrawingProvider>(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        p.changeColor = color;
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: p.color == color
              ? Border.all(
                  color: Colors.white,
                  width: 4,
                )
              : null,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter(this.lines);
  final List<List<DotInfo>> lines;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    for (var oneLine in lines) {
      Color? color;
      double? size;
      var l = <Offset>[];
      var p = Path();

      for (var oneDot in oneLine) {
        color ??= oneDot.color;
        size ??= oneDot.size;
        l.add(oneDot.offset);
      }
      p.addPolygon(l, false);
      canvas.drawPath(
          p,
          Paint()
            ..color = color!
            ..strokeWidth = size!
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
