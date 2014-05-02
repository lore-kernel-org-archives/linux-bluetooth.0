Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 06/11] heartrate: Discover CCC using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:37 +0200
Message-Id: <1399028262-17187-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/heartrate/heartrate.c | 59 ++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 1dcbdf4..287ea72 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -391,13 +391,12 @@ static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	process_measurement(hr, pdu + 3, len - 3);
 }
 
-static void discover_ccc_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void discover_ccc_cb(uint8_t status, GSList *descs, void *user_data)
 {
 	struct heartrate *hr = user_data;
-	struct att_data_list *list;
-	uint8_t format;
-	int i;
+	struct gatt_desc *desc;
+	uint8_t attr_val[2];
+	char *msg;
 
 	if (status != 0) {
 		error("Discover Heart Rate Measurement descriptors failed: %s",
@@ -405,50 +404,28 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
-
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value;
-		uint16_t handle, uuid;
-		char *msg;
-		uint8_t attr_val[2];
-
-		value = list->data[i];
-		handle = get_le16(value);
-		uuid = get_le16(value + 2);
-
-		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
-			continue;
+	/* There will be only one descriptor on list and it will be CCC */
+	desc = descs->data;
 
-		hr->measurement_ccc_handle = handle;
+	hr->measurement_ccc_handle = desc->handle;
 
-		if (g_slist_length(hr->hradapter->watchers) == 0) {
-			put_le16(0x0000, attr_val);
-			msg = g_strdup("Disable measurement");
-		} else {
-			put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, attr_val);
-			msg = g_strdup("Enable measurement");
-		}
-
-		gatt_write_char(hr->attrib, handle, attr_val,
-					sizeof(attr_val), char_write_cb, msg);
-
-		break;
+	if (g_slist_length(hr->hradapter->watchers) == 0) {
+		put_le16(0x0000, attr_val);
+		msg = g_strdup("Disable measurement");
+	} else {
+		put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, attr_val);
+		msg = g_strdup("Enable measurement");
 	}
 
-done:
-	att_data_list_free(list);
+	gatt_write_char(hr->attrib, desc->handle, attr_val, sizeof(attr_val),
+							char_write_cb, msg);
 }
 
 static void discover_measurement_ccc(struct heartrate *hr,
 				struct gatt_char *c, struct gatt_char *c_next)
 {
 	uint16_t start, end;
+	bt_uuid_t uuid;
 
 	start = c->value_handle + 1;
 
@@ -462,7 +439,9 @@ static void discover_measurement_ccc(struct heartrate *hr,
 		return;
 	}
 
-	gatt_discover_char_desc(hr->attrib, start, end, discover_ccc_cb, hr);
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	gatt_discover_desc(hr->attrib, start, end, &uuid, discover_ccc_cb, hr);
 }
 
 static void discover_char_cb(uint8_t status, GSList *chars, void *user_data)
-- 
1.9.2

