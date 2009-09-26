Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 26 Sep 2009 16:31:08 +0200
Message-ID: <a70b8cd30909260731o4c95dcb1tf07955e368b11b30@mail.gmail.com>
Subject: [PATCH 3/4] Bluez: input: PS3 BD Remote "PS" button handling (turn
	off)
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If you hold PS button on PS3 BD Remote for more then 5 seconds, it
disconnects BT channel, entering low power mode. This patch enables
fakehid driver to handle this behaviour. It also delays PS button
keypress event till release, to avoid sending the events if you are
turning the remote off.

The patch also fixes poll loop, when BT channel disconnects from
remote controller (i.e. with PS button or by removing batteries),
bursting CPU to 100%.

Signed-off-by: Ruslan N. Marchenko <rufferson@gmail.com>
---
 input/device.h  |    2 +
 input/fakehid.c |   77 +++++++++++++++++++++++++++++++++++++-----------------
 input/fakehid.h |    1 +
 3 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/input/device.h b/input/device.h
index 7cbfe9f..c019930 100644
--- a/input/device.h
+++ b/input/device.h
@@ -55,6 +55,8 @@ struct fake_input {
 	void		*priv;
 	void		*data;
 	const struct input_device * idev;
+	guint		sid_in;
+	guint		sid_out;
 };

 int fake_input_register(DBusConnection *conn, struct btd_device *device,
diff --git a/input/fakehid.c b/input/fakehid.c
index b068e22..3687ea7 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -209,7 +209,31 @@ error:
 					ps3->lastmask & 0xff, ps3->lastkey);
 	return -1;
 }
+static gboolean ps3remote_sendkey(int uinput, unsigned int key,
+				  unsigned int value)
+{
+	struct uinput_event event;
+
+	memset(&event, 0, sizeof(event));
+	gettimeofday(&event.time, NULL);
+	event.type = EV_KEY;
+	event.code = key;
+	event.value = value;
+	if (write(uinput, &event, sizeof(event)) != sizeof(event)) {
+		error("Error writing to uinput device");
+		return FALSE;
+	}

+	memset(&event, 0, sizeof(event));
+	gettimeofday(&event.time, NULL);
+	event.type = EV_SYN;
+	event.code = SYN_REPORT;
+	if (write(uinput, &event, sizeof(event)) != sizeof(event)) {
+		error("Error writing to uinput device");
+		return FALSE;
+	}
+	return TRUE;
+}
 static gboolean ps3remote_out(GIOChannel *chan, GIOCondition cond,
                                 gpointer data)
 {
@@ -223,7 +247,7 @@ static gboolean ps3remote_out(GIOChannel *chan,
GIOCondition cond,
 		device_request_disconnect(idev->device, NULL);
 		return FALSE;
 	} else
-		usleep(100);
+		usleep(750);
 	return TRUE;
 }
 static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
@@ -231,14 +255,19 @@ static gboolean ps3remote_event(GIOChannel
*chan, GIOCondition cond,
 {
 	struct fake_input *fake = data;
 	struct ps3remote_data *ps3 = (struct ps3remote_data *)fake->data;
-	struct uinput_event event;
 	unsigned int key, value = 0;
 	gsize size;
 	char buff[50];

 	g_timer_start(ps3->timer);
-	if (cond & G_IO_NVAL)
-		return FALSE;
+	if (cond & G_IO_NVAL) {
+		if(ps3->lastkey == KEY_HOMEPAGE && ps3->lastval == 1)
+			DBG("Remote turned off");
+		else
+			DBG("Remote disconnected [%u:%u]", ps3->lastkey,
+								ps3->lastval);
+		goto failed;
+	}

 	if (cond & (G_IO_HUP | G_IO_ERR)) {
 		error("Hangup or error on rfcomm server socket");
@@ -260,29 +289,27 @@ static gboolean ps3remote_event(GIOChannel
*chan, GIOCondition cond,
 	} else if (key == KEY_MAX)
 		return TRUE;

-	memset(&event, 0, sizeof(event));
-	gettimeofday(&event.time, NULL);
-	event.type = EV_KEY;
-	event.code = key;
-	event.value = value;
-	if (write(fake->uinput, &event, sizeof(event)) != sizeof(event)) {
-		error("Error writing to uinput device");
-		goto failed;
-	}
-
-	memset(&event, 0, sizeof(event));
-	gettimeofday(&event.time, NULL);
-	event.type = EV_SYN;
-	event.code = SYN_REPORT;
-	if (write(fake->uinput, &event, sizeof(event)) != sizeof(event)) {
-		error("Error writing to uinput device");
+	/* Delaying key till release, assuming possible turn-off */
+	if(key == KEY_HOMEPAGE) {
+		if(value == 0 && ps3->lastkey == KEY_HOMEPAGE
+							&& ps3->lastval == 1) {
+			ps3remote_sendkey(fake->uinput, key, 1);
+			ps3remote_sendkey(fake->uinput, key, 0);
+		} else
+			DBG("Delayed: %u:%u (%u:%u)", key, value,
+						ps3->lastkey, ps3->lastval);
+	} else if(!ps3remote_sendkey(fake->uinput, key, value))
 		goto failed;
-	}

+	ps3->lastkey = key;
+	ps3->lastval = value;
+	DBG("Passed key %u:%u", key, value);
 	return TRUE;

 failed:
 	g_timer_stop(ps3->timer);
+	g_source_remove(fake->sid_in);
+	g_source_remove(fake->sid_out);
 	g_io_channel_unref(fake->io);
 	DBG("Event failed");
 	return FALSE;
@@ -446,8 +473,10 @@ int fake_hid_connadd(struct fake_input *fake,
GIOChannel *intr_io,

 	fake->io = g_io_channel_ref(intr_io);
 	g_io_channel_set_close_on_unref(fake->io, TRUE);
-	g_io_add_watch(fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					(GIOFunc) fake_hid->event, fake);
-	g_io_add_watch(fake->io, G_IO_OUT, (GIOFunc) fake_hid->oevent, fake);
+	fake->sid_in = g_io_add_watch(fake->io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) fake_hid->event, fake);
+	fake->sid_out = g_io_add_watch(fake->io, G_IO_OUT,
+				(GIOFunc) fake_hid->oevent, fake);
 	return 0;
 }
diff --git a/input/fakehid.h b/input/fakehid.h
index dfac4f6..8657c76 100644
--- a/input/fakehid.h
+++ b/input/fakehid.h
@@ -37,6 +37,7 @@ struct fake_hid {

 struct ps3remote_data {
 	unsigned int	lastkey;
+	unsigned int	lastval;
 	unsigned int	lastmask;
 	GTimer *	timer;
 	uint16_t 	timeout;
-- 
1.6.0.4



-- 
Looking forward to reading yours.
     Ruslan N. Marchenko
