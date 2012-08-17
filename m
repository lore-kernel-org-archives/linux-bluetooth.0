Return-Path: <cyrus@holtmann.org>
From: Jeff Hansen <x@jeffhansen.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jeff Hansen <x@jeffhansen.com>
Subject: [PATCH] input: Implement idle timeout for fakehid.
Date: Fri, 17 Aug 2012 10:34:38 -0600
Message-Id: <1345221278-28490-1-git-send-email-x@jeffhansen.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The batteries on my BD remote would die in a few days without this patch.
Now they've been going for weeks (hopefully months).
---
 profiles/input/device.c  |    6 ++++++
 profiles/input/device.h  |    4 ++++
 profiles/input/fakehid.c |   18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 48d397a..31c970d 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -638,6 +638,7 @@ static int hidp_add_connection(const struct input_device *idev,
 		fake->disconnect = fake_hid_disconnect;
 		fake->priv = fake_hid;
 		fake->idev = idev;
+		fake->timeout = iconn->timeout * 1000;
 		fake = fake_hid_connadd(fake, iconn->intr_io, fake_hid);
 		if (fake == NULL)
 			err = -ENOMEM;
@@ -1307,3 +1308,8 @@ int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst)
 
 	return 0;
 }
+
+void input_device_request_disconnect(const struct input_device *idev)
+{
+	device_request_disconnect(idev->device, NULL);
+}
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 509a353..1b490b4 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -37,6 +37,8 @@ struct fake_input {
 	int		(*disconnect) (struct input_conn *iconn);
 	void		*priv;
 	const struct input_device *idev;
+	guint		idle_timeout;
+	uint32_t	timeout;
 };
 
 int fake_input_register(DBusConnection *conn, struct btd_device *device,
@@ -49,3 +51,5 @@ int input_device_unregister(const char *path, const char *uuid);
 int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
 int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
+
+void input_device_request_disconnect(const struct input_device *idev);
diff --git a/profiles/input/fakehid.c b/profiles/input/fakehid.c
index 3be1489..a92622f 100644
--- a/profiles/input/fakehid.c
+++ b/profiles/input/fakehid.c
@@ -199,6 +199,13 @@ error:
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
@@ -209,6 +216,13 @@ static gboolean ps3remote_event(GIOChannel *chan, GIOCondition cond,
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
 
@@ -328,6 +342,10 @@ static gboolean fake_hid_common_connect(struct fake_input *fake, GError **err)
 
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

