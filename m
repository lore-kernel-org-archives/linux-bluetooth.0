Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1206021756.7678.20.camel@californication>
References: <20080313141810.GH8969@cathedrallabs.org>
	<1206021756.7678.20.camel@californication>
Content-Type: multipart/mixed; boundary="=-NPsbjC/zFEBhJ6hw0dMY"
Date: Thu, 20 Mar 2008 14:36:49 +0000
Message-Id: <1206023809.30595.435.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH 2/2 v010] add support to ps3	blu-ray	remote
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-NPsbjC/zFEBhJ6hw0dMY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 2008-03-20 at 15:02 +0100, Marcel Holtmann wrote:
> Hi Aristeu,
> 
> > And finally, adding support to PS3 remote controller.
> 
> I need one patch that cleanly applies against CVS and I need it now.
> Otherwise this won't make it into the next release.

Updated patch attached.

Cheers

--=-NPsbjC/zFEBhJ6hw0dMY
Content-Disposition: attachment; filename=bluez-utils-ps3-remote-support.patch
Content-Type: text/x-patch; name=bluez-utils-ps3-remote-support.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: input/fakehid.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/fakehid.c,v
retrieving revision 1.1
diff -u -p -r1.1 fakehid.c
--- input/fakehid.c	14 Mar 2008 19:50:56 -0000	1.1
+++ input/fakehid.c	20 Mar 2008 14:35:41 -0000
@@ -27,6 +27,8 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
 #include <errno.h>
 #include <sys/types.h>
 
@@ -40,8 +42,333 @@
 #include "logging.h"
 #include "device.h"
 #include "fakehid.h"
+#include "uinput.h"
+
+/* PS3 remote support */
+#define BLUETOOTH_VENDOR_ID_SONY	0x054c
+#define BLUETOOTH_DEVICE_ID_PS3REMOTE	0x0306
+#ifndef KEY_REMOTE_1
+#define KEY_REMOTE_1		0x1b6
+#endif
+#ifndef KEY_REMOTE_2
+#define KEY_REMOTE_2		0x1b7
+#endif
+#ifndef KEY_REMOTE_3
+#define KEY_REMOTE_3		0x1b8
+#endif
+#ifndef KEY_REMOTE_4
+#define KEY_REMOTE_4		0x1b9
+#endif
+#ifndef KEY_REMOTE_5
+#define KEY_REMOTE_5		0x1ba
+#endif
+#ifndef KEY_REMOTE_6
+#define KEY_REMOTE_6		0x1bb
+#endif
+#ifndef KEY_REMOTE_7
+#define KEY_REMOTE_7		0x1bc
+#endif
+#ifndef KEY_REMOTE_8
+#define KEY_REMOTE_8		0x1bd
+#endif
+#ifndef KEY_REMOTE_9
+#define KEY_REMOTE_9		0x1be
+#endif
+#ifndef KEY_REMOTE_0
+#define KEY_REMOTE_0		0x1bf
+#endif
+
+#define PS3_FLAGS_MASK 0xFFFFFF00
+enum ps3remote_special_keys {
+	PS3R_BIT_PS = 0,
+	PS3R_BIT_ENTER = 3,
+	PS3R_BIT_L2 = 8,
+	PS3R_BIT_R2 = 9,
+	PS3R_BIT_L1 = 10,
+	PS3R_BIT_R1 = 11,
+	PS3R_BIT_TRIANGLE = 12,
+	PS3R_BIT_CIRCLE = 13,
+	PS3R_BIT_CROSS = 14,
+	PS3R_BIT_SQUARE = 15,
+	PS3R_BIT_SELECT = 16,
+	PS3R_BIT_L3 = 17,
+	PS3R_BIT_R3 = 18,
+	PS3R_BIT_START = 19,
+	PS3R_BIT_UP = 20,
+	PS3R_BIT_RIGHT = 21,
+	PS3R_BIT_DOWN = 22,
+	PS3R_BIT_LEFT = 23,
+};
+
+static unsigned int ps3remote_bits[] = {
+	[PS3R_BIT_ENTER] = 0x0b,
+	[PS3R_BIT_PS] = 0x43,
+	[PS3R_BIT_SQUARE] = 0x5f,
+	[PS3R_BIT_CROSS] = 0x5e,
+	[PS3R_BIT_CIRCLE] = 0x5d,
+	[PS3R_BIT_TRIANGLE] = 0x5c,
+	[PS3R_BIT_R1] = 0x5b,
+	[PS3R_BIT_L1] = 0x5a,
+	[PS3R_BIT_R2] = 0x59,
+	[PS3R_BIT_L2] = 0x58,
+	[PS3R_BIT_LEFT] = 0x57,
+	[PS3R_BIT_DOWN] = 0x56,
+	[PS3R_BIT_RIGHT] = 0x55,
+	[PS3R_BIT_UP] = 0x54,
+	[PS3R_BIT_START] = 0x53,
+	[PS3R_BIT_R3] = 0x52,
+	[PS3R_BIT_L3] = 0x51,
+	[PS3R_BIT_SELECT] = 0x50,
+};
+
+static unsigned int ps3remote_keymap[] = {
+	[0x16] = KEY_EJECTCD,
+	[0x64] = KEY_AUDIO,
+	[0x65] = KEY_ANGLE,
+	[0x63] = KEY_SUBTITLE,
+	[0x0f] = KEY_CLEAR,
+	[0x28] = KEY_TIME,
+	[0x00] = KEY_REMOTE_1,
+	[0x01] = KEY_REMOTE_2,
+	[0x02] = KEY_REMOTE_3,
+	[0x03] = KEY_REMOTE_4,
+	[0x04] = KEY_REMOTE_5,
+	[0x05] = KEY_REMOTE_6,
+	[0x06] = KEY_REMOTE_7,
+	[0x07] = KEY_REMOTE_8,
+	[0x08] = KEY_REMOTE_9,
+	[0x09] = KEY_REMOTE_0,
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
+	[0x5e] = BTN_0,			/* cross */
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
+	[0x43] = KEY_HOMEPAGE,		/* PS button */
+	[0x50] = KEY_SELECT,
+	[0x53] = BTN_START,
+	[0x33] = KEY_REWIND,		/* scan back */
+	[0x32] = KEY_PLAY,
+	[0x34] = KEY_FORWARD,		/* scan forward */
+	[0x30] = KEY_PREVIOUS,
+	[0x38] = KEY_STOP,
+	[0x31] = KEY_NEXT,
+	[0x60] = KEY_FRAMEBACK,		/* slow/step back */
+	[0x39] = KEY_PAUSE,
+	[0x61] = KEY_FRAMEFORWARD,	/* slow/step forward */
+	[0xff] = KEY_MAX,
+};
+
+static int ps3remote_decode(char *buff, int size, unsigned int *value)
+{
+	static unsigned int lastkey = 0;
+	static unsigned int lastmask = 0;
+	int retval, mask, key, i;
+
+	if (size < 12) {
+		error("Got a shorter packet! (size %i)\n", size);
+		return KEY_RESERVED;
+	}
+
+	mask = (buff[2] << 16) + (buff[3] << 8) + buff[4];
+	key = buff[5];
+
+	/* first, check flags */
+	for (i = 0; i < 24; i++) {
+		if ((lastmask & (1 << i)) == (mask & (1 << i)))
+			continue;
+		if (ps3remote_bits[i] == 0)
+			goto error;
+		retval = ps3remote_keymap[ps3remote_bits[i]];
+		if (mask & (1 << i))
+			/* key pressed */
+			*value = 1;
+		else
+			/* key released */
+			*value = 0;
+
+		goto out;
+	}
+
+	*value = buff[11];
+	if (buff[11] == 1) {
+		retval = ps3remote_keymap[key];
+	} else
+		retval = lastkey;
+
+	if (retval == KEY_RESERVED)
+		goto error;
+	if (retval == KEY_MAX)
+		return retval;
+
+	lastkey = retval;
+out:
+	fflush(stdout);
+
+	lastmask = mask;
+
+	return retval;
+error:
+	error("ps3remote: unrecognized sequence [%#x][%#x][%#x][%#x] [%#x],"
+	      "last: [%#x][%#x][%#x][%#x]",
+	      buff[2], buff[3], buff[4], buff[5], buff[11],
+	      lastmask >> 16, lastmask >> 8 & 0xff, lastmask & 0xff, lastkey);
+	return -1;
+}
+
+static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct fake_input *fake = data;
+	struct uinput_event event;
+	unsigned int key, value = 0;
+	gsize size;
+	char buff[50];
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		error("Hangup or error on rfcomm server socket");
+		goto failed;
+	}
+
+	memset(buff, 0, sizeof(buff));
+
+	if (g_io_channel_read(chan, buff, sizeof(buff), &size) !=
+	    G_IO_ERROR_NONE) {
+		error("IO Channel read error");
+		goto failed;
+	}
+
+	key = ps3remote_decode(buff, size, &value);
+	if (key == KEY_RESERVED) {
+		error("Got invalid key from decode");
+		goto failed;
+	} else if (key == KEY_MAX)
+		return TRUE;
+
+	memset(&event, 0, sizeof(event));
+	gettimeofday(&event.time, NULL);
+	event.type = EV_KEY;
+	event.code = key;
+	event.value = value;
+	if (write(fake->uinput, &event, sizeof(event)) != sizeof(event)) {
+		error("Error writing to uinput device");
+		goto failed;
+	}
+
+	memset(&event, 0, sizeof(event));
+	gettimeofday(&event.time, NULL);
+	event.type = EV_SYN;
+	event.code = SYN_REPORT;
+	if (write(fake->uinput, &event, sizeof(event)) != sizeof(event)) {
+		error("Error writing to uinput device");
+		goto failed;
+	}
+
+	return TRUE;
+failed:
+	ioctl(fake->uinput, UI_DEV_DESTROY);
+	close(fake->uinput);
+        fake->uinput = -1;
+	g_io_channel_unref(fake->io);
+
+	return FALSE;
+}
+
+static int ps3remote_setup_uinput(struct fake_input *fake,
+				  struct fake_hid *fake_hid)
+{
+	struct uinput_dev dev;
+	int i;
+
+	fake->uinput = open("/dev/input/uinput", O_RDWR);
+	if (fake->uinput < 0) {
+		fake->uinput = open("/dev/uinput", O_RDWR);
+		if (fake->uinput < 0)
+			fake->uinput = open("/dev/misc/uinput", O_RDWR);
+	}
+	if (fake->uinput < 0) {
+		error("Error opening uinput device file. Is uinput loaded?");
+		return 1;
+	}
+
+	memset(&dev, 0, sizeof(dev));
+	snprintf(dev.name, sizeof(dev.name), "%s", "PS3 Remote Controller");
+	dev.id.bustype = BUS_BLUETOOTH;
+	dev.id.vendor = fake_hid->vendor;
+	dev.id.product = fake_hid->product;
+
+	if (write(fake->uinput, &dev, sizeof(dev)) != sizeof(dev)) {
+		error("Error creating uinput device");
+		goto err;
+	}
+
+	/* enabling key events */
+	if (ioctl(fake->uinput, UI_SET_EVBIT, EV_KEY) < 0) {
+		error("Error enabling uinput device key events");
+		goto err;
+	}
+
+	/* enabling keys */
+	for (i = 0; i < 256; i++)
+		if (ps3remote_keymap[i] != KEY_RESERVED)
+			if (ioctl(fake->uinput, UI_SET_KEYBIT,
+				  ps3remote_keymap[i]) < 0) {
+				error("Error enabling uinput key %i", ps3remote_keymap[i]);
+				goto err;
+			}
+
+	/* creating the device */
+	if (ioctl(fake->uinput, UI_DEV_CREATE) < 0) {
+		error("Error creating uinput device");
+		goto err;
+	}
+
+	return 0;
+err:
+	close(fake->uinput);
+	return 1;
+}
+
+/* Common functions */
+static gboolean fake_hid_common_connect(struct fake_input *fake)
+{
+	return TRUE;
+}
+
+static int fake_hid_common_disconnect(struct fake_input *fake)
+{
+	return 0;
+}
 
 static struct fake_hid fake_hid_table[] = {
+	{
+		.vendor = BLUETOOTH_VENDOR_ID_SONY,
+		.product = BLUETOOTH_DEVICE_ID_PS3REMOTE,
+		.connect = fake_hid_common_connect,
+		.disconnect = fake_hid_common_disconnect,
+		.event = ps3remote_event,
+		.setup_uinput = ps3remote_setup_uinput,
+	},
 	{ },
 };
 

--=-NPsbjC/zFEBhJ6hw0dMY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-NPsbjC/zFEBhJ6hw0dMY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-NPsbjC/zFEBhJ6hw0dMY--
