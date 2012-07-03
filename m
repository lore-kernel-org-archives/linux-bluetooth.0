Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 19/21] hog: Add HID Information Characteristic read
Date: Tue,  3 Jul 2012 15:43:11 -0300
Message-Id: <1341340993-7480-20-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds the characteristic value read for HID Information
Characteristic. It's information contains HID Device's HID Attributes.
---
 input/hog_device.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 00127c3..778a367 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -51,6 +51,7 @@
 #include "attio.h"
 #include "gatt.h"
 
+#define HOG_INFO_UUID		0x2A4A
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
 
@@ -61,6 +62,7 @@
 #define UHID_DEVICE_FILE	"/dev/uhid"
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
+#define HID_INFO_SIZE			4
 
 struct hog_device {
 	char			*path;
@@ -73,6 +75,9 @@ struct hog_device {
 	int			uhid_fd;
 	gboolean		prepend_id;
 	guint			uhid_watch_id;
+	uint16_t		bcdhid;
+	uint8_t			bcountrycode;
+	uint8_t			flags;
 };
 
 struct report {
@@ -296,10 +301,37 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		error("Failed to create uHID device: %s", strerror(errno));
 }
 
+static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	uint8_t value[HID_INFO_SIZE];
+	ssize_t vlen;
+
+	if (status != 0) {
+		error("HID Information read failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
+	if (vlen != 4) {
+		error("ATT protocol error");
+		return;
+	}
+
+	hogdev->bcdhid = att_get_u16(&value[0]);
+	hogdev->bcountrycode = value[2];
+	hogdev->flags = value[3];
+
+	DBG("bcdHID: 0x%04X bCountryCode: 0x%02X Flags: 0x%02X",
+			hogdev->bcdhid, hogdev->bcountrycode, hogdev->flags);
+}
+
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
-	bt_uuid_t report_uuid, report_map_uuid;
+	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	struct report *report;
 	GSList *l;
 
@@ -311,6 +343,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
 	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
+	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
 		struct gatt_char *chr, *next;
@@ -334,6 +367,9 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0)
 			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
 						report_map_read_cb, hogdev);
+		else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
+			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
+						info_read_cb, hogdev);
 	}
 }
 
-- 
1.7.10.4

