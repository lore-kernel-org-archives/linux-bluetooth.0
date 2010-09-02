Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Remember fake devices for the daemon's lifetime
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: rufferson@gmail.com
Content-Type: multipart/mixed; boundary="=-Jf1i3m1+w5J0TOg1fivC"
Date: Thu, 02 Sep 2010 17:55:47 +0100
Message-ID: <1283446547.2361.68.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Jf1i3m1+w5J0TOg1fivC
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

Here's a rework of Ruslan's patch. This should make PS3 BD remotes
faster to reconnect, by not having to setup uinput every time.

Next I'll look at implementing idle for that particular remote, as well
as being able to turn it off from the remote itself.

I won't make the keymap or the idle timeout configurable as in the
original patches.

Cheers

--=-Jf1i3m1+w5J0TOg1fivC
Content-Disposition: attachment; filename="0001-Remember-fake-devices-for-the-daemon-s-lifetime.patch"
Content-Type: text/x-patch; name="0001-Remember-fake-devices-for-the-daemon-s-lifetime.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 67177f5fc4750960dde9af9ec57f5e50f2770581 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 2 Sep 2010 17:09:37 +0100
Subject: [PATCH] Remember fake devices for the daemon's lifetime

This would allow faster reconnection of already known devices,
so that no keypresses would be lost when reconnecting.

We only setup uinput the first time around, which will avoid
problems with devices not disappearing when disconnected.

Based on patch by Ruslan N. Marchenko <rufferson@gmail.com>
---
 input/device.c  |    8 ++++++--
 input/device.h  |    1 +
 input/fakehid.c |   32 +++++++++++++++++++++++++++-----
 input/fakehid.h |    3 ++-
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/input/device.c b/input/device.c
index 0bcbbdb..b2885c4 100644
--- a/input/device.c
+++ b/input/device.c
@@ -635,12 +635,16 @@ static int hidp_add_connection(const struct input_device *idev,
 
 	fake_hid = get_fake_hid(req->vendor, req->product);
 	if (fake_hid) {
+		err = 0;
 		fake = g_new0(struct fake_input, 1);
 		fake->connect = fake_hid_connect;
 		fake->disconnect = fake_hid_disconnect;
 		fake->priv = fake_hid;
-		err = fake_hid_connadd(fake, iconn->intr_io, fake_hid);
-		if (err == 0)
+		fake->idev = idev;
+		fake = fake_hid_connadd(fake, iconn->intr_io, fake_hid);
+		if (fake == NULL)
+			err = -ENOMEM;
+		else
 			fake->flags |= FI_FLAG_CONNECTED;
 		goto cleanup;
 	}
diff --git a/input/device.h b/input/device.h
index 3390a0b..14c0f97 100644
--- a/input/device.h
+++ b/input/device.h
@@ -39,6 +39,7 @@ struct fake_input {
 	gboolean	(*connect) (struct input_conn *iconn, GError **err);
 	int		(*disconnect) (struct input_conn *iconn);
 	void		*priv;
+	const struct input_device *idev;
 };
 
 int fake_input_register(DBusConnection *conn, struct btd_device *device,
diff --git a/input/fakehid.c b/input/fakehid.c
index ee1f77a..6346a3e 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -348,6 +348,7 @@ static struct fake_hid fake_hid_table[] = {
 		.disconnect	= fake_hid_common_disconnect,
 		.event		= ps3remote_event,
 		.setup_uinput	= ps3remote_setup_uinput,
+		.devices	= NULL,
 	},
 
 	{ },
@@ -370,12 +371,33 @@ struct fake_hid *get_fake_hid(uint16_t vendor, uint16_t product)
 	return NULL;
 }
 
-int fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
+struct fake_input *fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
 						struct fake_hid *fake_hid)
 {
-	if (fake_hid->setup_uinput(fake, fake_hid)) {
-		error("Error setting up uinput");
-		return ENOMEM;
+	GList *l;
+	struct fake_input *old = NULL;
+
+	/* Look for an already setup device */
+	for (l = fake_hid->devices; l != NULL; l = l->next) {
+		old = l->data;
+		if (old->idev == fake->idev) {
+			g_free (fake);
+			fake = old;
+			fake_hid->connect(fake, NULL);
+			break;
+		}
+		old = NULL;
+	}
+
+	/* New device? Add it to the list of known devices,
+	 * and create the uinput necessary */
+	if (old == NULL) {
+		if (fake_hid->setup_uinput(fake, fake_hid)) {
+			error("Error setting up uinput");
+			g_free(fake);
+			return NULL;
+		}
+		fake_hid->devices = g_list_append(fake_hid->devices, fake);
 	}
 
 	fake->io = g_io_channel_ref(intr_io);
@@ -383,5 +405,5 @@ int fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
 	g_io_add_watch(fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) fake_hid->event, fake);
 
-	return 0;
+	return fake;
 }
diff --git a/input/fakehid.h b/input/fakehid.h
index 33b1e70..3a5d7c4 100644
--- a/input/fakehid.h
+++ b/input/fakehid.h
@@ -31,9 +31,10 @@ struct fake_hid {
 	int (*disconnect) (struct fake_input *fake_input);
 	gboolean (*event) (GIOChannel *chan, GIOCondition cond, gpointer data);
 	int (*setup_uinput) (struct fake_input *fake, struct fake_hid *fake_hid);
+	GList *devices;
 };
 
 struct fake_hid *get_fake_hid(uint16_t vendor, uint16_t product);
 
-int fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
+struct fake_input *fake_hid_connadd(struct fake_input *fake, GIOChannel *intr_io,
 						struct fake_hid *fake_hid);
-- 
1.7.0.1


--=-Jf1i3m1+w5J0TOg1fivC--

