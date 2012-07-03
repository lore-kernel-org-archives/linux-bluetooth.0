Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 20/21] hog: Use hardware country code
Date: Tue,  3 Jul 2012 15:43:12 -0300
Message-Id: <1341340993-7480-21-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

bCountryCode is a 8-bits integer identifying hardware target country.

The order of the characteristic declarations may be different on each
implementation. Since GATT/ATT requests need to be serialized, HID
information will be returned before report map characteristic value.
---
 input/hog_device.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 778a367..7e6c4b1 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -292,7 +292,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	ev.u.create.vendor = vendor;
 	ev.u.create.product = product;
 	ev.u.create.version = version;
-	ev.u.create.country = 0; /* get this info from the right place */
+	ev.u.create.country = hogdev->bcountrycode;
 	ev.u.create.bus = BUS_BLUETOOTH;
 	ev.u.create.rd_data = value;
 	ev.u.create.rd_size = vlen;
@@ -334,6 +334,7 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	struct report *report;
 	GSList *l;
+	uint16_t map_handle = 0, info_handle = 0;
 
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
@@ -365,12 +366,18 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 								report);
 			discover_descriptor(hogdev->attrib, chr, next, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0)
-			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
-						report_map_read_cb, hogdev);
+			map_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
-			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
-						info_read_cb, hogdev);
+			info_handle = chr->value_handle;
 	}
+
+	if (info_handle)
+		gatt_read_char(hogdev->attrib, info_handle, 0,
+							info_read_cb, hogdev);
+
+	if (map_handle)
+		gatt_read_char(hogdev->attrib, map_handle, 0,
+						report_map_read_cb, hogdev);
 }
 
 static void output_written_cb(guint8 status, const guint8 *pdu,
-- 
1.7.10.4

