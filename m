Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 5/8] HoG: discover report characteristic
Date: Tue, 27 Mar 2012 19:31:24 -0300
Message-Id: <1332887487-13601-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/hog_device.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 5ec2d09..b06f898 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -47,12 +47,15 @@
 #include "attio.h"
 #include "gatt.h"
 
+#define HOG_REPORT_UUID		0x2A4D
+
 struct hog_device {
 	char			*path;
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
 	struct gatt_primary	*hog_primary;
+	struct gatt_char	*report;
 };
 
 static GSList *devices = NULL;
@@ -69,15 +72,48 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Report characteristic descriptor written: notification enabled");
 }
 
+static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+	bt_uuid_t report_uuid;
+	GSList *l;
+
+	if (status != 0) {
+		const char *str = att_ecode2str(status);
+		DBG("Discover all characteristics failed: %s", str);
+		return;
+	}
+
+	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
+
+	for (l = chars; l; l = g_slist_next(l)) {
+		struct gatt_char *chr = l->data;
+		bt_uuid_t uuid;
+
+		bt_string_to_uuid(&uuid, chr->uuid);
+
+		if (bt_uuid_cmp(&uuid, &report_uuid) != 0)
+			continue;
+
+		hogdev->report = chr;
+		DBG("Report 0x%04x UUID: %s properties: %02x",
+				chr->handle, chr->uuid, chr->properties);
+	}
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct gatt_primary *prim = hogdev->hog_primary;
 	uint8_t value[] = { 0x01, 0x00 };
 
 	hogdev->attrib = g_attrib_ref(attrib);
 
 	gatt_write_char(hogdev->attrib, 0x000c, value, 2,
 						report_ccc_written_cb, hogdev);
+
+	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
+					NULL, char_discovered_cb, hogdev);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.7.6

