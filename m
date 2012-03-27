Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 6/8] HoG: add report notification handler
Date: Tue, 27 Mar 2012 19:31:25 -0300
Message-Id: <1332887487-13601-7-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index b06f898..3a767cd 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -60,9 +60,27 @@ struct hog_device {
 
 static GSList *devices = NULL;
 
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
@@ -70,6 +88,9 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	}
 
 	DBG("Report characteristic descriptor written: notification enabled");
+
+	g_attrib_register(hogdev->attrib, ATT_OP_HANDLE_NOTIFY, report_value_cb,
+								hogdev, NULL);
 }
 
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
-- 
1.7.7.6

