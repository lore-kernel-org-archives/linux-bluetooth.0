Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH 21/21] hog: Handle HID devices operating in Boot Protocol Mode
Date: Tue,  3 Jul 2012 15:43:13 -0300
Message-Id: <1341340993-7480-22-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

BlueZ does not support HID devices operating in Boot Protocol Mode, so we
need to set it back to Report Protocol Mode through the Protocol Mode
characteristic.

This patch takes cares of changing from Boot Protocol Mode to Report
Protocol Mode by writing the Protocol Mode characteristic value to 1,
which is value for Report Protocol Mode on HID devices operating in
Boot Protocol Mode.
---
 input/hog_device.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 7e6c4b1..18854b8 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -54,11 +54,15 @@
 #define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
+#define HOG_PROTO_MODE_UUID	0x2A4E
 
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
 #define HOG_REPORT_TYPE_FEATURE	3
 
+#define HOG_PROTO_MODE_BOOT    0
+#define HOG_PROTO_MODE_REPORT  1
+
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
@@ -77,6 +81,7 @@ struct hog_device {
 	guint			uhid_watch_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
+	uint16_t		proto_mode_handle;
 	uint8_t			flags;
 };
 
@@ -328,13 +333,45 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			hogdev->bcdhid, hogdev->bcountrycode, hogdev->flags);
 }
 
+static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	uint8_t value;
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("Protocol Mode characteristic read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, plen, &value, sizeof(value));
+	if (vlen < 0) {
+		error("ATT protocol error");
+		return;
+	}
+
+	if (value == HOG_PROTO_MODE_BOOT) {
+		uint8_t nval = HOG_PROTO_MODE_REPORT;
+
+		DBG("HoG device %s is operating in Boot Procotol Mode",
+								hogdev->path);
+
+		gatt_write_char(hogdev->attrib, hogdev->proto_mode_handle, &nval,
+						sizeof(nval), NULL, NULL);
+	} else if (value == HOG_PROTO_MODE_REPORT)
+		DBG("HoG device %s is operating in Report Protocol Mode",
+								hogdev->path);
+}
+
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
-	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
+	bt_uuid_t report_uuid, report_map_uuid, info_uuid, proto_mode_uuid;
 	struct report *report;
 	GSList *l;
-	uint16_t map_handle = 0, info_handle = 0;
+	uint16_t map_handle = 0, info_handle = 0, proto_mode_handle = 0;
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
@@ -345,6 +382,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
 	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
+	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
@@ -369,6 +407,14 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 			map_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
+		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
+			proto_mode_handle = chr->value_handle;
+	}
+
+	if (proto_mode_handle) {
+		hogdev->proto_mode_handle = proto_mode_handle;
+		gatt_read_char(hogdev->attrib, proto_mode_handle, 0,
+						proto_mode_read_cb, hogdev);
 	}
 
 	if (info_handle)
-- 
1.7.10.4

