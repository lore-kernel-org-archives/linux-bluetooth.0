Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 02/15] android/gatt: Refactor ATT read operations
Date: Thu, 15 May 2014 15:02:24 +0200
Message-Id: <1400158957-22216-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400158957-22216-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes device info and gap services callbacks to use response queue.
It will allow them work with plain read and read by type as well.

This starts transition to single response data queue, which should be
filled by various read type functions and processed in one place. This
will unify the way that responses are send, regardless of data source
(value taken directly from database, returned by read callback or sent
from upper layers asynchronously).

We will also introduce 'getter' type functions, using handles to
retrieve data from database. This will make various read and find
operations return handles instead of their own custom structures,
different for every operation performed.
---
 android/gatt.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 208 insertions(+), 34 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 67a1330..74b321d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -156,6 +156,8 @@ struct gatt_device {
 
 	int ref;
 	int conn_cnt;
+
+	struct queue *pending_requests;
 };
 
 struct app_connection {
@@ -753,6 +755,25 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 		send_app_connect_notify(conn, GATT_FAILURE);
 }
 
+#define READ_INIT -3
+#define READ_PENDING -2
+#define READ_FAILED -1
+
+struct pending_request {
+	uint16_t handle;
+	int length;
+	uint8_t *value;
+	uint16_t offset;
+};
+
+static void destroy_pending_request(void *data)
+{
+	struct pending_request *entry = data;
+
+	free(entry->value);
+	free(entry);
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -761,6 +782,7 @@ static void destroy_device(void *data)
 		return;
 
 	queue_destroy(dev->services, destroy_service);
+	queue_destroy(dev->pending_requests, destroy_pending_request);
 
 	free(dev);
 }
@@ -1143,6 +1165,13 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 		return NULL;
 	}
 
+	dev->pending_requests = queue_new();
+	if (!dev->pending_requests) {
+		error("gatt: Failed to allocate memory for client");
+		destroy_device(dev);
+		return NULL;
+	}
+
 	if (!queue_push_head(gatt_devices, dev)) {
 		error("gatt: Cannot push device to queue");
 		destroy_device(dev);
@@ -3387,6 +3416,118 @@ failed:
 				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
 
+static void send_dev_pending_response(struct gatt_device *device,
+								uint8_t opcode)
+{
+	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	struct pending_request *val;
+	uint16_t len = 0;
+	uint8_t error = 0;
+
+	switch (opcode) {
+	case ATT_OP_READ_BLOB_REQ:
+		val = queue_pop_head(device->pending_requests);
+		if (!val || val->length == READ_FAILED) {
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+			goto done;
+		}
+
+		len = enc_read_blob_resp(val->value, val->length, val->offset,
+							rsp, sizeof(rsp));
+		destroy_pending_request(val);
+		break;
+	case ATT_OP_READ_REQ:
+		val = queue_pop_head(device->pending_requests);
+		if (!val || val->length == READ_FAILED) {
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+			goto done;
+		}
+
+		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
+		destroy_pending_request(val);
+		break;
+	default:
+		break;
+	}
+
+done:
+	if (!len)
+		len = enc_error_resp(opcode, 0x0000, error, rsp,
+							ATT_DEFAULT_LE_MTU);
+
+	g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
+
+	queue_remove_all(device->pending_requests, NULL, NULL,
+						destroy_pending_request);
+}
+
+struct request_processing_data {
+	uint8_t opcode;
+	struct gatt_device *device;
+};
+
+static bool match_pending_dev_request(const void *data, const void *user_data)
+{
+	const struct pending_request *pending_request = data;
+
+	return pending_request->length == READ_PENDING;
+}
+
+static bool match_dev_request_by_handle(const void *data, const void *user_data)
+{
+	const struct pending_request *handle_data = data;
+	uint16_t handle = PTR_TO_UINT(user_data);
+
+	return handle_data->handle == handle;
+}
+
+static void read_requested_attributes(void *data, void *user_data)
+{
+	struct pending_request *resp_data = data;
+	struct request_processing_data *process_data = user_data;
+	uint8_t *value;
+	int value_len;
+
+	if (!gatt_db_read(gatt_db, resp_data->handle,
+						resp_data->offset,
+						process_data->opcode,
+						&process_data->device->bdaddr,
+						&value, &value_len))
+		resp_data->length = READ_FAILED;
+
+	/* We have value here already if no callback will be called */
+	if (value_len > -1) {
+		resp_data->value = malloc0(value_len);
+		if (!resp_data->value) {
+			/* If data cannot be copied, act like when read fails */
+			resp_data->length = READ_FAILED;
+			return;
+		}
+
+		memcpy(resp_data->value, value, value_len);
+		resp_data->length = value_len;
+	} else {
+		resp_data->length = READ_PENDING;
+	}
+}
+
+static void process_dev_pending_requests(struct gatt_device *device,
+							uint8_t att_opcode)
+{
+	struct request_processing_data process_data;
+
+	process_data.device = device;
+	process_data.opcode = att_opcode;
+
+	/* Process pending requests and prepare response */
+	queue_foreach(device->pending_requests, read_requested_attributes,
+								&process_data);
+
+	if (!queue_find(device->pending_requests,
+					match_pending_dev_request, NULL))
+		send_dev_pending_response(device, att_opcode);
+}
+
 static void send_gatt_response(uint8_t opcode, uint16_t handle,
 					uint16_t offset, uint8_t status,
 					uint16_t len, const uint8_t *data,
@@ -4096,7 +4237,8 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 {
 	uint16_t handle;
 	uint16_t len;
-	uint16_t offset = 0;
+	uint16_t offset;
+	struct pending_request *data;
 
 	DBG("");
 
@@ -4110,15 +4252,26 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 		len = dec_read_req(cmd, cmd_len, &handle);
 		if (!len)
 			return ATT_ECODE_INVALID_PDU;
+		offset = 0;
 		break;
 	default:
 		error("gatt: Unexpected read type 0x%02x", cmd[0]);
 		return ATT_ECODE_REQ_NOT_SUPP;
 	}
 
-	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr, NULL,
-									NULL))
-		return ATT_ECODE_UNLIKELY;
+	data = new0(struct pending_request, 1);
+	if (!data)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	data->offset = offset;
+	data->handle = handle;
+	data->length = READ_INIT;
+	if (!queue_push_tail(dev->pending_requests, data)) {
+		free(data);
+		return ATT_ECODE_INSUFF_RESOURCES;
+	}
+
+	process_dev_pending_requests(dev, cmd[0]);
 
 	return 0;
 }
@@ -4319,9 +4472,6 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
 		status = read_request(ipdu, len, dev);
-		if (!status)
-			/* Response will be sent in callback */
-			return;
 		break;
 	case ATT_OP_MTU_REQ:
 		status = mtu_att_handle(ipdu, len, opdu, sizeof(opdu), dev,
@@ -4364,7 +4514,8 @@ done:
 		length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
 							ATT_DEFAULT_LE_MTU);
 
-	g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
+	if (length)
+		g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
 }
 
 static void create_listen_connections(void *data, void *user_data)
@@ -4465,8 +4616,7 @@ static struct gap_srvc_handles gap_srvc_data;
 static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 					bdaddr_t *bdaddr, void *user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
-	uint16_t len;
+	struct pending_request *entry;
 	struct gatt_device *dev;
 
 	DBG("");
@@ -4477,33 +4627,46 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 		return;
 	}
 
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		return;
+
 	if (handle == gap_srvc_data.dev_name) {
 		const char *name = bt_get_adapter_name();
 
-		len = enc_read_resp((uint8_t *)name, strlen(name),
-							pdu, sizeof(pdu));
-		goto done;
-	}
+		entry->value = malloc0(strlen(name));
+		if (!entry->value) {
+			queue_remove(dev->pending_requests, entry);
+			free(entry);
+			return;
+		}
 
-	if (handle == gap_srvc_data.appear) {
-		uint8_t val[2];
-		put_le16(APPEARANCE_GENERIC_PHONE, val);
-		len = enc_read_resp(val, sizeof(val), pdu, sizeof(pdu));
-		goto done;
-	}
+		entry->length = strlen(name);
+		memcpy(entry->value, bt_get_adapter_name(), entry->length);
+	} else if (handle == gap_srvc_data.appear) {
+		entry->value = malloc0(2);
+		if (!entry->value) {
+			queue_remove(dev->pending_requests, entry);
+			free(entry);
+			return;
+		}
 
-	if (handle == gap_srvc_data.priv) {
-		uint8_t val = PERIPHERAL_PRIVACY_DISABLE;
-		len = enc_read_resp(&val, sizeof(val), pdu, sizeof(pdu));
-		goto done;
-	}
+		put_le16(APPEARANCE_GENERIC_PHONE, entry->value);
+		entry->length = sizeof(uint8_t) * 2;
+	} else if (handle == gap_srvc_data.priv) {
+		entry->value = malloc0(1);
+		if (!entry->value) {
+			queue_remove(dev->pending_requests, entry);
+			free(entry);
+			return;
+		}
 
-	error("gatt: Unknown handle 0x%02x", handle);
-	len = enc_error_resp(ATT_OP_READ_REQ, handle,
-					ATT_ECODE_UNLIKELY, pdu, sizeof(pdu));
+		*entry->value = PERIPHERAL_PRIVACY_DISABLE;
+		entry->length = sizeof(uint8_t);
+	}
 
-done:
-	g_attrib_send(dev->attrib, 0, pdu, len, NULL, NULL, NULL);
+	entry->offset = offset;
 }
 
 static void register_gap_service(void)
@@ -4567,10 +4730,9 @@ static void device_info_read_cb(uint16_t handle, uint16_t offset,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
 					void *user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	struct pending_request *entry;
 	struct gatt_device *dev;
 	char *buf = user_data;
-	uint16_t len;
 
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
@@ -4578,9 +4740,21 @@ static void device_info_read_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
-	len = enc_read_resp((uint8_t *) buf, strlen(buf), pdu, sizeof(pdu));
+	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		return;
+
+	entry->value = malloc0(strlen(buf));
+	if (!entry->value) {
+		queue_remove(dev->pending_requests, entry);
+		free(entry);
+		return;
+	}
 
-	g_attrib_send(dev->attrib, 0, pdu, len, NULL, NULL, NULL);
+	entry->length = strlen(buf);
+	memcpy(entry->value, buf, entry->length);
+	entry->offset = offset;
 }
 
 static void register_device_info_service(void)
-- 
1.9.0

