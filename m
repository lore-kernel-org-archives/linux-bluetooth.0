Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 2/3] hog: discover External Report Reference descriptor
Date: Mon, 13 Aug 2012 09:23:15 -0300
Message-Id: <1344860596-30617-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
References: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Non-HID service data may be encapsulated on the HID protocol and
transfered as a HID Report. This descriptor is used to map a report
on the USB-HID descriptor that transports non-HID data to the
characteristic on a external service that will actually transport the
data on GATT devices.
---
 profiles/input/hog_device.c | 54 +++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index ffd7139..f4cf596 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -170,6 +170,23 @@ static void write_ccc(uint16_t handle, gpointer user_data)
 					report_ccc_written_cb, hogdev);
 }
 
+static void external_report_reference_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	if (status != 0) {
+		error("Read External Report Reference descriptor failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (plen != 3) {
+		error("Malformed ATT read response");
+		return;
+	}
+
+	DBG("External Report Reference read: 0x%02x 0x%02x", pdu[1], pdu[2]);
+}
+
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -194,8 +211,8 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
-	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
+	struct report *report;
+	struct hog_device *hogdev;
 	struct att_data_list *list;
 	uint8_t format;
 	int i;
@@ -221,11 +238,22 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		handle = att_get_u16(value);
 		uuid16 = att_get_u16(&value[2]);
 
-		if (uuid16 == GATT_CLIENT_CHARAC_CFG_UUID)
-			write_ccc(handle, hogdev);
-		else if (uuid16 == GATT_REPORT_REFERENCE)
+		switch (uuid16) {
+		case GATT_CLIENT_CHARAC_CFG_UUID:
+			report = user_data;
+			write_ccc(handle, report->hogdev);
+			break;
+		case GATT_REPORT_REFERENCE:
+			report = user_data;
+			gatt_read_char(report->hogdev->attrib, handle, 0,
+						report_reference_cb, report);
+			break;
+		case GATT_EXTERNAL_REPORT_REFERENCE:
+			hogdev = user_data;
 			gatt_read_char(hogdev->attrib, handle, 0,
-					report_reference_cb, report);
+					external_report_reference_cb, hogdev);
+			break;
+		}
 	}
 
 done:
@@ -372,7 +400,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid, proto_mode_uuid;
 	struct report *report;
 	GSList *l;
-	uint16_t map_handle = 0, info_handle = 0, proto_mode_handle = 0;
+	uint16_t info_handle = 0, proto_mode_handle = 0;
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
@@ -404,9 +432,11 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 			hogdev->reports = g_slist_append(hogdev->reports,
 								report);
 			discover_descriptor(hogdev->attrib, chr, next, report);
-		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0)
-			map_handle = chr->value_handle;
-		else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
+		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
+			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
+						report_map_read_cb, hogdev);
+			discover_descriptor(hogdev->attrib, chr, next, NULL);
+		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
 			proto_mode_handle = chr->value_handle;
@@ -421,10 +451,6 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	if (info_handle)
 		gatt_read_char(hogdev->attrib, info_handle, 0,
 							info_read_cb, hogdev);
-
-	if (map_handle)
-		gatt_read_char(hogdev->attrib, map_handle, 0,
-						report_map_read_cb, hogdev);
 }
 
 static void output_written_cb(guint8 status, const guint8 *pdu,
-- 
1.7.11.2

