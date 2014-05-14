Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 02/15] android/gatt: Refactor ATT read operations
Date: Wed, 14 May 2014 12:18:06 +0200
Message-Id: <1400062699-2372-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400062699-2372-1-git-send-email-marcin.kraglak@tieto.com>
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
 android/gatt.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 172 insertions(+), 30 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e5db32a..35ee68e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -156,6 +156,8 @@ struct gatt_device {
 
 	int ref;
 	int conn_cnt;
+
+	struct queue *pending_requests;
 };
 
 struct app_connection {
@@ -748,6 +750,21 @@ static void disconnect_notify_by_device(void *data, void *user_data)
 		send_app_connect_notify(conn, GATT_FAILURE);
 }
 
+struct response_data {
+	uint16_t handle;
+	uint16_t length;
+	uint8_t *value;
+	uint16_t offset;
+};
+
+static void destroy_response_data(void *data)
+{
+	struct response_data *entry = data;
+
+	free(entry->value);
+	free(entry);
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -756,6 +773,7 @@ static void destroy_device(void *data)
 		return;
 
 	queue_destroy(dev->services, destroy_service);
+	queue_destroy(dev->pending_requests, destroy_response_data);
 
 	free(dev);
 }
@@ -1138,6 +1156,13 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
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
@@ -4027,6 +4052,66 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static void send_pending_response(uint8_t opcode, struct gatt_device *device)
+{
+	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	struct response_data *val;
+	uint16_t len = 0;
+	uint8_t error = ATT_ECODE_UNLIKELY;
+
+	switch (opcode) {
+	case ATT_OP_READ_BLOB_REQ:
+		val = queue_pop_head(device->pending_requests);
+		if (!val) {
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+			goto done;
+		}
+
+		len = enc_read_blob_resp(val->value, val->length, val->offset,
+							rsp, sizeof(rsp));
+		destroy_response_data(val);
+		break;
+	case ATT_OP_READ_REQ:
+		val = queue_pop_head(device->pending_requests);
+		if (!val) {
+			error = ATT_ECODE_ATTR_NOT_FOUND;
+			goto done;
+		}
+
+		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
+		destroy_response_data(val);
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
+							destroy_response_data);
+}
+
+static bool match_handle_val_by_empty_len(const void *data,
+							const void *user_data)
+{
+	const struct response_data *handle_data = data;
+
+	return !handle_data->length;
+}
+
+static bool match_handle_val_by_handle(const void *data, const void *user_data)
+{
+	const struct response_data *handle_data = data;
+	uint16_t handle = PTR_TO_UINT(user_data);
+
+	return handle_data->handle == handle;
+}
+
 static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 						uint8_t *rsp, size_t rsp_size,
 						uint16_t *length)
@@ -4086,6 +4171,9 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 	uint16_t handle;
 	uint16_t len;
 	uint16_t offset = 0;
+	uint8_t *value;
+	int length;
+	struct response_data *data;
 
 	DBG("");
 
@@ -4105,9 +4193,32 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_REQ_NOT_SUPP;
 	}
 
-	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr, NULL,
-									NULL))
+	data = new0(struct response_data, 1);
+	if (!data)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	data->handle = handle;
+	queue_push_tail(dev->pending_requests, data);
+
+	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr, &value,
+								&length)) {
+		queue_remove(dev->pending_requests, data);
+		destroy_response_data(data);
 		return ATT_ECODE_UNLIKELY;
+	}
+
+	/* Direct database read */
+	if (length > -1) {
+		data->value = malloc0(length);
+		if (!data->value) {
+			free(data);
+			return ATT_ECODE_INSUFF_RESOURCES;
+		}
+		data->length = length;
+		memcpy(data->value, value, length);
+
+		send_pending_response(cmd[0], dev);
+	}
 
 	return 0;
 }
@@ -4308,9 +4419,6 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
 		status = read_request(ipdu, len, dev);
-		if (!status)
-			/* Response will be sent in callback */
-			return;
 		break;
 	case ATT_OP_MTU_REQ:
 		status = mtu_att_handle(ipdu, len, opdu, sizeof(opdu), dev,
@@ -4353,7 +4461,8 @@ done:
 		length = enc_error_resp(ipdu[0], 0x0000, status, opdu,
 							ATT_DEFAULT_LE_MTU);
 
-	g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
+	if (length)
+		g_attrib_send(dev->attrib, 0, opdu, length, NULL, NULL, NULL);
 }
 
 static void create_listen_connections(void *data, void *user_data)
@@ -4454,8 +4563,7 @@ static struct gap_srvc_handles gap_srvc_data;
 static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 					bdaddr_t *bdaddr, void *user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
-	uint16_t len;
+	struct response_data *entry;
 	struct gatt_device *dev;
 
 	DBG("");
@@ -4466,33 +4574,51 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 		return;
 	}
 
+	entry = queue_find(dev->pending_requests, match_handle_val_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		goto done;
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
+			goto done;
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
+			goto done;
+		}
 
-	if (handle == gap_srvc_data.priv) {
-		uint8_t val = PERIPHERAL_PRIVACY_DISABLE;
-		len = enc_read_resp(&val, sizeof(val), pdu, sizeof(pdu));
-		goto done;
+		put_le16(APPEARANCE_GENERIC_PHONE, entry->value);
+		entry->length = sizeof(uint8_t) * 2;
+	} else if (handle == gap_srvc_data.priv) {
+		entry->value = malloc0(1);
+		if (!entry->value) {
+			queue_remove(dev->pending_requests, entry);
+			free(entry);
+			goto done;
+		}
+
+		*entry->value = PERIPHERAL_PRIVACY_DISABLE;
+		entry->length = sizeof(uint8_t);
 	}
 
-	error("gatt: Unknown handle 0x%02x", handle);
-	len = enc_error_resp(ATT_OP_READ_REQ, handle,
-					ATT_ECODE_UNLIKELY, pdu, sizeof(pdu));
 
+	entry->offset = offset;
 done:
-	g_attrib_send(dev->attrib, 0, pdu, len, NULL, NULL, NULL);
+	if (!queue_find(dev->pending_requests, match_handle_val_by_empty_len,
+									NULL))
+		send_pending_response(att_opcode, dev);
 }
 
 static void register_gap_service(void)
@@ -4556,10 +4682,9 @@ static void device_info_read_cb(uint16_t handle, uint16_t offset,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
 					void *user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
+	struct response_data *entry;
 	struct gatt_device *dev;
 	char *buf = user_data;
-	uint16_t len;
 
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
@@ -4567,9 +4692,26 @@ static void device_info_read_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
-	len = enc_read_resp((uint8_t *) buf, strlen(buf), pdu, sizeof(pdu));
+	entry = queue_find(dev->pending_requests, match_handle_val_by_handle,
+							UINT_TO_PTR(handle));
+	if (!entry)
+		goto done;
+
+	entry->value = malloc0(strlen(buf));
+	if (!entry->value) {
+		queue_remove(dev->pending_requests, entry);
+		free(entry);
+		goto done;
+	}
+
+	entry->length = strlen(buf);
+	memcpy(entry->value, buf, entry->length);
+	entry->offset = offset;
 
-	g_attrib_send(dev->attrib, 0, pdu, len, NULL, NULL, NULL);
+done:
+	if (!queue_find(dev->pending_requests, match_handle_val_by_empty_len,
+									NULL))
+		send_pending_response(att_opcode, dev);
 }
 
 static void register_device_info_service(void)
-- 
1.9.0

