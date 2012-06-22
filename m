Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 12/19] hog: Add read Report Reference descriptor
Date: Fri, 22 Jun 2012 12:08:00 -0300
Message-Id: <1340377687-4711-13-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds the GATT operation to read the value of the Report
Reference descriptor of the Report characteristic.
---
 attrib/gatt.h      |    1 +
 input/hog_device.c |   27 +++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt.h b/attrib/gatt.h
index 9ffe58f..c7e79ab 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -46,6 +46,7 @@
 #define GATT_CHARAC_FMT_UUID		0x2904
 #define GATT_CHARAC_AGREG_FMT_UUID	0x2905
 #define GATT_CHARAC_VALID_RANGE_UUID	0x2906
+#define GATT_REPORT_REFERENCE           0x2908
 
 /* Client Characteristic Configuration bit field */
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
diff --git a/input/hog_device.c b/input/hog_device.c
index 13c0c65..1c12b40 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -122,9 +122,27 @@ static void write_ccc(uint16_t handle, gpointer user_data)
 					report_ccc_written_cb, hogdev);
 }
 
+static void report_reference_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	if (status != 0) {
+		error("Read Report Reference descriptor failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (plen != 3) {
+		error("Malformed ATT read response");
+		return;
+	}
+
+	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
+}
+
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
 	struct att_data_list *list;
 	uint8_t format;
 	int i;
@@ -150,10 +168,11 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		handle = att_get_u16(value);
 		uuid16 = att_get_u16(&value[2]);
 
-		if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
-			continue;
-
-		write_ccc(handle, user_data);
+		if (uuid16 == GATT_CLIENT_CHARAC_CFG_UUID)
+			write_ccc(handle, user_data);
+		else if (uuid16 == GATT_REPORT_REFERENCE)
+			gatt_read_char(hogdev->attrib, handle, 0,
+					report_reference_cb, hogdev);
 	}
 
 done:
-- 
1.7.10.2

