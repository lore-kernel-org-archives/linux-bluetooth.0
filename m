Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 13/28] android/hog: Replace definitions of characteristic uuids with bt_uuids
Date: Wed,  1 Apr 2015 18:40:29 +0200
Message-Id: <1427906444-11769-14-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of using simply define and then convert the uuid values to
bt_uuid everytime the char_discovered_cb is called, it's better to
define these bt_uuids directly.
---
 android/hog.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 08196d4..e1ccaf3 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -61,12 +61,6 @@
 #include "android/bas.h"
 #include "android/hog.h"
 
-#define HOG_INFO_UUID		0x2A4A
-#define HOG_REPORT_MAP_UUID	0x2A4B
-#define HOG_REPORT_UUID		0x2A4D
-#define HOG_PROTO_MODE_UUID	0x2A4E
-#define HOG_CONTROL_POINT_UUID	0x2A4C
-
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
 #define HOG_REPORT_TYPE_FEATURE	3
@@ -77,6 +71,17 @@
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
 
+static const bt_uuid_t info_uuid = { .type = BT_UUID16,
+					.value.u16 = 0x2A4A };
+static const bt_uuid_t report_map_uuid = { .type = BT_UUID16,
+					.value.u16 = 0x2A4B };
+static const bt_uuid_t control_point_uuid = { .type = BT_UUID16,
+					.value.u16 = 0x2A4C };
+static const bt_uuid_t report_uuid = { .type = BT_UUID16,
+					.value.u16 = 0x2A4D };
+static const bt_uuid_t protocol_mode_uuid = { .type = BT_UUID16,
+					.value.u16 = 0x2A4E };
+
 struct bt_hog {
 	int			ref_count;
 	uint16_t		service_handle;
@@ -300,7 +305,6 @@ static void external_report_reference_cb(bool success, uint8_t status,
 					void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	uint16_t uuid16;
 	bt_uuid_t uuid;
 	struct queue *chrs;
 
@@ -315,12 +319,12 @@ static void external_report_reference_cb(bool success, uint8_t status,
 		return;
 	}
 
-	uuid16 = get_le16(value);
-	DBG("External report reference read, external report characteristic "
-						"UUID: 0x%04x", uuid16);
+	DBG("External report characteristic UUID: 0x%04x", get_le16(value));
+
+	bt_uuid16_create(&uuid, get_le16(value));
 
 	/* Do not discover if is not a Report */
-	if (uuid16 != HOG_REPORT_UUID)
+	if (bt_uuid_cmp(&uuid, &report_uuid))
 		return;
 
 	chrs = queue_new();
@@ -329,7 +333,6 @@ static void external_report_reference_cb(bool success, uint8_t status,
 		return;
 	}
 
-	bt_uuid16_create(&uuid, uuid16);
 	gatt_db_read_by_type(hog->db, 0x0001, 0xffff, uuid, chrs);
 
 	if (queue_isempty(chrs))
@@ -823,18 +826,11 @@ static void char_discovered_cb(struct gatt_db_attribute *attrib,
 								void *user_data)
 {
 	struct bt_hog *hog = user_data;
-	bt_uuid_t report_uuid, report_map_uuid, proto_mode_uuid, ctrlpt_uuid;
-	bt_uuid_t info_uuid, uuid;
+	bt_uuid_t uuid;
 	struct report *report;
 	uint16_t value_handle;
 	uint8_t properties;
 
-	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
-	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
-	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
-	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
-	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
-
 	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle,
 							&properties, &uuid);
 
@@ -849,11 +845,11 @@ static void char_discovered_cb(struct gatt_db_attribute *attrib,
 	} else if (!bt_uuid_cmp(&uuid, &info_uuid)) {
 		bt_gatt_client_read_value(hog->client, value_handle,
 						info_read_cb, hog, NULL);
-	} else if (!bt_uuid_cmp(&uuid, &proto_mode_uuid)) {
+	} else if (!bt_uuid_cmp(&uuid, &protocol_mode_uuid)) {
 		hog->proto_mode_handle = value_handle;
 		bt_gatt_client_read_value(hog->client, value_handle,
 						proto_mode_read_cb, hog, NULL);
-	} else if (!bt_uuid_cmp(&uuid, &ctrlpt_uuid)) {
+	} else if (!bt_uuid_cmp(&uuid, &control_point_uuid)) {
 		hog->ctrlpt_handle = value_handle;
 	}
 }
-- 
1.9.1

