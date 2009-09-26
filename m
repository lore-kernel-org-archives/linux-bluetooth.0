Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2009 16:32:47 +0200
Message-ID: <a70b8cd30909260732h549c21bay7a97dcc4941478c9@mail.gmail.com>
Subject: [PATCH 4/4] Bluez: input: PS3 BD Remote alternate keymapping (compat)
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds alternate keymap for PS3 BD Remote driver. New
layout is compatible with standard (old) xinput, allowing it to
recieve key events without additional event routers or xinput
driver patches.
It adds new section [PS3 Remote] to input.conf, with parameter
Compat, which enables alternate layout.

Signed-off-by: Ruslan N. Marchenko <rufferson@gmail.com>
---
 input/device.h   |    1 +
 input/fakehid.c  |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 input/input.conf |    8 +++++++
 input/manager.c  |    7 ++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/input/device.h b/input/device.h
index c019930..721a98a 100644
--- a/input/device.h
+++ b/input/device.h
@@ -29,6 +29,7 @@

 struct input_dev_conf {
 	int timeout;
+	int ps3remote_compat;
 };
 struct input_device {
 	DBusConnection		*conn;
diff --git a/input/fakehid.c b/input/fakehid.c
index 3687ea7..441f58e 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -94,7 +94,7 @@ static unsigned int ps3remote_bits[] = {
 	[PS3R_BIT_SELECT] = 0x50,
 };

-static unsigned int ps3remote_keymap[] = {
+static unsigned int ps3keymap_def[] = {
 	[0x16] = KEY_EJECTCD,
 	[0x64] = KEY_AUDIO,
 	[0x65] = KEY_ANGLE,
@@ -147,6 +147,59 @@ static unsigned int ps3remote_keymap[] = {
 	[0x39] = KEY_PAUSE,
 	[0x61] = KEY_FRAMEFORWARD,	/* slow/step forward */
 	[0xff] = KEY_MAX,
+}, ps3keymap_alt[] = {
+	[0x16] = KEY_EJECTCD,
+	[0x64] = KEY_A,			/* audio */
+	[0x65] = KEY_Z,			/* angle */
+	[0x63] = KEY_T,			/* subtitle */
+	[0x0f] = KEY_DELETE,		/* clear */
+	[0x28] = KEY_END,		/* timer */
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
+	[0x81] = KEY_F7,		/* red */
+	[0x82] = KEY_F8,		/* green */
+	[0x83] = KEY_F9,		/* yellow */
+	[0x80] = KEY_F10,		/* blue */
+	[0x70] = KEY_D,			/* display */
+	[0x1a] = KEY_MENU,		/* top menu */
+	[0x40] = KEY_F11,		/* pop up/menu */
+	[0x0e] = KEY_ESC,		/* return */
+	[0x5c] = KEY_F12,		/* options/triangle */
+	[0x5d] = KEY_BACK,		/* back/circle */
+	[0x5f] = KEY_V,			/* view/square */
+	[0x5e] = KEY_X,			/* cross */
+	[0x54] = KEY_UP,
+	[0x56] = KEY_DOWN,
+	[0x57] = KEY_LEFT,
+	[0x55] = KEY_RIGHT,
+	[0x0b] = KEY_ENTER,
+	[0x5a] = KEY_F1,		/* L1 */
+	[0x58] = KEY_F2,		/* L2 */
+	[0x51] = KEY_F3,		/* L3 */
+	[0x5b] = KEY_F4,		/* R1 */
+	[0x59] = KEY_F5,		/* R2 */
+	[0x52] = KEY_F6,		/* R3 */
+	[0x43] = KEY_HOMEPAGE,		/* PS button */
+	[0x50] = KEY_INSERT,		/* select */
+	[0x53] = KEY_HOME,		/* start */
+	[0x33] = KEY_R,			/* scan back */
+	[0x32] = KEY_PLAY,
+	[0x34] = KEY_F,			/* scan forward */
+	[0x30] = KEY_PAGEUP,		/* next */
+	[0x38] = KEY_STOP,
+	[0x31] = KEY_PAGEDOWN,		/* previous */
+	[0x60] = KEY_COMMA,		/* slow/step back */
+	[0x39] = KEY_PAUSE,
+	[0x61] = KEY_DOT,		/* slow/step forward */
+	[0xff] = KEY_MAX,
 };

 static int ps3remote_decode(char *buff, int size, unsigned int *value,
@@ -390,7 +443,9 @@ static gboolean ps3remote_connect(struct
fake_input *fake, GError **err)
 		struct ps3remote_data *ps3 = g_new0(struct ps3remote_data, 1);
 		ps3->timer = g_timer_new();
 		ps3->timeout = fake->idev->conf->timeout;
-		ps3->keymap = ps3remote_keymap;
+		ps3->keymap = (fake->idev->conf
+					&& fake->idev->conf->ps3remote_compat)?
+						ps3keymap_alt : ps3keymap_def;
 		fake->data = ps3;
 	}
 	return TRUE;
diff --git a/input/input.conf b/input/input.conf
index 6381dc2..59ff635 100644
--- a/input/input.conf
+++ b/input/input.conf
@@ -7,3 +7,11 @@
 # Set idle timeout (in seconds) before the connection will
 # be disconnect (defaults to 0 for no timeout)
 #IdleTimeout=30
+
+##
+# Section for options, specific to Sony PS3 BD Remote driver
+[PS3 Remote]
+
+# Set keymap to generic keycodes/scancodes, in order
+# to be compatible with old XInput driver.
+#Compat=1
diff --git a/input/manager.c b/input/manager.c
index 7d349ff..4606f70 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -183,6 +183,13 @@ int input_manager_init(DBusConnection *conn,
GKeyFile *config)
 			debug("input.conf: %s", err->message);
 			g_error_free(err);
 		}
+		idev_conf.ps3remote_compat =
+				g_key_file_get_integer(config,
+				"PS3 Remote", "Compat", &err);
+		if (err) {
+			debug("input.conf: %s", err->message);
+			g_error_free(err);
+		}
 	}

 	connection = dbus_connection_ref(conn);
-- 
1.6.0.4



-- 
Looking forward to reading yours.
     Ruslan N. Marchenko
