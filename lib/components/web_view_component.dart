import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  final String url;
  const WebViewComponent({super.key, required this.url});

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) {
          // 页面加载完成后发送消息示例
          sendMessageToWeb();
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  // 向网页发送消息的方法
  void sendMessageToWeb() {
    final message = {
      'header': {
        'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjg4ODQ3OTgsInZlcnNpb24iOjQsImV4cCI6MTczNTI5NjIzMSwibmJmIjoxNzM1MjA5ODMxLCJpYXQiOjE3MzUyMDk4MzF9.PTrjgKaD83Io_bfVf9eoMHPJsPbuVfx0E1tMd6flelc",
        'countryCode': "CN",
        'deviceId': "c362e4ceee33f722d443ffd751bcfe44",
        'language': "en",
        'operationId': "0445978b1371b91a36c23dffc737acbf",
        'platform': "h5",
        'refreshToken': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjg4ODQ3OTgsInZlcnNpb24iOjQsImV4cCI6MTczNTgxNDYzMSwibmJmIjoxNzM1MjA5ODMxLCJpYXQiOjE3MzUyMDk4MzF9.KaFeXUgvbtkKxXIakOP4QEUJiYVepNEqllaKbs-8ShA",
        'timeZone': "Asia/Shanghai"
      }
  };
    controller.runJavaScript(
      'window.postMessage(${jsonEncode(message)}, "*")',
    );
  }

  // 从网页接收消息的方法
  void _onMessageReceived(JavaScriptMessage message) {
    debugPrint('收到网页消息: ${message.message}');
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller..addJavaScriptChannel(
        'Flutter',
        onMessageReceived: _onMessageReceived,
      ),
    );
  }
} 