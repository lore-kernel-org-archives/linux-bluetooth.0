Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH 15/21] hog: Add support for uHID events
Date: Tue,  3 Jul 2012 15:43:07 -0300
Message-Id: <1341340993-7480-16-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the GLib GIOChannel watcher to monitor uhid events.
---
 input/hog_device.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/input/hog_device.c b/input/hog_device.c
index 53b4746..b812ed5 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -53,6 +53,7 @@
 
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
+
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
@@ -67,6 +68,7 @@ struct hog_device {
 	GSList			*reports;
 	int			uhid_fd;
 	gboolean		prepend_id;
+	guint			uhid_watch_id;
 };
 
 struct report {
@@ -331,6 +333,36 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	}
 }
 
+static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
+	ssize_t bread;
+	int fd;
+
+	if (cond & (G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	fd = g_io_channel_unix_get_fd(io);
+	memset(&ev, 0, sizeof(ev));
+
+	bread = read(fd, &ev, sizeof(ev));
+	if (bread < 0) {
+		int err = -errno;
+		DBG("uhid-dev read: %s(%d)", strerror(err), err);
+		goto failed;
+	}
+
+	DBG("uHID event type %d received", ev.type);
+
+	return TRUE;
+
+failed:
+	hogdev->uhid_watch_id = 0;
+	return FALSE;
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -429,6 +461,8 @@ int hog_device_register(struct btd_device *device, const char *path)
 {
 	struct hog_device *hogdev;
 	struct gatt_primary *prim;
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
+	GIOChannel *io;
 
 	hogdev = find_device_by_path(devices, path);
 	if (hogdev)
@@ -449,12 +483,19 @@ int hog_device_register(struct btd_device *device, const char *path)
 		return -errno;
 	}
 
+	io = g_io_channel_unix_new(hogdev->uhid_fd);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	hogdev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb,
+								hogdev);
+	g_io_channel_unref(io);
+
 	hogdev->hog_primary = g_memdup(prim, sizeof(*prim));
 
 	hogdev->attioid = btd_device_add_attio_callback(device,
 							attio_connected_cb,
 							attio_disconnected_cb,
 							hogdev);
+
 	device_set_auto_connect(device, TRUE);
 
 	devices = g_slist_append(devices, hogdev);
@@ -472,6 +513,11 @@ int hog_device_unregister(const char *path)
 
 	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
 
+	if (hogdev->uhid_watch_id) {
+		g_source_remove(hogdev->uhid_watch_id);
+		hogdev->uhid_watch_id = 0;
+	}
+
 	close(hogdev->uhid_fd);
 	hogdev->uhid_fd = -1;
 
-- 
1.7.10.4

