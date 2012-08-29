Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 5/6] hog: Move HoG device list to manager
Date: Wed, 29 Aug 2012 17:53:09 -0300
Message-Id: <1346273590-16693-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
 <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves the HoG device list from hog_device.c to hog_manager.c
in order to be possible to easily notify suspend/resume events to each
created device.
---
 profiles/input/hog_device.c  | 46 +++++++++++++++++++++-----------------------
 profiles/input/hog_device.h  |  8 ++++++--
 profiles/input/hog_manager.c | 22 +++++++++++++++++++--
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 000f173..af21f24 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -93,8 +93,6 @@ struct report {
 	struct hog_device	*hogdev;
 };
 
-static GSList *devices = NULL;
-
 static gint report_handle_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct report *report = a;
@@ -628,7 +626,7 @@ static void attio_disconnected_cb(gpointer user_data)
 	hogdev->attrib = NULL;
 }
 
-static struct hog_device *find_device_by_path(GSList *list, const char *path)
+struct hog_device *hog_device_find(GSList *list, const char *path)
 {
 	for (; list; list = list->next) {
 		struct hog_device *hogdev = list->data;
@@ -690,31 +688,33 @@ static void hog_device_free(struct hog_device *hogdev)
 	g_free(hogdev);
 }
 
-int hog_device_register(struct btd_device *device, const char *path)
+struct hog_device *hog_device_register(struct btd_device *device,
+					const char *path, int *perr)
 {
-	struct hog_device *hogdev;
 	struct gatt_primary *prim;
+	struct hog_device *hogdev;
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
 	GIOChannel *io;
-
-	hogdev = find_device_by_path(devices, path);
-	if (hogdev)
-		return -EALREADY;
+	int err;
 
 	prim = load_hog_primary(device);
-	if (!prim)
-		return -EINVAL;
+	if (!prim) {
+		err = -EINVAL;
+		goto failed;
+	}
 
 	hogdev = hog_device_new(device, path);
-	if (!hogdev)
-		return -ENOMEM;
+	if (!hogdev) {
+		err = -ENOMEM;
+		goto failed;
+	}
 
 	hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
 	if (hogdev->uhid_fd < 0) {
-		int err = -errno;
+		err = -errno;
 		error("Failed to open uHID device: %s", strerror(-err));
 		hog_device_free(hogdev);
-		return err;
+		goto failed;
 	}
 
 	io = g_io_channel_unix_new(hogdev->uhid_fd);
@@ -732,20 +732,19 @@ int hog_device_register(struct btd_device *device, const char *path)
 
 	device_set_auto_connect(device, TRUE);
 
-	devices = g_slist_append(devices, hogdev);
+	return hogdev;
 
-	return 0;
+failed:
+	if (perr)
+		*perr = err;
+
+	return NULL;
 }
 
-int hog_device_unregister(const char *path)
+int hog_device_unregister(struct hog_device *hogdev)
 {
-	struct hog_device *hogdev;
 	struct uhid_event ev;
 
-	hogdev = find_device_by_path(devices, path);
-	if (hogdev == NULL)
-		return -EINVAL;
-
 	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
 
 	if (hogdev->uhid_watch_id) {
@@ -761,7 +760,6 @@ int hog_device_unregister(const char *path)
 	close(hogdev->uhid_fd);
 	hogdev->uhid_fd = -1;
 
-	devices = g_slist_remove(devices, hogdev);
 	hog_device_free(hogdev);
 
 	return 0;
diff --git a/profiles/input/hog_device.h b/profiles/input/hog_device.h
index 597dc7c..efb7b4f 100644
--- a/profiles/input/hog_device.h
+++ b/profiles/input/hog_device.h
@@ -25,5 +25,9 @@
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
-int hog_device_register(struct btd_device *device, const char *path);
-int hog_device_unregister(const char *path);
+struct hog_device;
+
+struct hog_device *hog_device_register(struct btd_device *device,
+						const char *path, int *perr);
+int hog_device_unregister(struct hog_device *hogdev);
+struct hog_device *hog_device_find(GSList *list, const char *path);
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 9c23980..c83c345 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -39,6 +39,7 @@
 #include "hog_device.h"
 
 static gboolean suspend_supported = FALSE;
+static GSList *devices = NULL;
 
 static void suspend_callback(void)
 {
@@ -53,19 +54,36 @@ static void resume_callback(void)
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
+	struct hog_device *hogdev;
+	int err;
 
 	DBG("path %s", path);
 
-	return hog_device_register(device, path);
+	hogdev = hog_device_find(devices, path);
+	if (hogdev)
+		return -EALREADY;
+
+	hogdev = hog_device_register(device, path, &err);
+	if (hogdev == NULL)
+		return err;
+
+	devices = g_slist_append(devices, hogdev);
+
+	return 0;
 }
 
 static void hog_device_remove(struct btd_device *device)
 {
 	const gchar *path = device_get_path(device);
+	struct hog_device *hogdev;
 
 	DBG("path %s", path);
 
-	hog_device_unregister(path);
+	hogdev = hog_device_find(devices, path);
+	if (hogdev) {
+		devices = g_slist_remove(devices, hogdev);
+		hog_device_unregister(hogdev);
+	}
 }
 
 static struct btd_device_driver hog_driver = {
-- 
1.7.12

