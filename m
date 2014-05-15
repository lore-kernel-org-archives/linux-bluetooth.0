Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 12/15] android/gatt: Change handling of read_by_group_type requests
Date: Thu, 15 May 2014 15:02:34 +0200
Message-Id: <1400158957-22216-13-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use modified version of gatt_db_read_by_group_type which return list
of handles instead of specific data.
---
 android/gatt.c | 126 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 39 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 83c2485..2dbf085 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3492,6 +3492,56 @@ static void send_dev_pending_response(struct gatt_device *device,
 		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
 		destroy_pending_request(val);
 		break;
+	case ATT_OP_READ_BY_GROUP_REQ: {
+		struct att_data_list *adl;
+		int iterator = 0;
+		int length;
+		struct queue *temp;
+
+		temp = queue_new();
+		if (!temp)
+			goto done;
+
+		val = queue_pop_head(device->pending_requests);
+		if (!val) {
+			queue_destroy(temp, NULL);
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+			goto done;
+		}
+
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
+			destroy_pending_request(val);
+			val = queue_pop_head(temp);
+		}
+
+		len = enc_read_by_grp_resp(adl, rsp, sizeof(rsp));
+
+		att_data_list_free(adl);
+		queue_destroy(temp, destroy_pending_request);
+
+		break;
+	}
 	default:
 		break;
 	}
@@ -4117,36 +4167,16 @@ static const struct ipc_handler cmd_handlers[] = {
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
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
-						uint16_t *length)
+						uint16_t *length,
+						struct gatt_device *device)
 {
 	uint16_t start, end;
-	uint16_t len;
+	int len;
 	bt_uuid_t uuid;
 	struct queue *q;
-	struct att_data_list *adl;
-	struct copy_att_list_data l;
-	struct gatt_db_group *d;
 
 	len = dec_read_by_grp_req(cmd, cmd_len, &start, &end, &uuid);
 	if (!len)
@@ -4163,26 +4193,44 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_ATTR_NOT_FOUND;
 	}
 
-	len = queue_length(q);
-	d = queue_peek_head(q);
+	while (queue_peek_head(q)) {
+		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
+		uint8_t *value;
+		int value_len;
+		struct pending_request *entry;
 
-	/* Element contains start/end handle + size of uuid */
-	adl = att_data_list_alloc(len, 2 * sizeof(uint16_t) + d->len);
-	if (!adl) {
-		queue_destroy(q, free);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+		entry = new0(struct pending_request, 1);
+		if (!entry) {
+			queue_destroy(q, destroy_pending_request);
+			return ATT_ECODE_UNLIKELY;
+		}
 
-	l.iterator = 0;
-	l.adl = adl;
+		entry->handle = handle;
 
-	queue_foreach(q, copy_to_att_list, &l);
+		if (!gatt_db_read(gatt_db, handle, 0, ATT_OP_READ_BY_GROUP_REQ,
+					&device->bdaddr, &value, &value_len))
+			break;
 
-	len = enc_read_by_grp_resp(adl, rsp, rsp_size);
-	*length = len;
+		entry->value = malloc0(value_len);
+		if (!entry->value) {
+			queue_destroy(q, destroy_pending_request);
+			return ATT_ECODE_UNLIKELY;
+		}
 
-	att_data_list_free(adl);
-	queue_destroy(q, free);
+		memcpy(entry->value, value, value_len);
+		entry->length = value_len;
+
+		if (!queue_push_tail(device->pending_requests, entry)) {
+			queue_remove_all(device->pending_requests, NULL, NULL,
+						destroy_pending_request);
+			queue_destroy(q, NULL);
+			return ATT_ECODE_UNLIKELY;
+		}
+	}
+
+	queue_destroy(q, NULL);
+
+	send_dev_pending_response(device, cmd[0]);
 
 	return 0;
 }
@@ -4473,7 +4521,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
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

