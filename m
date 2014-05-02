Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 05/11] scan: Discover CCC using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:36 +0200
Message-Id: <1399028262-17187-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/scanparam/scan.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 156682f..25c906e 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -102,35 +102,24 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 				refresh_value_cb, scan, NULL);
 }
 
-static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static void discover_descriptor_cb(uint8_t status, GSList *descs,
+								void *user_data)
 {
 	struct scan *scan = user_data;
-	struct att_data_list *list;
-	uint8_t *ptr;
-	uint16_t uuid16, handle;
+	struct gatt_desc *desc;
 	uint8_t value[2];
-	uint8_t format;
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
+	if (status != 0) {
+		error("Discover descriptors failed: %s", att_ecode2str(status));
 		return;
+	}
 
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	ptr = list->data[0];
-	handle = get_le16(ptr);
-	uuid16 = get_le16(&ptr[2]);
-
-	if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
-		goto done;
+	/* There will be only one descriptor on list and it will be CCC */
+	desc = descs->data;
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-	gatt_write_char(scan->attrib, handle, value, sizeof(value),
+	gatt_write_char(scan->attrib, desc->handle, value, sizeof(value),
 						ccc_written_cb, user_data);
-done:
-	att_data_list_free(list);
 }
 
 static void refresh_discovered_cb(uint8_t status, GSList *chars,
@@ -139,6 +128,7 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 	struct scan *scan = user_data;
 	struct gatt_char *chr;
 	uint16_t start, end;
+	bt_uuid_t uuid;
 
 	if (status) {
 		error("Scan Refresh %s", att_ecode2str(status));
@@ -162,7 +152,9 @@ static void refresh_discovered_cb(uint8_t status, GSList *chars,
 
 	scan->refresh_handle = chr->value_handle;
 
-	gatt_discover_char_desc(scan->attrib, start, end,
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	gatt_discover_desc(scan->attrib, start, end, &uuid,
 					discover_descriptor_cb, user_data);
 }
 
-- 
1.9.2

