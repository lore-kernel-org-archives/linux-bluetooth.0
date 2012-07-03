Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH 05/21] hog: Discover all characteristics declaration
Date: Tue,  3 Jul 2012 15:42:57 -0300
Message-Id: <1341340993-7480-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HID service supports multiple report characteristic. Each report
characteristic has a reference descriptor containing ID and type.
---
 input/hog_device.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/input/hog_device.c b/input/hog_device.c
index 1f11f34..786bc1b 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -47,21 +47,65 @@
 #include "attio.h"
 #include "gatt.h"
 
+#define HOG_REPORT_UUID		0x2A4D
+
+struct report {
+	struct gatt_char *decl;
+};
+
 struct hog_device {
 	char			*path;
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
 	struct gatt_primary	*hog_primary;
+	GSList			*reports;
 };
 
 static GSList *devices = NULL;
 
+static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	bt_uuid_t report_uuid;
+	struct report *report;
+	GSList *l;
+
+	if (status != 0) {
+		const char *str = att_ecode2str(status);
+		DBG("Discover all characteristics failed: %s", str);
+		return;
+	}
+
+	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
+
+	for (l = chars; l; l = g_slist_next(l)) {
+		struct gatt_char *chr = l->data;
+		bt_uuid_t uuid;
+
+		DBG("0x%04x UUID: %s properties: %02x",
+				chr->handle, chr->uuid, chr->properties);
+
+		bt_string_to_uuid(&uuid, chr->uuid);
+
+		if (bt_uuid_cmp(&uuid, &report_uuid) != 0)
+			continue;
+
+		report = g_new0(struct report, 1);
+		report->decl = g_memdup(chr, sizeof(*chr));
+		hogdev->reports = g_slist_append(hogdev->reports, report);
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct gatt_primary *prim = hogdev->hog_primary;
 
 	hogdev->attrib = g_attrib_ref(attrib);
+
+	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
+					NULL, char_discovered_cb, hogdev);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
@@ -148,9 +192,17 @@ int hog_device_register(struct btd_device *device, const char *path)
 	return 0;
 }
 
+static void report_free(void *data)
+{
+	struct report *report = data;
+	g_free(report->decl);
+	g_free(report);
+}
+
 static void hog_device_free(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
+	g_slist_free_full(hogdev->reports, report_free);
 	g_free(hogdev->path);
 	g_free(hogdev->hog_primary);
 	g_free(hogdev);
-- 
1.7.10.4

