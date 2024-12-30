import 'package:flutter/material.dart';
import '../components/web_view_component.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Demo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const WebViewComponent(
        url: 'https://dev-activityh5.sadpekiti.com/#/first-popup',
      ),
    );
  }
} 