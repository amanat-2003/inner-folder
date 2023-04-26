import 'package:flutter/material.dart';
import 'package:glove_app/pages/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
