Return-Path: <cyrus@holtmann.org>
Message-ID: <1347015672.2219.4.camel@sirocco.hadess.net>
Subject: [PATCH 2/3] fakehid: Disconnect from PS3 remote after 10 mins
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 07 Sep 2012 12:01:12 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


After 10 minutes, disconnect the PS3 BD Remote to avoid draining its
battery. This is consistent with its behaviour on the PS3.

Original patch by Ruslan N. Marchenko <rufferson@gmail.com>
---
 profiles/input/device.h  |  1 +
 profiles/input/fakehid.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/profiles/input/device.h b/profiles/input/device.h
index ff52967..d8baa2c 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -33,6 +33,7 @@ struct fake_input {
 	int		uinput;		/* uinput socket */
 	int		rfcomm;		/* RFCOMM socket */
 	uint8_t		ch;		/* RFCOMM channel number */
+	guint           timeout_id;	/* Disconnect timeout ID */
 	gboolean	(*connect) (struct input_conn *iconn, GError **err);
 	int		(*disconnect) (struct input_conn *iconn);
 	void		*priv;
diff --git a/profiles/input/fakehid.c b/profiles/input/fakehid.c
index d9af2dd..b12c526 100644
--- a/profiles/input/fakehid.c
+++ b/profiles/input/fakehid.c
@@ -41,6 +41,9 @@
 #include "fakehid.h"
 #include "uinput.h"
 
+/* Timeout to get the PS3 remote disconnected, in seconds */
+#define PS3_REMOTE_TIMEOUT 10 * 60
+
 enum ps3remote_special_keys {
 	PS3R_BIT_PS = 0,
 	PS3R_BIT_ENTER = 3,
@@ -138,6 +141,13 @@ static unsigned int ps3remote_keymap[] = {
 	[0xff] = KEY_MAX,
 };
 
+static gboolean ps3_remote_timeout_cb(gpointer user_data);
+
+static void ps3remote_set_timeout(struct fake_input *fake)
+{
+	fake->timeout_id = g_timeout_add_seconds(PS3_REMOTE_TIMEOUT, ps3_remote_timeout_cb, fake);
+}
+
 static int ps3remote_decode(char *buff, int size, unsigned int *value)
 {
 	static unsigned int lastkey = 0;
@@ -200,6 +210,16 @@ error:
 	return -1;
 }
 
+static gboolean
+ps3_remote_timeout_cb(gpointer user_data)
+{
+	struct fake_input *fake = (struct fake_input *) user_data;
+	input_device_request_disconnect(fake);
+	DBG("Disconnected PS3 BD Remote after timeout");
+	fake->timeout_id = 0;
+	return FALSE;
+}
+
 static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -253,9 +273,17 @@ static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 	}
 
+	if (fake->timeout_id > 0)
+		g_source_remove(fake->timeout_id);
+	ps3remote_set_timeout(fake);
+
 	return TRUE;
 
 failed:
+	if (fake->timeout_id > 0) {
+		g_source_remove(fake->timeout_id);
+		fake->timeout_id = 0;
+	}
 	ioctl(fake->uinput, UI_DEV_DESTROY);
 	close(fake->uinput);
 	fake->uinput = -1;
@@ -315,6 +343,8 @@ static int ps3remote_setup_uinput(struct fake_input *fake,
 		goto err;
 	}
 
+	ps3remote_set_timeout(fake);
+
 	return 0;
 
 err:
@@ -375,6 +405,8 @@ struct fake_input *fake_hid_connadd(struct fake_input *fake,
 	for (l = fake_hid->devices; l != NULL; l = l->next) {
 		old = l->data;
 		if (old->idev == fake->idev) {
+			if (fake->timeout_id > 0)
+				g_source_remove(fake->timeout_id);
 			g_free(fake);
 			fake = old;
 			fake_hid->connect(fake, NULL);
-- 
1.7.12


