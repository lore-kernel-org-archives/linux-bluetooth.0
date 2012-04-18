Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC v2 08/16] HoG: add report notification handler
Date: Wed, 18 Apr 2012 19:08:16 -0300
Message-Id: <1334786904-26282-9-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index ac6d4c9..5df6879 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -71,9 +71,27 @@ static void report_free(struct report *report)
 	g_free(report);
 }
 
+static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	uint16_t handle;
+
+	if (len < 3) {
+		error("Malformed ATT notification");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+
+	DBG("Report(0x%04x): 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
+				"0x%02x", handle, pdu[2], pdu[3], pdu[4],
+				pdu[5], pdu[6], pdu[7], pdu[8], pdu[9]);
+}
+
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
+
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
@@ -81,6 +99,9 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	}
 
 	DBG("Report characteristic descriptor written: notification enabled");
+
+	g_attrib_register(hogdev->attrib, ATT_OP_HANDLE_NOTIFY, report_value_cb,
+								hogdev, NULL);
 }
 
 static void write_ccc(uint16_t handle, gpointer user_data)
-- 
1.7.7.6

