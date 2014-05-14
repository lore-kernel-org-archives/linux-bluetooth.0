Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 04/15] android/gatt: Change handling read_by_type requests
Date: Wed, 14 May 2014 20:30:05 +0200
Message-Id: <1400092216-10358-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400092216-10358-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now list of handles is returned from database so we should read each
attribute's value. It uses new way of handling requests from remote
devices.
---
 android/gatt.c | 166 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 132 insertions(+), 34 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 95049b2..6b574f3 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -756,6 +756,8 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 }
 
 struct response_data {
+	bool read_done;
+
 	uint16_t handle;
 	uint16_t length;
 	uint8_t *value;
@@ -3974,19 +3976,6 @@ static void copy_to_att_list(void *data, void *user_data)
 	memcpy(&value[4], group->value, group->len);
 }
 
-static void copy_to_att_list_type(void *data, void *user_data)
-{
-	struct copy_att_list_data *l = user_data;
-	struct gatt_db_handle_value *hdl_val = data;
-	uint8_t *value;
-
-	value = l->adl->data[l->iterator++];
-
-	put_le16(hdl_val->handle, value);
-
-	memcpy(&value[2], hdl_val->value, hdl_val->length);
-}
-
 static void copy_to_att_list_info(void *data, void *user_data)
 {
 	struct copy_att_list_data *l = user_data;
@@ -4012,6 +4001,73 @@ static void copy_to_att_list_info(void *data, void *user_data)
 	}
 }
 
+struct request_processing_data {
+	uint8_t opcode;
+	struct gatt_device *device;
+};
+
+static void read_requested_db_data(void *data, void *user_data)
+{
+	struct response_data *resp_data = data;
+	struct request_processing_data *process_data = user_data;
+
+	uint8_t *value;
+	int value_len;
+
+	/*
+	 * Store read result as this needs to be removed from queue or else
+	 * queue will not be sent at all.
+	 */
+	resp_data->read_done = gatt_db_read(gatt_db, resp_data->handle,
+						resp_data->offset,
+						process_data->opcode,
+						&process_data->device->bdaddr,
+						&value, &value_len);
+
+	/* We have value here already if no callback will be called */
+	if (value_len > -1) {
+		resp_data->value = malloc0(value_len);
+		if (!resp_data->value) {
+			/* If data cannot be copied, act like when read fails */
+			resp_data->read_done = false;
+			return;
+		}
+
+		memcpy(resp_data->value, value, value_len);
+		resp_data->length = value_len;
+	}
+}
+
+static bool match_failed_read_request(const void *data, const void *user_data)
+{
+	const struct response_data *resp_data = data;
+
+	return !resp_data->read_done;
+}
+
+static void process_pending_read_requests(uint8_t att_opcode,
+						struct gatt_device *device)
+{
+	struct request_processing_data process_data;
+
+	process_data.device = device;
+	process_data.opcode = att_opcode;
+
+	/*
+	 * This could be done in one iteration by having queue_foreach_safe(),
+	 * capable of removing currently processed node. We could also consider
+	 * using iterable list instead of queue.
+	 */
+
+	/* process pending requests and prepare response */
+	queue_foreach(device->pending_requests, read_requested_db_data,
+								&process_data);
+
+	/* remove entries for failing read attempts */
+	queue_remove_all(device->pending_requests, match_failed_read_request,
+						NULL, destroy_response_data);
+}
+
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length)
@@ -4066,11 +4122,55 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 static void send_pending_response(uint8_t opcode, struct gatt_device *device)
 {
 	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	struct att_data_list *adl;
 	struct response_data *val;
 	uint16_t len = 0;
 	uint8_t error = ATT_ECODE_UNLIKELY;
 
 	switch (opcode) {
+	case ATT_OP_READ_BY_TYPE_REQ: {
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
+		adl = att_data_list_alloc(queue_length(temp), sizeof(uint16_t) +
+									length);
+
+		val = queue_pop_head(temp);
+		while (val) {
+			uint8_t *value = adl->data[iterator++];
+
+			put_le16(val->handle, value);
+			memcpy(&value[2], val->value, val->length);
+
+			destroy_response_data(val);
+			val = queue_pop_head(temp);
+		}
+
+		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
+
+		att_data_list_free(adl);
+		queue_destroy(temp, destroy_response_data);
+
+		break;
+	}
 	case ATT_OP_READ_BLOB_REQ:
 		val = queue_pop_head(device->pending_requests);
 		if (!val) {
@@ -4124,16 +4224,12 @@ static bool match_handle_val_by_handle(const void *data, const void *user_data)
 }
 
 static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
-						uint8_t *rsp, size_t rsp_size,
-						uint16_t *length)
+						struct gatt_device *device)
 {
 	uint16_t start, end;
 	uint16_t len;
 	bt_uuid_t uuid;
 	struct queue *q;
-	struct att_data_list *adl;
-	struct copy_att_list_data l;
-	struct gatt_db_handle_value *h;
 
 	DBG("");
 
@@ -4152,26 +4248,28 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_ATTR_NOT_FOUND;
 	}
 
-	len = queue_length(q);
-	h = queue_peek_tail(q);
+	while (queue_peek_head(q)) {
+		struct response_data *data;
+		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
 
-	/* Element here is handle + value*/
-	adl = att_data_list_alloc(len, sizeof(uint16_t) + h->length);
-	if (!adl) {
-		queue_destroy(q, free);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+		data = new0(struct response_data, 1);
+		if (!data) {
+			queue_destroy(q, NULL);
+			return ATT_ECODE_INSUFF_RESOURCES;
+		}
 
-	l.iterator = 0;
-	l.adl = adl;
+		data->handle = handle;
+		queue_push_tail(device->pending_requests, data);
+	}
 
-	queue_foreach(q, copy_to_att_list_type, &l);
+	queue_destroy(q, NULL);
 
-	len = enc_read_by_type_resp(adl, rsp, rsp_size);
-	*length = len;
+	process_pending_read_requests(ATT_OP_READ_BY_TYPE_REQ, device);
 
-	att_data_list_free(adl);
-	queue_destroy(q, free);
+	/* We send immediate if no data left to be filled by async callbacks */
+	if (!queue_find(device->pending_requests, match_handle_val_by_empty_len,
+									NULL))
+		send_pending_response(ATT_OP_READ_BY_TYPE_REQ, device);
 
 	return 0;
 }
@@ -4425,7 +4523,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 								&length);
 		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
-		status = read_by_type(ipdu, len, opdu, sizeof(opdu), &length);
+		status = read_by_type(ipdu, len, dev);
 		break;
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
-- 
1.9.0

