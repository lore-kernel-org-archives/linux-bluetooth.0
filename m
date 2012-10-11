Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 2/2] hog: Fix requested range for descriptor discovery
Date: Thu, 11 Oct 2012 02:31:23 -0300
Message-Id: <1349933483-10436-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1349933483-10436-1-git-send-email-jprvita@openbossa.org>
References: <1349933483-10436-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When discovering descriptors of the last characteristic of a service the
discovery range was exceeding the service limits. This commit keeps the
discovery within the limits of the HoG service.
---
 profiles/input/hog_device.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index a25b8c2..1694b32 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -271,15 +271,11 @@ done:
 		g_free(ddcb_data);
 }
 
-static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
-				struct gatt_char *next, gpointer user_data)
+static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
+							gpointer user_data)
 {
-	uint16_t start, end;
 	struct disc_desc_cb_data *ddcb_data;
 
-	start = chr->value_handle + 1;
-	end = (next ? next->handle - 1 : 0xffff);
-
 	if (start > end)
 		return;
 
@@ -294,6 +290,7 @@ static void external_service_char_cb(GSList *chars, guint8 status,
 							gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct gatt_primary *prim = hogdev->hog_primary;
 	struct report *report;
 	GSList *l;
 
@@ -305,6 +302,7 @@ static void external_service_char_cb(GSList *chars, guint8 status,
 
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
+		uint16_t start, end;
 
 		chr = l->data;
 		next = l->next ? l->next->data : NULL;
@@ -316,7 +314,9 @@ static void external_service_char_cb(GSList *chars, guint8 status,
 		report->hogdev = hogdev;
 		report->decl = g_memdup(chr, sizeof(*chr));
 		hogdev->reports = g_slist_append(hogdev->reports, report);
-		discover_descriptor(hogdev->attrib, chr, next, report);
+		start = chr->value_handle + 1;
+		end = (next ? next->handle - 1 : prim->range.end);
+		discover_descriptor(hogdev->attrib, start, end, report);
 	}
 }
 
@@ -469,6 +469,7 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct gatt_primary *prim = hogdev->hog_primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid, proto_mode_uuid,
 		  ctrlpt_uuid;
 	struct report *report;
@@ -490,6 +491,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
 		bt_uuid_t uuid;
+		uint16_t start, end;
 
 		chr = l->data;
 		next = l->next ? l->next->data : NULL;
@@ -499,17 +501,20 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 
 		bt_string_to_uuid(&uuid, chr->uuid);
 
+		start = chr->value_handle + 1;
+		end = (next ? next->handle - 1 : prim->range.end);
+
 		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
 			report = g_new0(struct report, 1);
 			report->hogdev = hogdev;
 			report->decl = g_memdup(chr, sizeof(*chr));
 			hogdev->reports = g_slist_append(hogdev->reports,
 								report);
-			discover_descriptor(hogdev->attrib, chr, next, report);
+			discover_descriptor(hogdev->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
 			gatt_read_char(hogdev->attrib, chr->value_handle,
 						report_map_read_cb, hogdev);
-			discover_descriptor(hogdev->attrib, chr, next, hogdev);
+			discover_descriptor(hogdev->attrib, start, end, hogdev);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-- 
1.7.11.4

