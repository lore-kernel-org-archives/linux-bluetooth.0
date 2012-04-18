Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [RFC v2 07/16] HoG: enable "Report" characteristic notification
Date: Wed, 18 Apr 2012 19:08:15 -0300
Message-Id: <1334786904-26282-8-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@gmail.com>

---
 input/hog_device.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 2eec825..ac6d4c9 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -71,10 +71,30 @@ static void report_free(struct report *report)
 	g_free(report);
 }
 
+static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	if (status != 0) {
+		error("Write report characteristic descriptor failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	DBG("Report characteristic descriptor written: notification enabled");
+}
+
+static void write_ccc(uint16_t handle, gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	uint8_t value[] = { 0x01, 0x00 };
+
+	gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
+					report_ccc_written_cb, hogdev);
+}
+
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
-	struct report *report = user_data;
 	struct att_data_list *list;
 	uint8_t format;
 	int i;
@@ -93,13 +113,17 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		goto done;
 
 	for (i = 0; i < list->num; i++) {
-		uint16_t uuid16;
+		uint16_t uuid16, handle;
 		uint8_t *value;
 
 		value = list->data[i];
+		handle = att_get_u16(value);
 		uuid16 = att_get_u16(&value[2]);
 
-		DBG("%s descriptor: 0x%04x", report->decl->uuid, uuid16);
+		if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
+			continue;
+
+		write_ccc(handle, user_data);
 	}
 
 done:
-- 
1.7.7.6

