Return-Path: <cyrus@holtmann.org>
Message-ID: <5018B6AF.10909@jeffhansen.com>
Date: Tue, 31 Jul 2012 22:55:11 -0600
From: Jeff Hansen <x@jeffhansen.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] input: Implement idle timeout for fakehid
Content-Type: multipart/mixed;
 boundary="------------000006050209080509090003"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000006050209080509090003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The batteries on my BD remote would die in a few days without this patch.


--------------000006050209080509090003
Content-Type: text/x-patch;
 name="0001-input-Implement-idle-timeout-for-fakehid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-input-Implement-idle-timeout-for-fakehid.patch"

>From a96f67cb6268e34e677e5d288f2c3b89acfca7fe Mon Sep 17 00:00:00 2001
From: Jeff Hansen <x@jeffhansen.com>
Date: Tue, 31 Jul 2012 22:45:23 -0600
Subject: [PATCH] input: Implement idle timeout for fakehid.

The batteries on my BD remote would die in a few days without this patch.

Signed-off-by: Jeff Hansen <x@jeffhansen.com>
---
 input/device.c  |    6 ++++++
 input/device.h  |    4 ++++
 input/fakehid.c |   18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/input/device.c b/input/device.c
index 0ab63c0..ae11a13 100644
--- a/input/device.c
+++ b/input/device.c
@@ -609,6 +609,7 @@ static int hidp_add_connection(const struct input_device *idev,
 		fake->disconnect = fake_hid_disconnect;
 		fake->priv = fake_hid;
 		fake->idev = idev;
+		fake->timeout = iconn->timeout * 1000;
 		fake = fake_hid_connadd(fake, iconn->intr_io, fake_hid);
 		if (fake == NULL)
 			err = -ENOMEM;
@@ -1257,3 +1258,8 @@ int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst)
 
 	return 0;
 }
+
+void input_device_request_disconnect(const struct input_device *idev)
+{
+	device_request_disconnect(idev->device, NULL);
+}
diff --git a/input/device.h b/input/device.h
index 14c0f97..416cc9c 100644
--- a/input/device.h
+++ b/input/device.h
@@ -40,6 +40,8 @@ struct fake_input {
 	int		(*disconnect) (struct input_conn *iconn);
 	void		*priv;
 	const struct input_device *idev;
+	guint		idle_timeout;
+	uint32_t	timeout;
 };
 
 int fake_input_register(DBusConnection *conn, struct btd_device *device,
@@ -54,3 +56,5 @@ int input_device_unregister(const char *path, const char *uuid);
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
 int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
+
+void input_device_request_disconnect(const struct input_device *idev);
diff --git a/input/fakehid.c b/input/fakehid.c
index b809870..0407ae3 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -208,6 +208,13 @@ error:
 	return -1;
 }
 
+static gboolean ps3remote_idle(gpointer data)
+{
+	struct fake_input *fake = data;
+	input_device_request_disconnect(fake->idev);
+	return FALSE;
+}
+
 static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
@@ -218,6 +225,13 @@ static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
 	char buff[50];
 	int fd;
 
+	if (fake->idle_timeout) {
+		g_source_remove(fake->idle_timeout);
+		fake->idle_timeout = 0;
+	}
+	if (fake->timeout)
+		fake->idle_timeout = g_timeout_add(fake->timeout, ps3remote_idle, fake);
+
 	if (cond & G_IO_NVAL)
 		return FALSE;
 
@@ -337,6 +351,10 @@ static gboolean fake_hid_common_connect(struct fake_input *fake, GError **err)
 
 static int fake_hid_common_disconnect(struct fake_input *fake)
 {
+	if (fake->idle_timeout) {
+		g_source_remove(fake->idle_timeout);
+		fake->idle_timeout = 0;
+	}
 	return 0;
 }
 
-- 
1.7.8.6


--------------000006050209080509090003--
