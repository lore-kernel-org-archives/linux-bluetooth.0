Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 04/15] android/gatt: Change handling read_by_type requests
Date: Thu, 15 May 2014 15:02:26 +0200
Message-Id: <1400158957-22216-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now list of handles is returned from database so we should read each
attribute's value. It uses new way of handling requests from remote
devices.
---
 android/gatt.c | 99 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 74b321d..9b28b16 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3425,6 +3425,52 @@ static void send_dev_pending_response(struct gatt_device *device,
 	uint8_t error = 0;
 
 	switch (opcode) {
+	case ATT_OP_READ_BY_TYPE_REQ: {
+		struct att_data_list *adl;
+		int iterator = 0;
+		int length;
+		struct queue *temp;
+
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
+			destroy_pending_request(val);
+			val = queue_pop_head(temp);
+		}
+
+		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
+
+		att_data_list_free(adl);
+		queue_destroy(temp, destroy_pending_request);
+
+		break;
+	}
 	case ATT_OP_READ_BLOB_REQ:
 		val = queue_pop_head(device->pending_requests);
 		if (!val || val->length == READ_FAILED) {
@@ -4090,19 +4136,6 @@ static void copy_to_att_list(void *data, void *user_data)
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
@@ -4180,16 +4213,12 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
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
 
@@ -4208,26 +4237,28 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_ATTR_NOT_FOUND;
 	}
 
-	len = queue_length(q);
-	h = queue_peek_tail(q);
+	while (queue_peek_head(q)) {
+		struct pending_request *data;
+		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
 
-	/* Element here is handle + value*/
-	adl = att_data_list_alloc(len, sizeof(uint16_t) + h->length);
-	if (!adl) {
-		queue_destroy(q, free);
-		return ATT_ECODE_INSUFF_RESOURCES;
-	}
+		data = new0(struct pending_request, 1);
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
+	process_dev_pending_requests(device, ATT_OP_READ_BY_TYPE_REQ);
 
-	att_data_list_free(adl);
-	queue_destroy(q, free);
+	/* We send immediate if no data left to be filled by async callbacks */
+	if (!queue_find(device->pending_requests, match_pending_dev_request,
+									NULL))
+		send_dev_pending_response(device, ATT_OP_READ_BY_TYPE_REQ);
 
 	return 0;
 }
@@ -4467,7 +4498,7 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
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

