Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 15/15] android/gatt: Add find by type and value handler
Date: Wed, 14 May 2014 12:18:19 +0200
Message-Id: <1400062699-2372-16-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

As from database point of view there are two data sources (db entry,
and callbacks), we need to perform 'find by type' in databse and filter
out entries with not matching values, before sending.
---
 android/gatt.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index e083cf1..974b4c4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -755,6 +755,9 @@ struct response_data {
 	uint16_t length;
 	uint8_t *value;
 	uint16_t offset;
+
+	uint8_t *filter_value;
+	uint16_t filter_vlen;
 };
 
 static void destroy_response_data(void *data)
@@ -762,6 +765,7 @@ static void destroy_response_data(void *data)
 	struct response_data *entry = data;
 
 	free(entry->value);
+	free(entry->filter_value);
 	free(entry);
 }
 
@@ -3944,6 +3948,21 @@ static const struct ipc_handler cmd_handlers[] = {
 		sizeof(struct hal_cmd_gatt_server_send_response) },
 };
 
+static bool is_service(const bt_uuid_t *type)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	if (!bt_uuid_cmp(&uuid, type))
+		return true;
+
+	bt_uuid16_create(&uuid, GATT_SND_SVC_UUID);
+	if (!bt_uuid_cmp(&uuid, type))
+		return true;
+
+	return false;
+}
+
 static void send_pending_response(uint8_t opcode, struct gatt_device *device)
 {
 	uint8_t rsp[ATT_DEFAULT_LE_MTU];
@@ -4054,6 +4073,54 @@ static void send_pending_response(uint8_t opcode, struct gatt_device *device)
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_response_data);
+		break;
+	}
+	case ATT_OP_FIND_BY_TYPE_REQ: {
+		GSList *list = NULL;
+
+		val = queue_pop_head(device->pending_requests);
+		while (val) {
+			struct att_range *range;
+			const bt_uuid_t *type;
+
+			/* Its find by type and value - filter by value here */
+			if ((val->length != val->filter_vlen) ||
+				memcmp(val->value, val->filter_value,
+								val->length)) {
+
+				destroy_response_data(val);
+				val = queue_pop_head(device->pending_requests);
+				continue;
+			}
+
+			range = new0(struct att_range, 1);
+			if (!range) {
+				destroy_response_data(val);
+				error = ATT_ECODE_INSUFF_RESOURCES;
+				break;
+			}
+
+			range->start = val->handle;
+			range->end = range->start;
+
+			/* Get proper end handle if its group type */
+			type = gatt_db_get_attribute_type(gatt_db, val->handle);
+			if (is_service(type))
+				range->end = gatt_db_get_end_handle(gatt_db,
+								val->handle);
+
+			list = g_slist_append(list, range);
+
+			destroy_response_data(val);
+			val = queue_pop_head(device->pending_requests);
+		}
+
+		if (list && !error)
+			len = enc_find_by_type_resp(list, rsp, sizeof(rsp));
+		else
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+
+		g_slist_free_full(list, free);
 
 		break;
 	}
@@ -4396,6 +4463,89 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
+							struct gatt_device *dev)
+{
+	uint8_t search_value[ATT_DEFAULT_LE_MTU];
+	size_t search_vlen;
+	uint16_t start, end;
+	uint16_t handle;
+	struct queue *q;
+	bt_uuid_t uuid;
+	uint16_t len;
+
+	uint8_t *value;
+	int value_length;
+
+	DBG("");
+
+	len = dec_find_by_type_req(cmd, cmd_len, &start, &end, &uuid,
+						search_value, &search_vlen);
+	if (!len)
+		return ATT_ECODE_INVALID_PDU;
+
+	q = queue_new();
+	if (!q)
+		return ATT_ECODE_UNLIKELY;
+
+	gatt_db_find_by_type(gatt_db, start, end, &uuid, q);
+
+	handle = PTR_TO_UINT(queue_pop_head(q));
+	while (handle) {
+		struct response_data *data;
+
+		data = new0(struct response_data, 1);
+		if (!data) {
+			queue_destroy(q, NULL);
+			return ATT_ECODE_INSUFF_RESOURCES;
+		}
+
+		data->filter_value = malloc0(search_vlen);
+		if (!data) {
+			destroy_response_data(data);
+			queue_destroy(q, NULL);
+			return ATT_ECODE_INSUFF_RESOURCES;
+		}
+
+		data->handle = handle;
+		data->filter_vlen = search_vlen;
+		memcpy(data->filter_value, search_value, search_vlen);
+
+		queue_push_tail(dev->pending_requests, data);
+
+		if (!gatt_db_read(gatt_db, handle, 0, cmd[0], &dev->bdaddr,
+						&value, &value_length)) {
+			queue_remove(dev->pending_requests, data);
+			destroy_response_data(data);
+			continue;
+		}
+
+		/* Fill if its direct read and not callback returned value */
+		if (value_length > -1) {
+			data->value = malloc0(value_length);
+			if (!data->value) {
+				queue_remove(dev->pending_requests, data);
+				destroy_response_data(data);
+				return ATT_ECODE_INSUFF_RESOURCES;
+			}
+
+			data->length = value_length;
+			memcpy(data->value, value, value_length);
+		}
+
+		handle = PTR_TO_UINT(queue_pop_head(q));
+	}
+
+	queue_destroy(q, NULL);
+
+	/* Send if no response_data elements left to be filled by callbacks */
+	if (!queue_find(dev->pending_requests, match_handle_val_by_empty_len,
+									NULL))
+		send_pending_response(cmd[0], dev);
+
+	return 0;
+}
+
 static uint8_t write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
@@ -4507,9 +4657,11 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		if (!status)
 			return;
 		break;
+	case ATT_OP_FIND_BY_TYPE_REQ:
+		status = find_by_type_request(ipdu, len, dev);
+		break;
 	case ATT_OP_EXEC_WRITE_REQ:
 		/* TODO */
-	case ATT_OP_FIND_BY_TYPE_REQ:
 	case ATT_OP_HANDLE_CNF:
 	case ATT_OP_HANDLE_IND:
 	case ATT_OP_HANDLE_NOTIFY:
-- 
1.9.0

