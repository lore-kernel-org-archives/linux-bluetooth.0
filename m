Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/13] hog: Add read Report Reference descriptor
Date: Tue, 10 Jul 2012 16:16:55 -0300
Message-Id: <1341947825-14789-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds the GATT operation to read the value of the Report
Reference descriptor of the Report characteristic.
---
 profiles/input/hog_device.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 547bd6c..823d7a4 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -118,9 +118,27 @@ static void write_ccc(uint16_t handle, gpointer user_data)
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
@@ -146,10 +164,11 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
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
1.7.10.4

