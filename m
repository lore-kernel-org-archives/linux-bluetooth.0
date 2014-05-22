Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/4] android/gatt: Improve handling pending read/write requests
Date: Thu, 22 May 2014 13:17:43 +0200
Message-Id: <1400757465-11522-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds state and error to pending request. It is not easy to
follow the code and we make sure that any error code provided by Android
server application will be send out to remote device.
---
 android/gatt.c | 94 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 46df0e1..51fccd9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -756,9 +756,11 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 		send_app_connect_notify(conn, GATT_FAILURE);
 }
 
-#define READ_INIT -3
-#define READ_PENDING -2
-#define READ_FAILED -1
+enum pend_req_state {
+	REQUEST_INIT,
+	REQUEST_PENDING,
+	REQUEST_DONE,
+};
 
 struct pending_request {
 	uint16_t handle;
@@ -768,6 +770,9 @@ struct pending_request {
 
 	uint8_t *filter_value;
 	uint16_t filter_vlen;
+
+	enum pend_req_state state;
+	uint8_t error;
 };
 
 static void destroy_pending_request(void *data)
@@ -3550,8 +3555,8 @@ static void send_dev_pending_response(struct gatt_device *device,
 	}
 	case ATT_OP_READ_BLOB_REQ:
 		val = queue_pop_head(device->pending_requests);
-		if (!val || val->length < 0) {
-			error = ATT_ECODE_ATTR_NOT_FOUND;
+		if (val->error) {
+			error = val->error;
 			goto done;
 		}
 
@@ -3561,8 +3566,8 @@ static void send_dev_pending_response(struct gatt_device *device,
 		break;
 	case ATT_OP_READ_REQ:
 		val = queue_pop_head(device->pending_requests);
-		if (!val || val->length < 0) {
-			error = ATT_ECODE_ATTR_NOT_FOUND;
+		if (val->error) {
+			error = val->error;
 			goto done;
 		}
 
@@ -3670,9 +3675,9 @@ static void send_dev_pending_response(struct gatt_device *device,
 	}
 	case ATT_OP_EXEC_WRITE_REQ:
 		val = queue_pop_head(device->pending_requests);
-		if (!val) {
-			error = ATT_ECODE_ATTR_NOT_FOUND;
-			break;
+		if (val->error) {
+			error = val->error;
+			goto done;
 		}
 
 		len = enc_exec_write_resp(rsp);
@@ -3680,9 +3685,9 @@ static void send_dev_pending_response(struct gatt_device *device,
 		break;
 	case ATT_OP_WRITE_REQ:
 		val = queue_pop_head(device->pending_requests);
-		if (!val) {
-			error = ATT_ECODE_ATTR_NOT_FOUND;
-			break;
+		if (val->error) {
+			error = val->error;
+			goto done;
 		}
 
 		len = enc_write_resp(rsp);
@@ -3690,9 +3695,9 @@ static void send_dev_pending_response(struct gatt_device *device,
 		break;
 	case ATT_OP_PREP_WRITE_REQ:
 		val = queue_pop_head(device->pending_requests);
-		if (!val) {
-			error = ATT_ECODE_ATTR_NOT_FOUND;
-			break;
+		if (val->error) {
+			error = val->error;
+			goto done;
 		}
 
 		len = enc_prep_write_resp(val->handle, val->offset, val->value,
@@ -3723,7 +3728,7 @@ static bool match_pending_dev_request(const void *data, const void *user_data)
 {
 	const struct pending_request *pending_request = data;
 
-	return pending_request->length == READ_PENDING;
+	return pending_request->state == REQUEST_PENDING;
 }
 
 static bool match_dev_request_by_handle(const void *data, const void *user_data)
@@ -3746,7 +3751,8 @@ static void read_requested_attributes(void *data, void *user_data)
 						process_data->opcode,
 						&process_data->device->bdaddr,
 						&value, &value_len)) {
-		resp_data->length = READ_FAILED;
+		resp_data->state = REQUEST_DONE;
+		resp_data->error = ATT_ECODE_UNLIKELY;
 		return;
 	}
 
@@ -3755,14 +3761,15 @@ static void read_requested_attributes(void *data, void *user_data)
 		resp_data->value = malloc0(value_len);
 		if (!resp_data->value) {
 			/* If data cannot be copied, act like when read fails */
-			resp_data->length = READ_FAILED;
+			resp_data->state = REQUEST_DONE;
+			resp_data->error = ATT_ECODE_INSUFF_RESOURCES;
 			return;
 		}
 
 		memcpy(resp_data->value, value, value_len);
 		resp_data->length = value_len;
-	} else if (resp_data->length == READ_INIT) {
-		resp_data->length = READ_PENDING;
+	} else if (resp_data->state == REQUEST_INIT) {
+		resp_data->state = REQUEST_PENDING;
 	}
 }
 
@@ -3797,9 +3804,6 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 		goto done;
 	}
 
-	if (status)
-		goto done;
-
 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
 							UINT_TO_PTR(handle));
 	if (!entry) {
@@ -3810,15 +3814,15 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	entry->handle = handle;
 	entry->offset = offset;
 	entry->length = len;
+	entry->state = REQUEST_DONE;
+	entry->error = status;
 
 	if (!len)
 		goto done;
 
 	entry->value = malloc0(len);
 	if (!entry->value) {
-		/* send_dev_pending_request on empty queue sends error resp. */
-		queue_remove(dev->pending_requests, entry);
-		destroy_pending_request(entry);
+		entry->error = ATT_ECODE_INSUFF_RESOURCES;
 
 		goto done;
 	}
@@ -4359,7 +4363,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 		}
 
 		entry->handle = handle;
-		entry->length = READ_INIT;
+		entry->state = REQUEST_INIT;
 
 		if (!queue_push_tail(device->pending_requests, entry)) {
 			queue_remove_all(device->pending_requests, NULL, NULL,
@@ -4410,7 +4414,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
-		data->length = READ_INIT;
+		data->state = REQUEST_INIT;
 		data->handle = handle;
 		queue_push_tail(device->pending_requests, data);
 	}
@@ -4455,7 +4459,7 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	data->offset = offset;
 	data->handle = handle;
-	data->length = READ_INIT;
+	data->state = REQUEST_INIT;
 	if (!queue_push_tail(dev->pending_requests, data)) {
 		free(data);
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -4619,7 +4623,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
-		data->length = READ_INIT;
+		data->state = REQUEST_INIT;
 		data->handle = handle;
 		data->filter_vlen = search_vlen;
 		memcpy(data->filter_value, search_value, search_vlen);
@@ -4872,9 +4876,8 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 
 		entry->value = malloc0(strlen(name));
 		if (!entry->value) {
-			queue_remove(dev->pending_requests, entry);
-			free(entry);
-			return;
+			entry->error = ATT_ECODE_INSUFF_RESOURCES;
+			goto done;
 		}
 
 		entry->length = strlen(name);
@@ -4882,9 +4885,8 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 	} else if (handle == gap_srvc_data.appear) {
 		entry->value = malloc0(2);
 		if (!entry->value) {
-			queue_remove(dev->pending_requests, entry);
-			free(entry);
-			return;
+			entry->error = ATT_ECODE_INSUFF_RESOURCES;
+			goto done;
 		}
 
 		put_le16(APPEARANCE_GENERIC_PHONE, entry->value);
@@ -4892,16 +4894,20 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 	} else if (handle == gap_srvc_data.priv) {
 		entry->value = malloc0(1);
 		if (!entry->value) {
-			queue_remove(dev->pending_requests, entry);
-			free(entry);
-			return;
+			entry->error = ATT_ECODE_INSUFF_RESOURCES;
+			goto done;
 		}
 
 		*entry->value = PERIPHERAL_PRIVACY_DISABLE;
 		entry->length = sizeof(uint8_t);
+	} else {
+		entry->error = ATT_ECODE_ATTR_NOT_FOUND;
 	}
 
 	entry->offset = offset;
+
+done:
+	entry->state  = REQUEST_DONE;
 }
 
 static void register_gap_service(void)
@@ -4982,14 +4988,16 @@ static void device_info_read_cb(uint16_t handle, uint16_t offset,
 
 	entry->value = malloc0(strlen(buf));
 	if (!entry->value) {
-		queue_remove(dev->pending_requests, entry);
-		free(entry);
-		return;
+		entry->error = ATT_ECODE_UNLIKELY;
+		goto done;
 	}
 
 	entry->length = strlen(buf);
 	memcpy(entry->value, buf, entry->length);
 	entry->offset = offset;
+
+done:
+	entry->state = REQUEST_DONE;
 }
 
 static void register_device_info_service(void)
-- 
1.8.4

