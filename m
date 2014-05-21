Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 2/4] android/gatt: Use g_attrib buffer where possible for att
Date: Wed, 21 May 2014 16:17:33 +0200
Message-Id: <1400681855-7438-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400681855-7438-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400681855-7438-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces fixed size pdu usage with g_attrib buffer when possible.
When only received packets are decoded we use dynamic allocation with
current mtu.
---
 android/gatt.c | 111 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 25 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e9db9e6..c231c95 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3553,7 +3553,8 @@ static bool is_service(const bt_uuid_t *type)
 static void send_dev_pending_response(struct gatt_device *device,
 								uint8_t opcode)
 {
-	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	size_t mtu;
+	uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 	struct pending_request *val;
 	uint16_t len = 0;
 	uint8_t error = 0;
@@ -3598,7 +3599,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_type_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3613,7 +3614,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_read_blob_resp(val->value, val->length, val->offset,
-							rsp, sizeof(rsp));
+								rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_REQ:
@@ -3623,7 +3624,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			goto done;
 		}
 
-		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
+		len = enc_read_resp(val->value, val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_BY_GROUP_REQ: {
@@ -3669,7 +3670,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_grp_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_grp_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3717,7 +3718,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		if (list && !error)
-			len = enc_find_by_type_resp(list, rsp, sizeof(rsp));
+			len = enc_find_by_type_resp(list, rsp, mtu);
 		else
 			error = ATT_ECODE_ATTR_NOT_FOUND;
 
@@ -3753,7 +3754,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_prep_write_resp(val->handle, val->offset, val->value,
-						val->length, rsp, sizeof(rsp));
+							val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	default:
@@ -3762,8 +3763,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 
 done:
 	if (!len)
-		len = enc_error_resp(opcode, 0x0000, error, rsp,
-							ATT_DEFAULT_LE_MTU);
+		len = enc_error_resp(opcode, 0x0000, error, rsp, mtu);
 
 	g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
 
@@ -4199,10 +4199,11 @@ failed:
 static void handle_server_send_indication(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_send_indication *cmd = buf;
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	struct app_connection *conn;
 	uint8_t status;
 	uint16_t length;
+	uint8_t *pdu;
+	size_t mtu;
 
 	DBG("");
 
@@ -4213,15 +4214,17 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 		goto reply;
 	}
 
+	pdu = g_attrib_get_buffer(conn->device->attrib, &mtu);
+
 	if (cmd->confirm)
 		/* TODO: Add data to track confirmation for this request */
 		length = enc_indication(cmd->attribute_handle,
-					(uint8_t *)cmd->value, cmd->len,
-					pdu, sizeof(pdu));
+					(uint8_t *)cmd->value, cmd->len, pdu,
+					mtu);
 	else
 		length = enc_notification(cmd->attribute_handle,
 						(uint8_t *)cmd->value, cmd->len,
-						pdu, sizeof(pdu));
+						pdu, mtu);
 
 	g_attrib_send(conn->device->attrib, 0, pdu, length, NULL, NULL, NULL);
 
@@ -4653,7 +4656,7 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *device)
 {
-	uint8_t search_value[ATT_DEFAULT_LE_MTU];
+	uint8_t *search_value;
 	size_t search_vlen;
 	uint16_t start, end;
 	uint16_t handle;
@@ -4663,14 +4666,24 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	DBG("");
 
+	search_value = malloc0(device->mtu);
+	if (!search_value)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
 	len = dec_find_by_type_req(cmd, cmd_len, &start, &end, &uuid,
 						search_value, &search_vlen);
-	if (!len)
+	if (!len) {
+		free(search_value);
+
 		return ATT_ECODE_INVALID_PDU;
+	}
 
 	q = queue_new();
-	if (!q)
+	if (!q) {
+		free(search_value);
+
 		return ATT_ECODE_UNLIKELY;
+	}
 
 	gatt_db_find_by_type(gatt_db, start, end, &uuid, q);
 
@@ -4681,6 +4694,8 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 		data = new0(struct pending_request, 1);
 		if (!data) {
 			queue_destroy(q, NULL);
+			free(search_value);
+
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
@@ -4688,6 +4703,8 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 		if (!data) {
 			destroy_pending_request(data);
 			queue_destroy(q, NULL);
+			free(search_value);
+
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
@@ -4702,6 +4719,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	queue_destroy(q, NULL);
+	free(search_value);
 
 	process_dev_pending_requests(device, ATT_OP_FIND_BY_TYPE_REQ);
 
@@ -4711,14 +4729,30 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t *value;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
 
+	value = malloc0(dev->mtu);
+	if (!value)
+		return;
+
 	len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
-	if (!len)
+	if (!len) {
+		free(value);
+
+		return;
+	}
+
+	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
+								&dev->bdaddr)) {
+		free(value);
+
 		return;
+	}
+
+	free(value);
 
 	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
 }
@@ -4726,18 +4760,30 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t *value;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
 
+	value = malloc0(dev->mtu);
+	if (!value)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
 	len = dec_write_req(cmd, cmd_len, &handle, value, &vlen);
-	if (!len)
+	if (!len) {
+		free(value);
+
 		return ATT_ECODE_INVALID_PDU;
+	}
 
 	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
-								&dev->bdaddr))
+								&dev->bdaddr)) {
+		free(value);
+
 		return ATT_ECODE_UNLIKELY;
+	}
+
+	free(value);
 
 	return 0;
 }
@@ -4745,20 +4791,32 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t *value;
 	uint16_t handle;
 	uint16_t offset;
 	uint16_t len;
 	size_t vlen;
 
+	value = malloc0(dev->mtu);
+	if (!value)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
 	len = dec_prep_write_req(cmd, cmd_len, &handle, &offset,
 						value, &vlen);
-	if (!len)
+	if (!len) {
+		free(value);
+
 		return ATT_ECODE_INVALID_PDU;
+	}
 
 	if (!gatt_db_write(gatt_db, handle, offset, value, vlen, cmd[0],
-								&dev->bdaddr))
+								&dev->bdaddr)) {
+		free(value);
+
 		return ATT_ECODE_UNLIKELY;
+	}
+
+	free(value);
 
 	return 0;
 }
@@ -5127,9 +5185,10 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 						bdaddr_t *bdaddr,
 						void *user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	struct gatt_device *dev;
 	uint16_t length;
+	size_t mtu;
+	uint8_t *pdu;
 
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
@@ -5137,6 +5196,8 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
+	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
+
 	/* TODO handle CCC */
 
 	/* Set services changed notification flag */
-- 
1.9.3

