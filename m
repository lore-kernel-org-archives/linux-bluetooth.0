Return-Path: <rob.davis@virgin.net>
Message-ID: <401937E0.6000800@virgin.net>
Date: Thu, 29 Jan 2004 16:42:08 +0000
From: Rob Davis <rob.davis@virgin.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] epox-presenter
References: <4017F953.1090108@virgin.net>	 <1075314868.26729.34.camel@pegasus>  <401830B2.5070407@virgin.net> <1075355198.26729.58.camel@pegasus>
In-Reply-To: <1075355198.26729.58.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------050308050102080205010905"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050308050102080205010905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>Hi Rob,
>
>  
>
>>Okay, my first ever C hack...
>>    
>>
>
>no problem, because everyone has to start sometime :)
>
>  
>
>>Implemented three functions, back button triggers mouse button 4, next 
>>button triggers mouse button 5, fn button triggers a keyboard alt + tab, 
>>which changes window focus in kde, and probably gnome.
>>
>>I have also reduced the speed of the pointer from 12 to 4, which I am 
>>much happier with as I have a hope of landing on the correct window.
>>    
>>
>
>Can we get some command options to change this behaviour?
>
>  
>
>>Sorry, I'm not sure how to do patch, but the file is small...
>>    
>>
>
>take a look at "man diff" and do "diff -urN <orig> <modified>". It is
>much more easier for me to look at a patch, because in most cases only
>the changes matters.
>
>Regards
>
>Marcel
>
>  
>
Okay... This is a slight bug fix over the previous one..



--------------050308050102080205010905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -urN epox-presenter.orig/src/main.c epox-presenter-0.2/src/main.c
--- epox-presenter.orig/src/main.c	2003-08-15 11:41:29.000000000 +0100
+++ epox-presenter-0.2/src/main.c	2004-01-29 16:39:19.000000000 +0000
@@ -39,21 +39,28 @@
 
 #include <X11/Xlib.h>
 #include <X11/extensions/XTest.h>
-
+#include <X11/keysym.h>
 #include <math.h>
 
+/* Sends Alt + Tab when Fn Button is Pressed */
 
 static void func(Display *display)
 {
+	XTestGrabControl(display, True);
+        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Alt_L),
+        True, CurrentTime );
+        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Tab),
+        True, CurrentTime );	
+        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Tab),
+        False, CurrentTime );
+        XTestFakeKeyEvent(display, XKeysymToKeycode(display, XK_Alt_L),
+        False, CurrentTime );
+	XTestGrabControl(display, False);
+	XFlush(display);
 }
 
-static void back(Display *display)
-{
-}
 
-static void next(Display *display)
-{
-}
+/* Mouse Button */
 
 static void button(Display *display, unsigned int button, Bool is_press)
 {
@@ -62,31 +69,42 @@
 	XTestGrabControl(display, False);
 	XFlush(display);
 }
+/* Mouse Movement */
 
-static void move(Display *display, unsigned int direction)
+static void move(Display *display, unsigned int direction, unsigned int speed)
 {
 	double angle;
 	int x, y;
-
+	speed++;
 	angle = (direction * 22.5) * 3.1415926 / 180;
-	x = (int) (sin(angle) * 12);
-	y = (int) (cos(angle) * -12);
-
+	x = (int) (sin(angle) * speed);
+	y = (int) (cos(angle) * (0 - (int)(speed)));
 	XTestGrabControl(display, True);
 	XTestFakeRelativeMotionEvent(display, x, y, CurrentTime);
 	XTestGrabControl(display, False);
 	XFlush(display);
 }
 
-static void decode_event(Display *display, unsigned char event)
+static void decode_event(Display *display, unsigned char event, unsigned int speed)
 {
 	switch (event) {
 	case 48:
 		func(display); break;
-	case 55:
-		back(display); break;
+
+/* Next two cases are to implement mouse buttons 4 and 5.
+   ZAxisMapping must be defined in XF86Config for the CorePointer
+   Unlike Button 1 and 3, no unpress case is generated, so we sleep for
+   a tenth of a second before turning the button off. - Rob Davis
+*/
+
+       	case 55:
+	        button(display, 4, True);
+		sleep(0.1);
+	        button(display, 4, False); break;
 	case 56:
-		next(display); break;
+                button(display, 5, True);
+		sleep(0.1);
+        	button(display, 5, False); break;		
 	case 53:
 		button(display, 1, True); break;
 	case 121:
@@ -98,39 +116,40 @@
 	case 120:
 		button(display, 3, False); break;
 	case 112:
-		break;
+		break;	
+
 	case 51:
-		move(display, 0); break;
+		move(display, 0, speed); break;
 	case 97:
-		move(display, 1); break;
+		move(display, 1, speed); break;
 	case 65:
-		move(display, 2); break;
+		move(display, 2, speed); break;
 	case 98:
-		move(display, 3); break;
+		move(display, 3, speed); break;
 	case 50:
-		move(display, 4); break;
+		move(display, 4, speed); break;
 	case 99:
-		move(display, 5); break;
+		move(display, 5, speed); break;
 	case 67:
-		move(display, 6); break;
+		move(display, 6, speed); break;
 	case 101:
-		move(display, 7); break;
+		move(display, 7, speed); break;
 	case 52:
-		move(display, 8); break;
+		move(display, 8, speed); break;
 	case 100:
-		move(display, 9); break;
+		move(display, 9, speed); break;
 	case 66:
-		move(display, 10); break;
+		move(display, 10, speed); break;
 	case 102:
-		move(display, 11); break;
+		move(display, 11, speed); break;
 	case 49:
-		move(display, 12); break;
+		move(display, 12, speed); break;
 	case 103:
-		move(display, 13); break;
+		move(display, 13, speed); break;
 	case 57:
-		move(display, 14); break;
+		move(display, 14, speed); break;
 	case 104:
-		move(display, 15); break;
+		move(display, 15, speed); break;
 	case 69:
 		break;
 	default:
@@ -241,14 +260,16 @@
 		"\n");
 
 	printf("Options:\n"
-		"\t-i [hciX|bdaddr]   Local HCI device or BD Address\n"
-		"\t-h, --help         Display help\n"
+		"\t-i [hciX|bdaddr]     Local HCI device or BD Address\n"
+		"\t-h, --help           Display help\n"
+	        "\t-s, --speed [1 - 50] Speed of Mouse Pointer - Default 4\n"
 		"\n");
 }
 
 static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "device",	1, 0, 'i' },
+	{ "speed",      1, 0, 's' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -263,11 +284,13 @@
 	char bda[18];
 	bdaddr_t src, dst;
 	uint8_t channel;
-	int i, opt, sk, len;
+	int i, opt, sk, len, speed;
+
+	speed = 4;
 
 	bacpy(&src, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:hs:", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (!strncmp(optarg, "hci", 3))
@@ -278,6 +301,19 @@
 		case 'h':
 			usage();
 			exit(0);
+		case 's':
+		  speed = atoi(optarg);
+		  if (speed <1) 
+			       {  printf ("Invalid Speed\n");
+			          usage();
+			          exit(1); }
+		  if (speed >50) 
+			       {  printf ("Invalid Speed\n");
+			          usage();
+			          exit(1); }
+
+		  printf ("Speed settings %d\n", speed );
+		  break;
 		default:
 			exit(0);
 		}
@@ -364,7 +400,7 @@
 			break;
 
 		for (i = 0; i < len; i++)
-			decode_event(display, buf[i]);
+			decode_event(display, buf[i], speed);
 	}
 
 	printf("Disconnected\n");

--------------050308050102080205010905--
