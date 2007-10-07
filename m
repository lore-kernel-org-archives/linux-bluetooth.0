Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Oct 2007 14:40:35 -0400
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20071007184035.GA7430@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [RFC][PATCH 4/4] add support to ps3 remote controller
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

And finally, adding support to PS3 remote controller.

--- input.orig/fake_hid.c	2007-10-07 12:12:21.000000000 -0400
+++ input/fake_hid.c	2007-10-07 14:10:52.000000000 -0400
@@ -1,8 +1,12 @@
 #include <stdio.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <glib.h>
+#include <linux/input.h>
+#include <linux/uinput.h>
 #include <dbus/dbus.h>
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hidp.h>
@@ -22,6 +26,202 @@
 	.setup_uinput = s, \
 	}
 
+/* ps3 remote support */
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
+	[0x81] = KEY_RED,
+	[0x82] = KEY_GREEN,
+	[0x80] = KEY_BLUE,
+	[0x83] = KEY_YELLOW,
+	[0x70] = KEY_DISPLAYTOGGLE,	/* display */
+	[0x1a] = BTN_TOP,		/* top menu */
+	[0x40] = KEY_MENU,		/* pop up/menu */
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
+	[0x5a] = BTN_1,		/* L1 */
+	[0x58] = BTN_2,		/* L2 */
+	[0x51] = BTN_3,		/* L3 */
+	[0x5b] = BTN_4,		/* R1 */
+	[0x59] = BTN_5,		/* R2 */
+	[0x52] = BTN_6,		/* R3 */
+	[0x43] = KEY_VENDOR,		/* PS button */
+	[0x50] = BTN_SELECT,
+	[0x53] = BTN_START,
+	[0x33] = KEY_BACK,		/* scan back */
+	[0x32] = KEY_PLAY,
+	[0x34] = KEY_FORWARD,		/* scan forward */
+	[0x30] = KEY_PREVIOUS,
+	[0x38] = KEY_STOP,
+	[0x31] = KEY_NEXT,
+	[0x60] = KEY_PREVIOUSSONG,	/* slow/step back */
+	[0x39] = KEY_PAUSE,
+	[0x61] = KEY_NEXTSONG,		/* slow/step forward */
+	[0xff] = KEY_MAX,
+};
+
+static int ps3remote_decode(char *buff, int size, unsigned int *value)
+{
+	static unsigned int lastkey = KEY_RESERVED;
+	int retval, ps3;
+
+	if (size < 12) {
+		error("Got a shorter packet! (size %i)\n", size);
+		return KEY_RESERVED;
+	}
+
+	*value = buff[11];
+
+	if (*value == 0)
+		return lastkey;
+
+	ps3 = buff[5];
+	lastkey = retval = ps3remote_keymap[ps3];
+
+	if (retval == KEY_RESERVED)
+		error("ps3remote: unrecognized key [%#x] value [%#x]",
+		      buff[5], buff[11]);
+
+	return retval;
+}
+
+static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct fake_input *fake = data;
+	struct input_event event;
+	unsigned int size, key, value;
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
+		return TRUE;
+	}
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
+static int ps3remote_setup_uinput(struct device *idev,
+				  struct fake_hid *fake_hid)
+{
+	struct fake_input *fake = idev->fake;
+	struct uinput_user_dev dev;
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
+	snprintf(&dev.name, sizeof(dev.name), "%s", "PS3 Remote Controller");
+	dev.id.bustype = BUS_BLUETOOTH;
+	dev.id.vendor = idev->vendor;
+	dev.id.product = idev->product;
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
 static gboolean fake_hid_common_connect(struct device *idev)
 {
 	return TRUE;
@@ -38,6 +238,11 @@
 }
 
 static struct fake_hid fake_hid_table[] = {
+	FAKE_HID_ENTRY(SONY, PS3REMOTE, fake_hid_common_connect,
+		       fake_hid_common_disconnect,
+		       fake_hid_common_is_connected,
+		       ps3remote_event,
+		       ps3remote_setup_uinput),
 	{ },
 };
 
--- input.orig/bluetooth_ids.h	2007-10-07 12:12:06.000000000 -0400
+++ input/bluetooth_ids.h	2007-10-07 12:12:24.000000000 -0400
@@ -3,6 +3,7 @@
 
 #define BLUETOOTH_VENDOR_ID_SONY 0x054c
 #define BLUETOOTH_DEVICE_ID_PS3CONTROLLER 0x0268
+#define BLUETOOTH_DEVICE_ID_PS3REMOTE 0x0306
 
 #endif	/* BLUETOOTH_IDS_H */
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
