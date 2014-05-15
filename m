Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 15/15] android/gatt: Add find by type and value handler
Date: Thu, 15 May 2014 15:02:37 +0200
Message-Id: <1400158957-22216-16-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

As from database point of view there are two data sources (db entry,
and callbacks), we need to perform 'find by type' in databse and filter
out entries with not matching values, before sending.
---
 android/gatt.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2dbf085..e892571 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -764,6 +764,9 @@ struct pending_request {
 	int length;
 	uint8_t *value;
 	uint16_t offset;
+
+	uint8_t *filter_value;
+	uint16_t filter_vlen;
 };
 
 static void destroy_pending_request(void *data)
@@ -771,6 +774,7 @@ static void destroy_pending_request(void *data)
 	struct pending_request *entry = data;
 
 	free(entry->value);
+	free(entry->filter_value);
 	free(entry);
 }
 
@@ -3416,6 +3420,21 @@ failed:
 				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
 
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
 static void send_dev_pending_response(struct gatt_device *device,
 								uint8_t opcode)
 {
@@ -3542,6 +3561,55 @@ static void send_dev_pending_response(struct gatt_device *device,
 
 		break;
 	}
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
+				destroy_pending_request(val);
+				val = queue_pop_head(device->pending_requests);
+				continue;
+			}
+
+			range = new0(struct att_range, 1);
+			if (!range) {
+				destroy_pending_request(val);
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
+			destroy_pending_request(val);
+			val = queue_pop_head(device->pending_requests);
+		}
+
+		if (list && !error)
+			len = enc_find_by_type_resp(list, rsp, sizeof(rsp));
+		else
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+
+		g_slist_free_full(list, free);
+
+		break;
+	}
 	default:
 		break;
 	}
@@ -4167,7 +4235,6 @@ static const struct ipc_handler cmd_handlers[] = {
 		sizeof(struct hal_cmd_gatt_server_send_response) },
 };
 
-
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length,
@@ -4442,6 +4509,68 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
+						struct gatt_device *device)
+{
+	uint8_t search_value[ATT_DEFAULT_LE_MTU];
+	size_t search_vlen;
+	uint16_t start, end;
+	uint16_t handle;
+	struct queue *q;
+	bt_uuid_t uuid;
+	uint16_t len;
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
+		struct pending_request *data;
+
+		data = new0(struct pending_request, 1);
+		if (!data) {
+			queue_destroy(q, NULL);
+			return ATT_ECODE_INSUFF_RESOURCES;
+		}
+
+		data->filter_value = malloc0(search_vlen);
+		if (!data) {
+			destroy_pending_request(data);
+			queue_destroy(q, NULL);
+			return ATT_ECODE_INSUFF_RESOURCES;
+		}
+
+		data->handle = handle;
+		data->filter_vlen = search_vlen;
+		memcpy(data->filter_value, search_value, search_vlen);
+
+		queue_push_tail(device->pending_requests, data);
+
+		handle = PTR_TO_UINT(queue_pop_head(q));
+	}
+
+	queue_destroy(q, NULL);
+
+	process_dev_pending_requests(device, ATT_OP_FIND_BY_TYPE_REQ);
+
+	/* Send if no response_data elements left to be filled by callbacks */
+	if (!queue_find(device->pending_requests, match_pending_dev_request,
+									NULL))
+		send_dev_pending_response(device, cmd[0]);
+
+	return 0;
+}
+
 static uint8_t write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
@@ -4553,9 +4682,11 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
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

