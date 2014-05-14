Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 12/15] android/gatt: Change handling of read_by_group_type requests
Date: Wed, 14 May 2014 12:18:16 +0200
Message-Id: <1400062699-2372-13-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use modified version of gatt_db_read_by_group_type which return list
of handles instead of specific data.
---
 android/gatt.c | 182 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 111 insertions(+), 71 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 66e75b7..e083cf1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3944,76 +3944,6 @@ static const struct ipc_handler cmd_handlers[] = {
 		sizeof(struct hal_cmd_gatt_server_send_response) },
 };
 
-struct copy_att_list_data {
-	int iterator;
-	struct att_data_list *adl;
-};
-
-static void copy_to_att_list(void *data, void *user_data)
-{
-	struct copy_att_list_data *l = user_data;
-	struct gatt_db_group *group = data;
-	uint8_t *value;
-
-	value = l->adl->data[l->iterator++];
-
-	put_le16(group->handle, value);
-	put_le16(group->end_group, &value[2]);
-
-	memcpy(&value[4], group->value, group->len);
-}
-
-static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
-						uint8_t *rsp, size_t rsp_size,
-						uint16_t *length)
-{
-	uint16_t start, end;
-	uint16_t len;
-	bt_uuid_t uuid;
-	struct queue *q;
-	struct att_data_list *adl;
-	struct copy_att_list_data l;
-	struct gatt_db_group *d;
-
-	len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
-	if (!len)
-		return ATT_ECODE_INVALID_PDU;
-
-	q = queue_new();
-	if (!q)
-		return ATT_ECODE_INSUFF_RESOURCES;
-
-	gatt_db_read_by_group_type(gatt_db, start, end, uuid, q);
-
-	if (queue_isempty(q)) {
-		queue_destroy(q, NULL);
-		return ATT_ECODE_ATTR_NOT_FOUND;
-	}
-
-	len = queue_length(q);
-	d = queue_peek_head(q);
-
-	/* Element contains start/end handle + size of uuid */
-	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t) + d->len);
-	if (!adl) {
-		queue_destroy(q, free);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
-
-	l.iterator = 0;
-	l.adl = adl;
-
-	queue_foreach(q, copy_to_att_list, &l);
-
-	len = enc_read_by_grp_resp(adl, rsp, rsp_size);
-	*length = len;
-
-	att_data_list_free(adl);
-	queue_destroy(q, free);
-
-	return 0;
-}
-
 static void send_pending_response(uint8_t opcode, struct gatt_device *device)
 {
 	uint8_t rsp[ATT_DEFAULT_LE_MTU];
@@ -4084,6 +4014,49 @@ static void send_pending_response(uint8_t opcode, struct gatt_device *device)
 		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
 		destroy_response_data(val);
 		break;
+	case ATT_OP_READ_BY_GROUP_REQ: {
+		int iterator = 0;
+		int length;
+		struct queue *temp;
+
+		temp = queue_new();
+		if (!temp)
+			goto done;
+
+		val = queue_pop_head(device->pending_requests);
+		length = val->length;
+
+		while (val && val->length == length) {
+			queue_push_tail(temp, val);
+			val = queue_pop_head(device->pending_requests);
+		}
+
+		adl = att_data_list_alloc(queue_length(temp),
+						2 * sizeof(uint16_t) + length);
+
+		val = queue_pop_head(temp);
+		while (val) {
+			uint8_t *value = adl->data[iterator++];
+			uint16_t end_handle;
+
+			end_handle = gatt_db_get_end_handle(gatt_db,
+								val->handle);
+
+			put_le16(val->handle, value);
+			put_le16(end_handle, &value[2]);
+			memcpy(&value[4], val->value, val->length);
+
+			destroy_response_data(val);
+			val = queue_pop_head(temp);
+		}
+
+		len = enc_read_by_grp_resp(adl, rsp, sizeof(rsp));
+
+		att_data_list_free(adl);
+		queue_destroy(temp, destroy_response_data);
+
+		break;
+	}
 	default:
 		break;
 	}
@@ -4099,6 +4072,73 @@ done:
 							destroy_response_data);
 }
 
+static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
+						uint8_t *rsp, size_t rsp_size,
+						uint16_t *length,
+						struct gatt_device *device)
+{
+	uint16_t start, end;
+	int len;
+	bt_uuid_t uuid;
+	struct queue *q;
+
+	len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
+	if (!len)
+		return ATT_ECODE_INVALID_PDU;
+
+	q = queue_new();
+	if (!q)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	gatt_db_read_by_group_type(gatt_db, start, end, uuid, q);
+
+	if (queue_isempty(q)) {
+		queue_destroy(q, NULL);
+		return ATT_ECODE_ATTR_NOT_FOUND;
+	}
+
+	while (queue_peek_head(q)) {
+		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
+		uint8_t *value;
+		int value_len;
+		struct response_data *entry;
+
+		entry = new0(struct response_data, 1);
+		if (!entry) {
+			queue_destroy(q, destroy_response_data);
+			return ATT_ECODE_UNLIKELY;
+		}
+
+		entry->handle = handle;
+
+		if (!gatt_db_read(gatt_db, handle, 0, ATT_OP_READ_BY_GROUP_REQ,
+					&device->bdaddr, &value, &value_len))
+			break;
+
+		entry->value = malloc0(value_len);
+		if (!entry->value) {
+			queue_destroy(q, destroy_response_data);
+			return ATT_ECODE_UNLIKELY;
+		}
+
+		memcpy(entry->value, value, value_len);
+		entry->length = value_len;
+
+		if (!queue_push_tail(device->pending_requests, entry)) {
+			queue_remove_all(device->pending_requests, NULL, NULL,
+							destroy_response_data);
+			queue_destroy(q, NULL);
+			return ATT_ECODE_UNLIKELY;
+		}
+	}
+
+	queue_destroy(q, NULL);
+
+	send_pending_response(cmd[0], device);
+
+	return 0;
+}
+
 static bool match_handle_val_by_empty_len(const void *data,
 							const void *user_data)
 {
@@ -4435,7 +4475,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 	switch (ipdu[0]) {
 	case ATT_OP_READ_BY_GROUP_REQ:
 		status = read_by_group_type(ipdu, len, opdu, sizeof(opdu),
-								&length);
+								&length, dev);
 		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
 		status = read_by_type(ipdu, len, dev);
-- 
1.9.0

