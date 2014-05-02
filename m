Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 09/11] android/gatt: Discover descriptors using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:40 +0200
Message-Id: <1399028262-17187-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 101 +++++++++++++--------------------------------------------
 1 file changed, 22 insertions(+), 79 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 47a7ecf..e768856 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2008,67 +2008,13 @@ static void send_client_descr_notify(int32_t status, int32_t conn_id,
 			HAL_EV_GATT_CLIENT_GET_DESCRIPTOR, sizeof(ev), &ev);
 }
 
-static uint16_t parse_descrs(const uint8_t *pdu, guint16 len,
-							struct queue *cache)
-{
-	struct att_data_list *list;
-	guint8 format;
-	uint16_t handle = 0xffff;
-	int i;
-
-	list = dec_find_info_resp(pdu, len, &format);
-	if (!list)
-		return handle;
-
-	for (i = 0; i < list->num; i++) {
-		char uuidstr[MAX_LEN_UUID_STR];
-		struct descriptor *descr;
-		bt_uuid_t uuid128;
-		uint8_t *value;
-		bt_uuid_t uuid;
-
-		value = list->data[i];
-		handle = get_le16(value);
-
-		if (format == ATT_FIND_INFO_RESP_FMT_16BIT) {
-			bt_uuid16_create(&uuid, get_le16(&value[2]));
-			bt_uuid_to_uuid128(&uuid, &uuid128);
-		} else {
-			uint128_t u128;
-
-			bswap_128(&value[2], &u128);
-			bt_uuid128_create(&uuid128, u128);
-		}
-
-		bt_uuid_to_string(&uuid128, uuidstr, MAX_LEN_UUID_STR);
-		DBG("handle 0x%04x uuid %s", handle, uuidstr);
-
-		descr = new0(struct descriptor, 1);
-		if (!descr)
-			continue;
-
-		descr->id.instance = i;
-		descr->handle = handle;
-		descr->id.uuid = uuid128;
-
-		if (!queue_push_tail(cache, descr))
-			free(descr);
-	}
-
-	att_data_list_free(list);
-
-	return handle;
-}
-
 struct discover_desc_data {
 	struct app_connection *conn;
 	struct service *srvc;
 	struct characteristic *ch;
-
-	struct queue *result;
 };
 
-static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void gatt_discover_desc_cb(guint8 status, GSList *descs,
 							gpointer user_data)
 {
 	struct discover_desc_data *data = user_data;
@@ -2076,29 +2022,33 @@ static void gatt_discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	struct service *srvc = data->srvc;
 	struct characteristic *ch = data->ch;
 	struct descriptor *descr;
+	int i = 0;
 
-	if (!status) {
-		uint16_t last_handle = parse_descrs(pdu, len, data->result);
+	if (status != 0) {
+		error("Discover all characteristic descriptors failed [%s]: %s",
+					ch->ch.uuid, att_ecode2str(status));
+		goto reply;
+	}
 
-		if (last_handle >= ch->end_handle)
-			goto reply;
+	for ( ; descs; descs = descs->next) {
+		struct gatt_desc *desc = descs->data;
+		bt_uuid_t uuid;
 
-		if (!gatt_discover_char_desc(conn->device->attrib,
-						last_handle + 1, ch->end_handle,
-						gatt_discover_desc_cb, data))
-			goto reply;
+		descr = new0(struct descriptor, 1);
+		if (!descr)
+			continue;
 
-		/* Do not reply yet, wait for next piece */
-		return;
-	} else if (status != ATT_ECODE_ATTR_NOT_FOUND) {
-		error("gatt: Discover all char descriptors failed: %s",
-							att_ecode2str(status));
+		bt_string_to_uuid(&uuid, desc->uuid);
+		bt_uuid_to_uuid128(&uuid, &descr->id.uuid);
+
+		descr->id.instance = i++;
+		descr->handle = desc->handle;
+
+		if (!queue_push_tail(ch->descriptors, descr))
+			free(descr);
 	}
 
 reply:
-	queue_destroy(ch->descriptors, free);
-	ch->descriptors = data->result;
-
 	descr = queue_peek_head(ch->descriptors);
 
 	send_client_descr_notify(status, conn->id, srvc->primary, &srvc->id,
@@ -2130,16 +2080,9 @@ static bool build_descr_cache(struct app_connection *connection,
 	cb_data->conn = connection;
 	cb_data->srvc = srvc;
 	cb_data->ch = ch;
-	cb_data->result = queue_new();
-
-	if (!cb_data->result) {
-		free(cb_data);
-		return false;
-	}
 
-	if (!gatt_discover_char_desc(connection->device->attrib, start, end,
+	if (!gatt_discover_desc(connection->device->attrib, start, end, NULL,
 					gatt_discover_desc_cb, cb_data)) {
-		queue_destroy(cb_data->result, NULL);
 		free(cb_data);
 		return false;
 	}
-- 
1.9.2

