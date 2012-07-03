Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH 09/21] hog: Add report notification handler
Date: Tue,  3 Jul 2012 15:43:01 -0300
Message-Id: <1341340993-7480-10-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/input/hog_device.c b/input/hog_device.c
index 1883728..8e5e758 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -61,12 +61,26 @@ struct hog_device {
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
+	guint			report_cb_id;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 };
 
 static GSList *devices = NULL;
 
+static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
+{
+	uint16_t handle;
+
+	if (len < 3) { /* 1-byte opcode + 2-byte handle */
+		error("Malformed ATT notification");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+	DBG("Report notification on handle 0x%04x", handle);
+}
+
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -216,12 +230,19 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
 					NULL, char_discovered_cb, hogdev);
+
+	hogdev->report_cb_id = g_attrib_register(hogdev->attrib,
+					ATT_OP_HANDLE_NOTIFY, report_value_cb,
+					hogdev, NULL);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 
+	g_attrib_unregister(hogdev->attrib, hogdev->report_cb_id);
+	hogdev->report_cb_id = 0;
+
 	g_attrib_unref(hogdev->attrib);
 	hogdev->attrib = NULL;
 }
-- 
1.7.10.4

