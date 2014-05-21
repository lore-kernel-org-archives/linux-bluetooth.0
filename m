Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 2/2] android/gatt: Use g_attrib buffer where possible for att
Date: Wed, 21 May 2014 12:18:58 +0200
Message-Id: <1400667538-14306-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400667538-14306-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400667538-14306-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces fixed size pdu usage with g_attrib buffer when possible.
When only received packets are decoded we use dynamic allocation with
current mtu.
---
 android/gatt.c | 123 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 25 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 55ffed5..7f89c9d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3582,7 +3582,8 @@ static bool is_service(const bt_uuid_t *type)
 static void send_dev_pending_response(struct gatt_device *device,
 								uint8_t opcode)
 {
-	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	size_t mtu;
+	uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 	struct pending_request *val;
 	uint16_t len = 0;
 	uint8_t error = 0;
@@ -3627,7 +3628,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_type_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3642,7 +3643,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_read_blob_resp(val->value, val->length, val->offset,
-							rsp, sizeof(rsp));
+								rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_REQ:
@@ -3652,7 +3653,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			goto done;
 		}
 
-		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
+		len = enc_read_resp(val->value, val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_BY_GROUP_REQ: {
@@ -3698,7 +3699,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_grp_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_grp_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3746,7 +3747,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		if (list && !error)
-			len = enc_find_by_type_resp(list, rsp, sizeof(rsp));
+			len = enc_find_by_type_resp(list, rsp, mtu);
 		else
 			error = ATT_ECODE_ATTR_NOT_FOUND;
 
@@ -3782,7 +3783,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_prep_write_resp(val->handle, val->offset, val->value,
-						val->length, rsp, sizeof(rsp));
+							val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	default:
@@ -3791,8 +3792,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 
 done:
 	if (!len)
-		len = enc_error_resp(opcode, 0x0000, error, rsp,
-							ATT_DEFAULT_LE_MTU);
+		len = enc_error_resp(opcode, 0x0000, error, rsp, mtu);
 
 	g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
 
@@ -4228,10 +4228,11 @@ failed:
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
 
@@ -4242,15 +4243,17 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
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
 
@@ -4679,10 +4682,22 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static size_t get_device_att_mtu(struct gatt_device *device)
+{
+	size_t mtu;
+
+	if (device->negotiated_mtu)
+		return device->negotiated_mtu;
+
+	g_attrib_get_buffer(device->attrib, &mtu);
+
+	return mtu;
+}
+
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *device)
 {
-	uint8_t search_value[ATT_DEFAULT_LE_MTU];
+	uint8_t *search_value;
 	size_t search_vlen;
 	uint16_t start, end;
 	uint16_t handle;
@@ -4692,14 +4707,24 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	DBG("");
 
+	search_value = malloc0(get_device_att_mtu(device));
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
 
@@ -4710,6 +4735,8 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 		data = new0(struct pending_request, 1);
 		if (!data) {
 			queue_destroy(q, NULL);
+			free(search_value);
+
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
@@ -4717,6 +4744,8 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 		if (!data) {
 			destroy_pending_request(data);
 			queue_destroy(q, NULL);
+			free(search_value);
+
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
@@ -4731,6 +4760,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	queue_destroy(q, NULL);
+	free(search_value);
 
 	process_dev_pending_requests(device, ATT_OP_FIND_BY_TYPE_REQ);
 
@@ -4740,14 +4770,30 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t *value;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
 
+	value = malloc0(get_device_att_mtu(dev));
+	if (!value)
+		return;
+
 	len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
-	if (!len)
+	if (!len) {
+		free(value);
+
 		return;
+	}
+
+	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
+								&dev->bdaddr)) {
+		free(value);
+
+		return;
+	}
+
+	free(value);
 
 	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
 }
@@ -4755,18 +4801,30 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t *value;
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
 
+	value = malloc0(get_device_att_mtu(dev));
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
@@ -4774,20 +4832,32 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t *value;
 	uint16_t handle;
 	uint16_t offset;
 	uint16_t len;
 	size_t vlen;
 
+	value = malloc0(get_device_att_mtu(dev));
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
@@ -5156,9 +5226,10 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
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
@@ -5166,6 +5237,8 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
+	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
+
 	/* TODO handle CCC */
 
 	/* Set services changed notification flag */
-- 
1.9.3

