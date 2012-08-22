Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 5/8] scan: Enable Scan Refresh notification
Date: Wed, 22 Aug 2012 16:45:20 -0300
Message-Id: <1345664723-30814-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch discovers the Scan Refresh Characteristic handle and sets
it's Client Characteristic Configuration bit to enable notifications.
---
 profiles/scanparam/scan.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 86bdcb7..59ff336 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -39,6 +39,7 @@
 #include "scan.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
+#define SCAN_REFRESH_UUID		0x2A31
 
 #define SCAN_INTERVAL		0x0060
 #define SCAN_WINDOW		0x0030
@@ -62,6 +63,80 @@ static gint scan_device_cmp(gconstpointer a, gconstpointer b)
 	return (device == scan->device ? 0 : -1);
 }
 
+static void ccc_written_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	if (status != 0) {
+		error("Write Scan Refresh CCC failed: %s",
+						att_ecode2str(status));
+		return;
+	}
+
+	DBG("Scan Refresh: notification enabled");
+}
+
+static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
+					guint16 len, gpointer user_data)
+{
+	struct scan *scan = user_data;
+	struct att_data_list *list;
+	uint8_t *ptr;
+	uint16_t uuid16, handle;
+	uint8_t value[2];
+	uint8_t format;
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (list == NULL)
+		return;
+
+	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
+		goto done;
+
+	ptr = list->data[0];
+	handle = att_get_u16(ptr);
+	uuid16 = att_get_u16(&ptr[2]);
+
+	if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
+		goto done;
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+	gatt_write_char(scan->attrib, handle, value, sizeof(value),
+						ccc_written_cb, NULL);
+done:
+	att_data_list_free(list);
+}
+
+static void refresh_discovered_cb(GSList *chars, guint8 status,
+						gpointer user_data)
+{
+	struct scan *scan = user_data;
+	struct gatt_char *chr;
+	uint16_t start, end;
+
+	if (status) {
+		error("Scan Refresh %s", att_ecode2str(status));
+		return;
+	}
+
+	if (!chars) {
+		DBG("Scan Refresh not supported");
+		return;
+	}
+
+	chr = chars->data;
+
+	DBG("Scan Refresh handle: 0x%04x", chr->value_handle);
+
+	start = chr->value_handle + 1;
+	end = scan->range.end;
+
+	if (start >= end)
+		return;
+
+	gatt_find_info(scan->attrib, start, end,
+				discover_descriptor_cb, user_data);
+}
+
 static void iwin_discovered_cb(GSList *chars, guint8 status,
 						gpointer user_data)
 {
@@ -90,14 +165,18 @@ static void iwin_discovered_cb(GSList *chars, guint8 status,
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct scan *scan = user_data;
-	bt_uuid_t iwin_uuid;
+	bt_uuid_t iwin_uuid, refresh_uuid;
 
 	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
+	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
 
 	scan->attrib = g_attrib_ref(attrib);
 
 	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
 					&iwin_uuid, iwin_discovered_cb, scan);
+
+	gatt_discover_char(scan->attrib, scan->range.start, scan->range.end,
+				&refresh_uuid, refresh_discovered_cb, scan);
 }
 
 static void attio_disconnected_cb(gpointer user_data)
-- 
1.7.12

