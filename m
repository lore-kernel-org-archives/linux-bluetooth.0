Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 10/12] android/hog: Fix using the same callback for different descriptors
Date: Fri, 27 Jun 2014 21:08:58 +0300
Message-Id: <1403892540-21222-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

External Report and Report descriptors take different user_data so have
different callbacks to avoid possible crash if a discover happen to find
the descriptors of unexpect type.
---
 android/hog.c | 80 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 42b7d73..ad4eee5 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -166,14 +166,14 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
 
-static void write_ccc(uint16_t handle, gpointer user_data)
+static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
 {
-	struct report *report = user_data;
-	struct bt_hog *hog = report->hog;
-	uint8_t value[] = { 0x01, 0x00 };
+	uint8_t value[2];
+
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	gatt_write_char(hog->attrib, handle, value, sizeof(value),
-					report_ccc_written_cb, report);
+	gatt_write_char(attrib, handle, value, sizeof(value),
+					report_ccc_written_cb, user_data);
 }
 
 static void report_reference_cb(guint8 status, const guint8 *pdu,
@@ -200,15 +200,45 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data);
 
-static void discover_descriptor_cb(uint8_t status, GSList *descs,
-								void *user_data)
+static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
 {
-	struct report *report;
-	struct bt_hog *hog;
-	GAttrib *attrib = NULL;
+	struct bt_hog *hog = user_data;
 
 	if (status != 0) {
-		error("Discover all descriptors failed: %s",
+		error("Discover external descriptors failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for ( ; descs; descs = descs->next) {
+		struct gatt_desc *desc = descs->data;
+
+		gatt_read_char(hog->attrib, desc->handle,
+					external_report_reference_cb, hog);
+	}
+}
+
+static void discover_external(GAttrib *attrib, uint16_t start, uint16_t end,
+							gpointer user_data)
+{
+	bt_uuid_t uuid;
+
+	if (start > end)
+		return;
+
+	bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
+
+	gatt_discover_desc(attrib, start, end, NULL, discover_external_cb,
+								user_data);
+}
+
+static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
+{
+	struct report *report = user_data;
+	struct bt_hog *hog = report->hog;
+
+	if (status != 0) {
+		error("Discover report descriptors failed: %s",
 							att_ecode2str(status));
 		return;
 	}
@@ -218,34 +248,24 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
-			report = user_data;
-			attrib = report->hog->attrib;
-			write_ccc(desc->handle, report);
+			write_ccc(hog->attrib, desc->handle, report);
 			break;
 		case GATT_REPORT_REFERENCE:
-			report = user_data;
-			attrib = report->hog->attrib;
-			gatt_read_char(attrib, desc->handle,
+			gatt_read_char(hog->attrib, desc->handle,
 						report_reference_cb, report);
 			break;
-		case GATT_EXTERNAL_REPORT_REFERENCE:
-			hog = user_data;
-			attrib = hog->attrib;
-			gatt_read_char(attrib, desc->handle,
-					external_report_reference_cb, hog);
-			break;
 		}
 	}
 }
 
-static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
+static void discover_report(GAttrib *attrib, uint16_t start, uint16_t end,
 							gpointer user_data)
 {
 	if (start > end)
 		return;
 
-	gatt_discover_desc(attrib, start, end, NULL,
-					discover_descriptor_cb, user_data);
+	gatt_discover_desc(attrib, start, end, NULL, discover_report_cb,
+								user_data);
 }
 
 static void external_service_char_cb(uint8_t status, GSList *chars,
@@ -278,7 +298,7 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 		hog->reports = g_slist_append(hog->reports, report);
 		start = chr->value_handle + 1;
 		end = (next ? next->handle - 1 : primary->range.end);
-		discover_descriptor(hog->attrib, start, end, report);
+		discover_report(hog->attrib, start, end, report);
 	}
 }
 
@@ -614,11 +634,11 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 			report->hog = hog;
 			report->decl = g_memdup(chr, sizeof(*chr));
 			hog->reports = g_slist_append(hog->reports, report);
-			discover_descriptor(hog->attrib, start, end, report);
+			discover_report(hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
 			gatt_read_char(hog->attrib, chr->value_handle,
 						report_map_read_cb, hog);
-			discover_descriptor(hog->attrib, start, end, hog);
+			discover_external(hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-- 
1.9.3

