Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 25 Oct 2007 09:48:55 -0400
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20071025134855.GH407@cathedrallabs.org>
References: <20071007184035.GA7430@cathedrallabs.org>
	<1191785016.3626.29.camel@cookie.hadess.net>
	<20071007234210.GD7430@cathedrallabs.org>
	<d120d5000710090651q5beb218fl79fbfba3cb02b94c@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <d120d5000710090651q5beb218fl79fbfba3cb02b94c@mail.gmail.com>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [Bluez-devel] [RFC][PATCH 4/4] add support to ps3
	remote	controller
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Here's the updated version of the table with some comments:

+static unsigned int ps3remote_keymap[] = {
+	[0x16] = KEY_EJECTCD,
+	[0x64] = KEY_AUDIO,
+	[0x65] = KEY_ANGLE,
+	[0x63] = KEY_SUBTITLE,
+	[0x0f] = KEY_CLEAR,
+	[0x28] = KEY_TIME,
+	[0x00] = KEY_1,
+	[0x01] = KEY_2,
+	[0x02] = KEY_3,
+	[0x03] = KEY_4,
+	[0x04] = KEY_5,
+	[0x05] = KEY_6,
+	[0x06] = KEY_7,
+	[0x07] = KEY_8,
+	[0x08] = KEY_9,
+	[0x09] = KEY_0,
these I really have no idea. KEY_REMOTE{1,2,3...}? having KEY_1, KEY_KP1
and KEY_something_else is really confusing. perhaps create a device
which always has numlock on?

+	[0x81] = KEY_RED,
+	[0x82] = KEY_GREEN,
+	[0x80] = KEY_BLUE,
+	[0x83] = KEY_YELLOW,
+	[0x70] = KEY_INFO,		/* display */
+	[0x1a] = KEY_MENU,		/* top menu */
+	[0x40] = KEY_CONTEXT_MENU,	/* pop up/menu */
+	[0x0e] = KEY_ESC,		/* return */
+	[0x5c] = KEY_OPTION,		/* options/triangle */
+	[0x5d] = KEY_BACK,		/* back/circle */
+	[0x5f] = KEY_SCREEN,		/* view/square */
+	[0x5e] = KEY_ENTER,		/* cross */
+	[0x54] = KEY_UP,
+	[0x56] = KEY_DOWN,
+	[0x57] = KEY_LEFT,
+	[0x55] = KEY_RIGHT,
+	[0x0b] = KEY_ENTER,
+	[0x5a] = BTN_TL,		/* L1 */
+	[0x58] = BTN_TL2,		/* L2 */
+	[0x51] = BTN_THUMBL,		/* L3 */
+	[0x5b] = BTN_TR,		/* R1 */
+	[0x59] = BTN_TR2,		/* R2 */
+	[0x52] = BTN_THUMBR,		/* R3 */
I think we should keep these as BTN, they're joystick buttons anyway.
the remote is a mix of remote with joystick.

+	[0x43] = KEY_HOMEPAGE,		/* PS button */
+	[0x50] = KEY_SELECT,
+	[0x53] = BTN_START,
same here, perhaps go back to BTN_SELECT too?

+	[0x33] = KEY_REWIND,		/* scan back */
+	[0x32] = KEY_PLAY,
+	[0x34] = KEY_FORWARD,		/* scan forward */
+	[0x30] = KEY_PREVIOUS,
+	[0x38] = KEY_STOP,
+	[0x31] = KEY_NEXT,
+	[0x60] = KEY_FRAMEBACK,		/* slow/step back */
+	[0x39] = KEY_PAUSE,
+	[0x61] = KEY_FRAMEFORWARD,	/* slow/step forward */
created these, input.h patch attached

+	[0xff] = KEY_MAX,
+};

What you think Dmitry?

---
 include/linux/input.h |    2 ++
 1 file changed, 2 insertions(+)

--- linus-2.6.orig/include/linux/input.h	2007-10-25 09:22:03.000000000 -0400
+++ linus-2.6/include/linux/input.h	2007-10-25 09:23:39.000000000 -0400
@@ -526,6 +526,8 @@ struct input_absinfo {
 #define KEY_DISPLAYTOGGLE	0x1af	/* Turn display (LCD) on and off */
 #define KEY_SPELLCHECK		0x1b0   /* AL Spell Check */
 #define KEY_LOGOFF		0x1b1   /* AL Logoff */
+#define KEY_FRAMEBACK		0x1b2
+#define KEY_FRAMEFORWARD	0x1b3
 
 #define KEY_DEL_EOL		0x1c0
 #define KEY_DEL_EOS		0x1c1

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
