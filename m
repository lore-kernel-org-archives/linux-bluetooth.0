Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2009 18:10:41 +0200
Message-ID: <a70b8cd30908190910p35910657m28fe09905717d60@mail.gmail.com>
Subject: PATCH for input/fakehid.c to fix PS3 remote unpairing
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Here is the patch to correctly handle PS3 remote unpairing and manual
turning off.

--- bluez-4.47/input/fakehid.c	2009-04-23 03:40:04.000000000 +0200
+++ bluez-4.47-my/input/fakehid.c	2009-08-19 18:02:53.000000000 +0200
@@ -208,18 +208,49 @@
 						lastmask & 0xff, lastkey);
 	return -1;
 }
+static gboolean ps3remote_sendkey(int uinput, unsigned int key,
+				  unsigned int value)
+{
+	struct uinput_event event;
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
 static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
+	static unsigned int lastkey = 0;
+	static unsigned int lastval = 0;
 	struct fake_input *fake = data;
-	struct uinput_event event;
 	unsigned int key, value = 0;
 	gsize size;
 	char buff[50];

-	if (cond & G_IO_NVAL)
-		return FALSE;
+	if (cond & G_IO_NVAL) {
+		if(lastkey == KEY_HOMEPAGE && lastval == 1) {
+			DBG("ps3remote_event: Remote turned off");
+			goto failed;
+		} else {
+			DBG("ps3remote_event: Remote unpaired [%u:%u]", lastkey, lastval);
+			goto failed;
+		}
+	}

 	if (cond & (G_IO_HUP | G_IO_ERR)) {
 		error("Hangup or error on rfcomm server socket");
@@ -240,26 +271,18 @@
 		goto failed;
 	} else if (key == KEY_MAX)
 		return TRUE;
-
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
+		if(value == 0 && lastkey == KEY_HOMEPAGE && lastval == 1) {
+			ps3remote_sendkey(fake->uinput, key, 1);
+			ps3remote_sendkey(fake->uinput, key, 0);
+		} else
+			DBG("ps3remote_event: Delayed: %u:%u (%u:%u)", key, value,
lastkey, lastval);
+	} else if(!ps3remote_sendkey(fake->uinput, key, value))
 		goto failed;
-	}
-
+	lastkey = key;
+	lastval = value;
+	DBG("ps3remote_event: %u:%u", key, value);
 	return TRUE;

 failed:
@@ -267,7 +290,7 @@
 	close(fake->uinput);
 	fake->uinput = -1;
 	g_io_channel_unref(fake->io);
-
+	DBG("ps3remote_event: input device removed.");
 	return FALSE;
 }

I'm also thinking on implementing keymapping through input.conf
configuration section. Will it be accepted or not worth trying?

-- 
----
Looking forward to reading yours.
 RUFF-RIPE DI76-GANDI RUFF-6BONE
     Ruslan N. Marchenko
