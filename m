Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Paul Brook <paul@codesourcery.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 4 Feb 2007 00:15:38 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qWSxFLPqMU2WJj9"
Message-Id: <200702040015.38566.paul@codesourcery.com>
Subject: [Bluez-devel] [patch] Celluon CL800TB keryboard support
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_qWSxFLPqMU2WJj9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch implements support for the Celluon CL800BT keyboard. It 
adds decoding of the data received to the current non-functional framework in 
the fakehid driver. It currently only implements keyboard 
functionality, "mouse mode" data is ignored.

Tested on x86-64 and Arm hosts.

Paul


--Boundary-00=_qWSxFLPqMU2WJj9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch.celluon"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch.celluon"

Index: hidd/fakehid.c
===================================================================
RCS file: /cvsroot/bluez/utils/hidd/fakehid.c,v
retrieving revision 1.12
diff -u -p -r1.12 fakehid.c
--- hidd/fakehid.c	13 Jan 2007 17:48:24 -0000	1.12
+++ hidd/fakehid.c	3 Feb 2007 23:29:51 -0000
@@ -453,6 +453,158 @@ int jthree_keyboard(const bdaddr_t *src,
 	return 0;
 }
 
+static const int celluon_xlate_num[10] = {
+	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9
+};
+
+static const int celluon_xlate_char[26] = {
+	KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G, KEY_H, KEY_I, KEY_J,
+	KEY_K, KEY_L, KEY_M, KEY_N, KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T,
+	KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z
+};
+
+static int celluon_xlate(int c)
+{
+	if (c >= '0' && c <= '9')
+		return celluon_xlate_num[c - '0'];
+	if (c >= 'A' && c <= 'Z')
+		return celluon_xlate_char[c - 'A'];
+	switch (c) {
+	case 0x08:
+		return KEY_BACKSPACE;
+	case 0x09:
+		return KEY_TAB;
+	case 0x0d:
+		return KEY_ENTER;
+	case 0x11:
+		return KEY_LEFTCTRL;
+	case 0x14:
+		return KEY_CAPSLOCK;
+	case 0x20:
+		return KEY_SPACE;
+	case 0x25:
+		return KEY_LEFT;
+	case 0x26:
+		return KEY_UP;
+	case 0x27:
+		return KEY_RIGHT;
+	case 0x28:
+		return KEY_DOWN;
+	case 0x2e:
+		return KEY_DELETE;
+	case 0x5b:
+		return KEY_MENU;
+	case 0xa1:
+		return KEY_RIGHTSHIFT;
+	case 0xa0:
+		return KEY_LEFTSHIFT;
+	case 0xba:
+		return KEY_SEMICOLON;
+	case 0xbd:
+		return KEY_MINUS;
+	case 0xbc:
+		return KEY_COMMA;
+	case 0xbb:
+		return KEY_EQUAL;
+	case 0xbe:
+		return KEY_DOT;
+	case 0xbf:
+		return KEY_SLASH;
+	case 0xc0:
+		return KEY_GRAVE;
+	case 0xdb:
+		return KEY_LEFTBRACE;
+	case 0xdc:
+		return KEY_BACKSLASH;
+	case 0xdd:
+		return KEY_RIGHTBRACE;
+	case 0xde:
+		return KEY_APOSTROPHE;
+	case 0xff03:
+		return KEY_HOMEPAGE;
+	case 0xff04:
+		return KEY_TIME;
+	case 0xff06:
+		return KEY_OPEN;
+	case 0xff07:
+		return KEY_LIST;
+	case 0xff08:
+		return KEY_MAIL;
+	case 0xff30:
+		return KEY_CALC;
+	case 0xff1a: /*  Map FN to ALT.  */
+		return KEY_LEFTALT;
+	case 0xff2f:
+		return KEY_INFO;
+	default:
+		printf ("Unknown Key %x\n", c);
+		return c;
+	}
+}
+
+/* Packet format is as follows (all fields little-endian): 
+     0 uint16	magic;		# 0x5a5a
+     2 uint32	unknown;	# ???
+     6 uint8	action;		# 0 = keyup, 1 = keydown, 2 = repeat
+				# 3, 4, 5, 6 = ??? (Mouse mode)
+     7 uint8	unknown2[9]	# ???
+    16 uint8	action2;	# ??? same as action
+    17 uint16	x;		# Horizontal coordinate
+    19 uint16	y;		# Vertical coordinate
+    21 uint16	time;		# Some sort of timestamp
+    23 uint8	unknown3[5];	# ???
+    28 uint8	key[];		# single byte keycode or 0xff byte
+				# follwed by special keycode byte.
+  Each packet followed by a checksum byte.  */
+
+struct celluon_state {
+	int len;	/* Expected length of current packet.  */
+	int count;	/* Number of bytes received.  */
+	int action;
+	int key;
+};
+
+static void celluon_decode(int fd, struct celluon_state *s, uint8_t c)
+{
+	if (s->count < 2 && c != 0xa5) {
+		/* Lost Sync.  */
+		s->count = 0;
+		return;
+	}
+	switch (s->count) {
+	case 0:
+		/* New packet.  Reset state.  */
+		s->len = 30;
+		s->key = 0;
+		break;
+	case 1:
+		break;
+	case 6:
+		s->action = c;
+		break;
+	case 28:
+		s->key = c;
+		if (c == 0xff)
+			s->len = 31;
+		break;
+	case 29:
+	case 30:
+		if (s->count == s->len - 1) {
+			/* TODO: Verify checksum.  */
+			if (s->action < 2) {
+				send_event(fd, EV_KEY, celluon_xlate(s->key),
+					   s->action);
+			}
+			s->count = -1;
+		} else {
+			s->key = (s->key << 8) | c;
+		}
+		break;
+	}
+	s->count++;
+	return;
+}
+
 int celluon_keyboard(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel)
 {
 	unsigned char buf[16];
@@ -460,7 +612,8 @@ int celluon_keyboard(const bdaddr_t *src
 	struct pollfd p;
 	sigset_t sigs;
 	char addr[18];
-	int fd, sk, len;
+	int i, fd, sk, len;
+	struct celluon_state s;
 
 	sk = rfcomm_connect(src, dst, channel);
 	if (sk < 0)
@@ -500,6 +653,8 @@ int celluon_keyboard(const bdaddr_t *src
 	p.fd = sk;
 	p.events = POLLIN | POLLERR | POLLHUP;
 
+	memset(&s, 0, sizeof(s));
+
 	while (!__io_canceled) {
 		p.revents = 0;
 		if (ppoll(&p, 1, NULL, &sigs) < 1)
@@ -508,6 +663,9 @@ int celluon_keyboard(const bdaddr_t *src
 		len = read(sk, buf, sizeof(buf));
 		if (len < 0)
 			break;
+
+		for (i = 0; i < len; i++)
+			celluon_decode(fd, &s, buf[i]);
 	}
 
 	printf("Disconnected\n");
Index: hidd/uinput.h
===================================================================
RCS file: /cvsroot/bluez/utils/hidd/uinput.h,v
retrieving revision 1.3
diff -u -p -r1.3 uinput.h
--- hidd/uinput.h	13 Jan 2007 17:48:24 -0000	1.3
+++ hidd/uinput.h	3 Feb 2007 23:29:52 -0000
@@ -341,6 +341,71 @@ extern "C" {
 #define BTN_GEAR_DOWN		0x150
 #define BTN_GEAR_UP		0x151
 
+#define KEY_OK			0x160
+#define KEY_SELECT		0x161
+#define KEY_GOTO		0x162
+#define KEY_CLEAR		0x163
+#define KEY_POWER2		0x164
+#define KEY_OPTION		0x165
+#define KEY_INFO		0x166
+#define KEY_TIME		0x167
+#define KEY_VENDOR		0x168
+#define KEY_ARCHIVE		0x169
+#define KEY_PROGRAM		0x16a
+#define KEY_CHANNEL		0x16b
+#define KEY_FAVORITES		0x16c
+#define KEY_EPG			0x16d
+#define KEY_PVR			0x16e
+#define KEY_MHP			0x16f
+#define KEY_LANGUAGE		0x170
+#define KEY_TITLE		0x171
+#define KEY_SUBTITLE		0x172
+#define KEY_ANGLE		0x173
+#define KEY_ZOOM		0x174
+#define KEY_MODE		0x175
+#define KEY_KEYBOARD		0x176
+#define KEY_SCREEN		0x177
+#define KEY_PC			0x178
+#define KEY_TV			0x179
+#define KEY_TV2			0x17a
+#define KEY_VCR			0x17b
+#define KEY_VCR2		0x17c
+#define KEY_SAT			0x17d
+#define KEY_SAT2		0x17e
+#define KEY_CD			0x17f
+#define KEY_TAPE		0x180
+#define KEY_RADIO		0x181
+#define KEY_TUNER		0x182
+#define KEY_PLAYER		0x183
+#define KEY_TEXT		0x184
+#define KEY_DVD			0x185
+#define KEY_AUX			0x186
+#define KEY_MP3			0x187
+#define KEY_AUDIO		0x188
+#define KEY_VIDEO		0x189
+#define KEY_DIRECTORY		0x18a
+#define KEY_LIST		0x18b
+#define KEY_MEMO		0x18c
+#define KEY_CALENDAR		0x18d
+#define KEY_RED			0x18e
+#define KEY_GREEN		0x18f
+#define KEY_YELLOW		0x190
+#define KEY_BLUE		0x191
+#define KEY_CHANNELUP		0x192
+#define KEY_CHANNELDOWN		0x193
+#define KEY_FIRST		0x194
+#define KEY_LAST		0x195
+#define KEY_AB			0x196
+#define KEY_NEXT		0x197
+#define KEY_RESTART		0x198
+#define KEY_SLOW		0x199
+#define KEY_SHUFFLE		0x19a
+#define KEY_BREAK		0x19b
+#define KEY_PREVIOUS		0x19c
+#define KEY_DIGITS		0x19d
+#define KEY_TEEN		0x19e
+#define KEY_TWEN		0x19f
+
 #define KEY_MAX			0x1ff
 
 /* Relative axes */

--Boundary-00=_qWSxFLPqMU2WJj9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_qWSxFLPqMU2WJj9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_qWSxFLPqMU2WJj9--
