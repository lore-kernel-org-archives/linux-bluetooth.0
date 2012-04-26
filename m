Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [BlueZ 06/15] HoG: discover the "Report Map" characteristic
Date: Thu, 26 Apr 2012 16:45:36 -0300
Message-Id: <1335469545-1007-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1335469545-1007-1-git-send-email-jprvita@openbossa.org>
References: <1335469545-1007-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This characteristic contains the HID descriptor.
---
 input/hog_device.c |   46 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 5a81f41..c28d337 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -47,6 +47,7 @@
 #include "attio.h"
 #include "gatt.h"
 
+#define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
 
 struct report {
@@ -113,10 +114,35 @@ static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
 	gatt_find_info(attrib, start, end, discover_descriptor_cb, user_data);
 }
 
+static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	uint8_t value[ATT_MAX_MTU];
+	int vlen, i;
+
+	if (status != 0) {
+		error("Report Map read failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, plen, value, &vlen)) {
+		error("ATT protocol error");
+		return;
+	}
+
+	DBG("Report MAP:");
+	for (i = 0; i < vlen; i += 2) {
+		if (i + 1 == vlen)
+			DBG("\t %02x", value[i]);
+		else
+			DBG("\t %02x %02x", value[i], value[i + 1]);
+	}
+}
+
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
-	bt_uuid_t report_uuid;
+	bt_uuid_t report_uuid, report_map_uuid;
 	struct report *report;
 	GSList *l;
 
@@ -127,6 +153,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	}
 
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
+	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
@@ -140,14 +167,15 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 
 		bt_string_to_uuid(&uuid, chr->uuid);
 
-		if (bt_uuid_cmp(&uuid, &report_uuid) != 0)
-			continue;
-
-		report = g_new0(struct report, 1);
-		report->decl = g_memdup(chr, sizeof(*chr));
-		hogdev->reports = g_slist_append(hogdev->reports, report);
-
-		discover_descriptor(hogdev->attrib, chr, next, hogdev);
+		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
+			report = g_new0(struct report, 1);
+			report->decl = g_memdup(chr, sizeof(*chr));
+			hogdev->reports = g_slist_append(hogdev->reports,
+								report);
+			discover_descriptor(hogdev->attrib, chr, next, hogdev);
+		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0)
+			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
+						report_map_read_cb, hogdev);
 	}
 }
 
-- 
1.7.7.6

