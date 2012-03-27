Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 7/8] HoG: print the report map on debug output
Date: Tue, 27 Mar 2012 19:31:26 -0300
Message-Id: <1332887487-13601-8-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 3a767cd..7a757f4 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -93,6 +93,31 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 								hogdev, NULL);
 }
 
+static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	uint8_t value[ATT_MAX_MTU];
+	int vlen, i;
+
+	if (status != 0) {
+		error("Report Map read failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, plen, value, &vlen)) {
+		error("ATT protocol error");
+		return;
+	}
+
+	DBG("Report MAP:");
+	for (i = 0; i < vlen; i += 2) {
+		if (i + 1 == vlen)
+			DBG("\t %02x", value[i]);
+		else
+			DBG("\t %02x %02x", value[i], value[i + 1]);
+	}
+}
+
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -133,6 +158,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	gatt_write_char(hogdev->attrib, 0x000c, value, 2,
 						report_ccc_written_cb, hogdev);
 
+	gatt_read_char(hogdev->attrib, 0x0015, 0, report_map_read_cb, hogdev);
+
 	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
 					NULL, char_discovered_cb, hogdev);
 }
-- 
1.7.7.6

