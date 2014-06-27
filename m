Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 10/15] android/scpp: Check for cached handles on attach
Date: Fri, 27 Jun 2014 11:27:54 +0300
Message-Id: <1403857679-14341-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403857679-14341-1-git-send-email-luiz.dentz@gmail.com>
References: <1403857679-14341-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/scpp.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index 751d3f2..81d698b 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -148,12 +148,22 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 				refresh_value_cb, scan, NULL);
 }
 
+static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
+{
+	uint8_t value[2];
+
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+
+	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
+								user_data);
+}
+
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
 	struct bt_scpp *scan = user_data;
 	struct gatt_desc *desc;
-	uint8_t value[2];
+
 
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
@@ -163,9 +173,7 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 	/* There will be only one descriptor on list and it will be CCC */
 	desc = descs->data;
 
-	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-	gatt_write_char(scan->attrib, desc->handle, value, sizeof(value),
-						ccc_written_cb, user_data);
+	write_ccc(scan->attrib, desc->handle, scan);
 }
 
 static void refresh_discovered_cb(uint8_t status, GSList *chars,
@@ -233,22 +241,26 @@ bool bt_scpp_attach(struct bt_scpp *scan, void *attrib)
 
 	scan->attrib = g_attrib_ref(attrib);
 
-	if (scan->iwhandle) {
+	if (scan->iwhandle)
 		write_scan_params(scan->attrib, scan->iwhandle, scan->interval,
 								scan->window);
-		return true;
+	else {
+		bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
+		gatt_discover_char(scan->attrib, scan->primary->range.start,
+					scan->primary->range.end, &iwin_uuid,
+					iwin_discovered_cb, scan);
 	}
 
-	bt_uuid16_create(&iwin_uuid, SCAN_INTERVAL_WIN_UUID);
-	bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
-
-	gatt_discover_char(scan->attrib, scan->primary->range.start,
-				scan->primary->range.end, &iwin_uuid,
-				iwin_discovered_cb, scan);
-
-	gatt_discover_char(scan->attrib, scan->primary->range.start,
-				scan->primary->range.end, &refresh_uuid,
-				refresh_discovered_cb, scan);
+	if (scan->refresh_handle)
+		scan->refresh_cb_id = g_attrib_register(scan->attrib,
+				ATT_OP_HANDLE_NOTIFY, scan->refresh_handle,
+				refresh_value_cb, scan, NULL);
+	else {
+		bt_uuid16_create(&refresh_uuid, SCAN_REFRESH_UUID);
+		gatt_discover_char(scan->attrib, scan->primary->range.start,
+					scan->primary->range.end, &refresh_uuid,
+					refresh_discovered_cb, scan);
+	}
 
 	return true;
 }
-- 
1.9.3

