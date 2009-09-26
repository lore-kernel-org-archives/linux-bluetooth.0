Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2009 16:29:01 +0200
Message-ID: <a70b8cd30909260729n524c0586j7365606b8ba2d7bc@mail.gmail.com>
Subject: [PATCH 2/4] Bluez: input: ps3remote driver power-saving
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PS3 Remote driver is now using IdleTimeout config parameter for
power-saving purpose. It disconnects BT channel when remote is
idle for IdleTimeout seconds, and remote after loosing BT channel
enters low-power mode. To minimize delay caused by re-connecting,
uinput device handler is held for daemon's lifetime, thus key-press
which forced remote to reconnect is sent immediately to the OS.
Default timeout, when IdleTimeout is not specified, or is less
then 5 seconds - is 15 seconds.

Signed-off-by: Ruslan N. Marchenko <rufferson@gmail.com>
---
 input/fakehid.c |   39 ++++++++++++++++++++++++++++++++++-----
 input/fakehid.h |    1 +
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/input/fakehid.c b/input/fakehid.c
index 75c2650..b068e22 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -31,11 +31,13 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include <sys/stat.h>

 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/hidp.h>
 #include <bluetooth/sdp.h>
+#include <bluetooth/hci.h>

 #include <glib.h>
 #include <dbus/dbus.h>
@@ -208,6 +210,22 @@ error:
 	return -1;
 }

+static gboolean ps3remote_out(GIOChannel *chan, GIOCondition cond,
+                                gpointer data)
+{
+	struct ps3remote_data *ps3 = ((struct fake_input *)data)->data;
+	const struct input_device *idev = ((struct fake_input *)data)->idev;
+	uint16_t to = (ps3->timeout < 5) ? 15 : ps3->timeout;
+	gulong ms;
+
+	if(g_timer_elapsed(ps3->timer,&ms) > to) {
+		DBG("idle timeout, disconnecting BT channel");
+		device_request_disconnect(idev->device, NULL);
+		return FALSE;
+	} else
+		usleep(100);
+	return TRUE;
+}
 static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -264,11 +282,9 @@ static gboolean ps3remote_event(GIOChannel *chan,
GIOCondition cond,
 	return TRUE;

 failed:
-	ioctl(fake->uinput, UI_DEV_DESTROY);
-	close(fake->uinput);
-	fake->uinput = -1;
+	g_timer_stop(ps3->timer);
 	g_io_channel_unref(fake->io);
-
+	DBG("Event failed");
 	return FALSE;
 }

@@ -277,8 +293,19 @@ static int ps3remote_setup_uinput(struct fake_input *fake,
 {
 	struct uinput_dev dev;
 	struct ps3remote_data *ps3 = (struct ps3remote_data *)fake->data;
+	struct stat sbuf;
 	int i;

+	/* check if uinput already open */
+	if(fake->uinput > 0) {
+		if(!(i=fstat(fake->uinput, &sbuf))) {
+			DBG("input %d is opened", fake->uinput);
+			return 0;
+		} else
+			DBG("fstat(%d): error[%d]: %s", fake->uinput, i,
+							strerror(errno));
+	}
+	/* create uinput device */
 	fake->uinput = open("/dev/input/uinput", O_RDWR);
 	if (fake->uinput < 0) {
 		fake->uinput = open("/dev/uinput", O_RDWR);
@@ -334,6 +361,7 @@ static gboolean ps3remote_connect(struct
fake_input *fake, GError **err)
 {
 	if(!fake->data) {
 		struct ps3remote_data *ps3 = g_new0(struct ps3remote_data, 1);
+		ps3->timer = g_timer_new();
 		ps3->timeout = fake->idev->conf->timeout;
 		ps3->keymap = ps3remote_keymap;
 		fake->data = ps3;
@@ -359,6 +387,7 @@ static struct fake_hid fake_hid_table[] = {
 		.connect	= ps3remote_connect,
 		.disconnect	= fake_hid_common_disconnect,
 		.event		= ps3remote_event,
+		.oevent		= ps3remote_out,
 		.setup_uinput	= ps3remote_setup_uinput,
 		.fakes		= NULL,
 	},
@@ -419,6 +448,6 @@ int fake_hid_connadd(struct fake_input *fake,
GIOChannel *intr_io,
 	g_io_channel_set_close_on_unref(fake->io, TRUE);
 	g_io_add_watch(fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) fake_hid->event, fake);
-
+	g_io_add_watch(fake->io, G_IO_OUT, (GIOFunc) fake_hid->oevent, fake);
 	return 0;
 }
diff --git a/input/fakehid.h b/input/fakehid.h
index bda4f43..dfac4f6 100644
--- a/input/fakehid.h
+++ b/input/fakehid.h
@@ -30,6 +30,7 @@ struct fake_hid {
 	gboolean (*connect) (struct fake_input *fake_input, GError **err);
 	int (*disconnect) (struct fake_input *fake_input);
 	gboolean (*event) (GIOChannel *chan, GIOCondition cond, gpointer data);
+	gboolean (*oevent) (GIOChannel *chan, GIOCondition cond, gpointer data);
 	int (*setup_uinput) (struct fake_input *fake, struct fake_hid *fake_hid);
 	GSList *fakes;
 };
-- 
1.6.0.4



-- 
Looking forward to reading yours.
     Ruslan N. Marchenko
