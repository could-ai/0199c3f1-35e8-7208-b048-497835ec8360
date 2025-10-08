import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kling AI Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      home: const KlingHomePage(),
    );
  }
}

class KlingHomePage extends StatefulWidget {
  const KlingHomePage({super.key});

  @override
  State<KlingHomePage> createState() => _KlingHomePageState();
}

class _KlingHomePageState extends State<KlingHomePage> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  bool _videoGenerated = false;

  Future<void> _generateVideo() async {
    if (_promptController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a prompt to generate video.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _videoGenerated = false;
    });

    // Simulate a network call to an AI video generation service
    await Future.delayed(const Duration(seconds: 4));

    setState(() {
      _isLoading = false;
      _videoGenerated = true;
    });
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kling AI Clone', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Video Display Area
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.blueAccent)
                      : _videoGenerated
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, color: Colors.green.shade400, size: 50),
                                const SizedBox(height: 10),
                                const Text('Video Generated Successfully!', style: TextStyle(color: Colors.white70)),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.videocam_off, color: Colors.grey.shade600, size: 50),
                                const SizedBox(height: 10),
                                const Text('Video output will appear here', style: TextStyle(color: Colors.white54)),
                              ],
                            ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Prompt Input Field
            TextField(
              controller: _promptController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Enter your video prompt',
                hintText: 'e.g., "A cat playing a piano in a futuristic city"',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),

            // Generate Button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _generateVideo,
              icon: const Icon(Icons.movie_creation),
              label: Text(_isLoading ? 'Generating...' : 'Generate Video'),
            ),
          ],
        ),
      ),
    );
  }
}
