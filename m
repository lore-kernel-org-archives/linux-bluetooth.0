Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/2] hog: Add support for multiple instances
Date: Wed, 19 Sep 2012 16:33:42 -0300
Message-Id: <1348083222-15294-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348083222-15294-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348083222-15294-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for multiple HID services instances exposed by
the same remote device.
---

 *** Apply after "[PATCH BlueZ v2 0/6] HoG Suspend/Resume" series

 profiles/input/hog_device.c  | 90 +++++++++++---------------------------------
 profiles/input/hog_device.h  |  3 +-
 profiles/input/hog_manager.c | 41 ++++++++++++--------
 3 files changed, 48 insertions(+), 86 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index e68134c..11ce177 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -46,13 +46,13 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 
-#include "hog_device.h"
-
 #include "att.h"
 #include "gattrib.h"
 #include "attio.h"
 #include "gatt.h"
 
+#include "hog_device.h"
+
 #define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
@@ -72,7 +72,7 @@
 #define HID_INFO_SIZE			4
 
 struct hog_device {
-	char			*path;
+	uint16_t		id;
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
@@ -147,8 +147,8 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
 	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
 		error("uHID write failed: %s", strerror(errno));
 	else
-		DBG("Report from HoG device %s written to uHID fd %d",
-						hogdev->path, hogdev->uhid_fd);
+		DBG("Report from HoG device 0x%04X written to uHID fd %d",
+						hogdev->id, hogdev->uhid_fd);
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -428,14 +428,14 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (value == HOG_PROTO_MODE_BOOT) {
 		uint8_t nval = HOG_PROTO_MODE_REPORT;
 
-		DBG("HoG device %s is operating in Boot Procotol Mode",
-								hogdev->path);
+		DBG("HoG device 0x%04X is operating in Boot Procotol Mode",
+								hogdev->id);
 
 		gatt_write_char(hogdev->attrib, hogdev->proto_mode_handle, &nval,
 						sizeof(nval), NULL, NULL);
 	} else if (value == HOG_PROTO_MODE_REPORT)
-		DBG("HoG device %s is operating in Report Protocol Mode",
-								hogdev->path);
+		DBG("HoG device 0x%04X is operating in Report Protocol Mode",
+								hogdev->id);
 }
 
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
@@ -548,8 +548,8 @@ static void forward_report(struct hog_device *hogdev,
 
 	report = l->data;
 
-	DBG("Sending report type %d to device %s handle 0x%X", type,
-				hogdev->path, report->decl->value_handle);
+	DBG("Sending report type %d to device 0x%04X handle 0x%X", type,
+				hogdev->id, report->decl->value_handle);
 
 	if (report->decl->properties & ATT_CHAR_PROPER_WRITE)
 		gatt_write_char(hogdev->attrib, report->decl->value_handle,
@@ -633,20 +633,8 @@ static void attio_disconnected_cb(gpointer user_data)
 	hogdev->attrib = NULL;
 }
 
-struct hog_device *hog_device_find(GSList *list, const char *path)
-{
-	for (; list; list = list->next) {
-		struct hog_device *hogdev = list->data;
-
-		if (!strcmp(hogdev->path, path))
-			return hogdev;
-	}
-
-	return NULL;
-}
-
 static struct hog_device *hog_device_new(struct btd_device *device,
-							const char *path)
+								uint16_t id)
 {
 	struct hog_device *hogdev;
 
@@ -654,31 +642,12 @@ static struct hog_device *hog_device_new(struct btd_device *device,
 	if (!hogdev)
 		return NULL;
 
-	hogdev->path = g_strdup(path);
+	hogdev->id = id;
 	hogdev->device = btd_device_ref(device);
 
 	return hogdev;
 }
 
-static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct gatt_primary *prim = a;
-	const char *uuid = b;
-
-	return g_strcmp0(prim->uuid, uuid);
-}
-
-static struct gatt_primary *load_hog_primary(struct btd_device *device)
-{
-	GSList *primaries, *l;
-
-	primaries = btd_device_get_primaries(device);
-
-	l = g_slist_find_custom(primaries, HOG_UUID, primary_uuid_cmp);
-
-	return (l ? l->data : NULL);
-}
-
 static void report_free(void *data)
 {
 	struct report *report = data;
@@ -690,38 +659,27 @@ static void hog_device_free(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
 	g_slist_free_full(hogdev->reports, report_free);
-	g_free(hogdev->path);
 	g_free(hogdev->hog_primary);
 	g_free(hogdev);
 }
 
 struct hog_device *hog_device_register(struct btd_device *device,
-					const char *path, int *perr)
+						struct gatt_primary *prim)
 {
-	struct gatt_primary *prim;
 	struct hog_device *hogdev;
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
 	GIOChannel *io;
-	int err;
 
-	prim = load_hog_primary(device);
-	if (!prim) {
-		err = -EINVAL;
-		goto failed;
-	}
-
-	hogdev = hog_device_new(device, path);
-	if (!hogdev) {
-		err = -ENOMEM;
-		goto failed;
-	}
+	hogdev = hog_device_new(device, prim->range.start);
+	if (!hogdev)
+		return NULL;
 
 	hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
 	if (hogdev->uhid_fd < 0) {
-		err = -errno;
-		error("Failed to open uHID device: %s", strerror(-err));
+		error("Failed to open uHID device: %s(%d)", strerror(errno),
+									errno);
 		hog_device_free(hogdev);
-		goto failed;
+		return NULL;
 	}
 
 	io = g_io_channel_unix_new(hogdev->uhid_fd);
@@ -740,12 +698,6 @@ struct hog_device *hog_device_register(struct btd_device *device,
 	device_set_auto_connect(device, TRUE);
 
 	return hogdev;
-
-failed:
-	if (perr)
-		*perr = err;
-
-	return NULL;
 }
 
 int hog_device_unregister(struct hog_device *hogdev)
@@ -779,7 +731,7 @@ int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend)
 	if (hogdev->attrib == NULL)
 		return -ENOTCONN;
 
-	DBG("%s HID Control Point: %s", hogdev->path, suspend ?
+	DBG("0x%4X HID Control Point: %s", hogdev->id, suspend ?
 						"Suspend" : "Exit Suspend");
 
 	if (hogdev->ctrlpt_handle == 0)
diff --git a/profiles/input/hog_device.h b/profiles/input/hog_device.h
index 03f1c90..d1bfc08 100644
--- a/profiles/input/hog_device.h
+++ b/profiles/input/hog_device.h
@@ -28,7 +28,6 @@
 struct hog_device;
 
 struct hog_device *hog_device_register(struct btd_device *device,
-						const char *path, int *perr);
+						struct gatt_primary *prim);
 int hog_device_unregister(struct hog_device *hogdev);
-struct hog_device *hog_device_find(GSList *list, const char *path);
 int hog_device_set_control_point(struct hog_device *hogdev, gboolean suspend);
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 45c6abf..9145ac5 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -29,6 +29,9 @@
 #include <errno.h>
 #include <stdbool.h>
 
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
+
 #include "log.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
@@ -38,6 +41,9 @@
 #include "hcid.h"
 #include "device.h"
 #include "suspend.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt.h"
 #include "hog_device.h"
 
 static gboolean suspend_supported = FALSE;
@@ -72,36 +78,41 @@ static void resume_callback(void)
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
-	struct hog_device *hogdev;
-	int err;
+	GSList *primaries, *l;
 
 	DBG("path %s", path);
 
-	hogdev = hog_device_find(devices, path);
-	if (hogdev)
-		return -EALREADY;
+	primaries = btd_device_get_primaries(device);
+	if (primaries == NULL)
+		return -EINVAL;
 
-	hogdev = hog_device_register(device, path, &err);
-	if (hogdev == NULL)
-		return err;
+	for (l = primaries; l; l = g_slist_next(l)) {
+		struct gatt_primary *prim = l->data;
+		struct hog_device *hogdev;
 
-	devices = g_slist_append(devices, hogdev);
+		hogdev = hog_device_register(device, prim);
+		if (hogdev == NULL)
+			continue;
+
+		devices = g_slist_append(devices, hogdev);
+	}
 
 	return 0;
 }
 
+static void remove_device(gpointer hogdev, gpointer b)
+{
+	devices = g_slist_remove(devices, hogdev);
+	hog_device_unregister(hogdev);
+}
+
 static void hog_device_remove(struct btd_device *device)
 {
 	const gchar *path = device_get_path(device);
-	struct hog_device *hogdev;
 
 	DBG("path %s", path);
 
-	hogdev = hog_device_find(devices, path);
-	if (hogdev) {
-		devices = g_slist_remove(devices, hogdev);
-		hog_device_unregister(hogdev);
-	}
+	g_slist_foreach(devices, remove_device, NULL);
 }
 
 static struct btd_profile hog_profile = {
-- 
1.7.12

