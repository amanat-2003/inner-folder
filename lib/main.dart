import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'pages/MainPage.dart';
import 'helper/helper_function.dart';
import 'service/functions.dart';
import 'shared/constants.dart';

// void main() => runApp(new ExampleApplication());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // initialization for web
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
    ));
  } else {
    // initialization for android, iOS
    await Firebase.initializeApp();
  }

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(showHome: showHome));
}

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}

class MyApp extends StatefulWidget {
  final bool showHome;

  const MyApp({Key? key, required this.showHome}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    // setState(() async {
    // _isSignedIn = (await HelperFunctions.getUserLoggedInStatus()) ?? false;
    // });
    var val = await HelperFunctions.getUserLoggedInStatus();
    if (val != null) {
      setState(() {
        _isSignedIn = val;
      });
    } else {
      setState(() {
        _isSignedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:
            createMaterialColor(const Color.fromARGB(255, 238, 104, 14)),
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: _isSignedIn ? MainPage() : LoginRegisterPage(),
      home: OnBoardingPage(),
      // home: const ButtonScreen(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool isLastPage = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              isLastPage = (index == 3);
            });
          },
          controller: controller,
          children: [
            buildPage(
                color: Colors.orangeAccent.shade100,
                imageAddress: 'assets/glove_icon Background Removed.png',
                title: 'Title',
                subtitle: 'subtitle lsldjhfk bdajhsgfs jahsdgajhsd'),
            buildPage(
                color: Colors.orangeAccent.shade100,
                imageAddress: 'assets/glove_icon Background Removed.png',
                title: 'Title',
                subtitle: 'subtitle lsldjhfk bdajhsgfs jahsdgajhsd'),
            buildPage(
                color: Colors.orangeAccent.shade100,
                imageAddress: 'assets/glove_icon Background Removed.png',
                title: 'Title',
                subtitle: 'subtitle lsldjhfk bdajhsgfs jahsdgajhsd'),
            buildPage(
                color: Colors.orangeAccent.shade100,
                imageAddress: 'assets/glove_icon Background Removed.png',
                title: 'Title',
                subtitle: 'subtitle lsldjhfk bdajhsgfs jahsdgajhsd')
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 20),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 238, 104, 14),
                minimumSize: Size.fromHeight(80),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(3),
                      child: Text('SKIP')),
                  Center(
                      child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: WormEffect(
                      spacing: 10,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: const Color.fromARGB(255, 238, 104, 14),
                    ),
                  )),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text('NEXT')),
                ],
              ),
            ),
    );
  }
}

Widget buildPage(
    {required Color color,
    required String imageAddress,
    required String title,
    required String subtitle}) {
  return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAddress,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            title,
            style: TextStyle(
              color: const Color.fromARGB(255, 238, 104, 14),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 60),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ));
}
