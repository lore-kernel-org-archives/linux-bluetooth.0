Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv5 1/3] android/gatt: Use g_attrib buffer where possible for att
Date: Mon, 26 May 2014 09:13:14 +0200
Message-Id: <1401088396-2074-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces fixed size pdu usage with g_attrib buffer when possible.
When only received packets are decoded we use dynamic allocation with
current mtu.
---
 android/gatt.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 70cd5fe..2ae3669 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3569,7 +3569,8 @@ static bool is_service(const bt_uuid_t *type)
 static void send_dev_pending_response(struct gatt_device *device,
 								uint8_t opcode)
 {
-	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	size_t mtu;
+	uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 	struct pending_request *val;
 	uint16_t len = 0;
 	uint8_t error = 0;
@@ -3613,7 +3614,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_type_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3628,7 +3629,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_read_blob_resp(val->value, val->length, val->offset,
-							rsp, sizeof(rsp));
+								rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_REQ:
@@ -3638,7 +3639,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			goto done;
 		}
 
-		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
+		len = enc_read_resp(val->value, val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_BY_GROUP_REQ: {
@@ -3684,7 +3685,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_grp_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_grp_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3732,7 +3733,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		if (list && !error)
-			len = enc_find_by_type_resp(list, rsp, sizeof(rsp));
+			len = enc_find_by_type_resp(list, rsp, mtu);
 		else
 			error = ATT_ECODE_ATTR_NOT_FOUND;
 
@@ -3768,7 +3769,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_prep_write_resp(val->handle, val->offset, val->value,
-						val->length, rsp, sizeof(rsp));
+							val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	default:
@@ -3777,8 +3778,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 
 done:
 	if (!len)
-		len = enc_error_resp(opcode, 0x0000, error, rsp,
-							ATT_DEFAULT_LE_MTU);
+		len = enc_error_resp(opcode, 0x0000, error, rsp, mtu);
 
 	g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
 
@@ -4217,10 +4217,11 @@ failed:
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
 
@@ -4231,15 +4232,17 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
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
 
@@ -4659,7 +4662,7 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *device)
 {
-	uint8_t search_value[ATT_DEFAULT_LE_MTU];
+	uint8_t search_value[cmd_len];
 	size_t search_vlen;
 	uint16_t start, end;
 	uint16_t handle;
@@ -4717,7 +4720,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4732,7 +4735,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	struct pending_request *data;
 	uint16_t handle;
 	uint16_t len;
@@ -4764,7 +4767,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	struct pending_request *data;
 	uint16_t handle;
 	uint16_t offset;
@@ -5172,9 +5175,10 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
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
@@ -5182,6 +5186,8 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
+	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
+
 	/* TODO handle CCC */
 
 	/* Set services changed notification flag */
-- 
1.9.3

