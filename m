Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv5 2/4] android/gatt: Use g_attrib buffer where possible for att
Date: Thu, 22 May 2014 12:54:31 +0200
Message-Id: <1400756073-16330-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400756073-16330-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400756073-16330-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces fixed size pdu usage with g_attrib buffer when possible.
When only received packets are decoded we use dynamic allocation with
current mtu.
---
 android/gatt.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 82e8dc1..c67fc97 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3567,7 +3567,8 @@ static bool is_service(const bt_uuid_t *type)
 static void send_dev_pending_response(struct gatt_device *device,
 								uint8_t opcode)
 {
-	uint8_t rsp[ATT_DEFAULT_LE_MTU];
+	size_t mtu;
+	uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 	struct pending_request *val;
 	uint16_t len = 0;
 	uint8_t error = 0;
@@ -3612,7 +3613,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_type_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_type_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3627,7 +3628,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_read_blob_resp(val->value, val->length, val->offset,
-							rsp, sizeof(rsp));
+								rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_REQ:
@@ -3637,7 +3638,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			goto done;
 		}
 
-		len = enc_read_resp(val->value, val->length, rsp, sizeof(rsp));
+		len = enc_read_resp(val->value, val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	case ATT_OP_READ_BY_GROUP_REQ: {
@@ -3683,7 +3684,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 			val = queue_pop_head(temp);
 		}
 
-		len = enc_read_by_grp_resp(adl, rsp, sizeof(rsp));
+		len = enc_read_by_grp_resp(adl, rsp, mtu);
 
 		att_data_list_free(adl);
 		queue_destroy(temp, destroy_pending_request);
@@ -3731,7 +3732,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		if (list && !error)
-			len = enc_find_by_type_resp(list, rsp, sizeof(rsp));
+			len = enc_find_by_type_resp(list, rsp, mtu);
 		else
 			error = ATT_ECODE_ATTR_NOT_FOUND;
 
@@ -3767,7 +3768,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 		}
 
 		len = enc_prep_write_resp(val->handle, val->offset, val->value,
-						val->length, rsp, sizeof(rsp));
+							val->length, rsp, mtu);
 		destroy_pending_request(val);
 		break;
 	default:
@@ -3776,8 +3777,7 @@ static void send_dev_pending_response(struct gatt_device *device,
 
 done:
 	if (!len)
-		len = enc_error_resp(opcode, 0x0000, error, rsp,
-							ATT_DEFAULT_LE_MTU);
+		len = enc_error_resp(opcode, 0x0000, error, rsp, mtu);
 
 	g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
 
@@ -4213,10 +4213,11 @@ failed:
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
 
@@ -4227,15 +4228,17 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
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
 
@@ -4667,7 +4670,7 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *device)
 {
-	uint8_t search_value[ATT_DEFAULT_LE_MTU];
+	uint8_t search_value[cmd_len];
 	size_t search_vlen;
 	uint16_t start, end;
 	uint16_t handle;
@@ -4725,7 +4728,7 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4740,7 +4743,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	uint16_t handle;
 	uint16_t len;
 	size_t vlen;
@@ -4759,7 +4762,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *dev)
 {
-	uint8_t value[ATT_DEFAULT_LE_MTU];
+	uint8_t value[cmd_len];
 	uint16_t handle;
 	uint16_t offset;
 	uint16_t len;
@@ -5141,9 +5144,10 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
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
@@ -5151,6 +5155,8 @@ static void gatt_srvc_change_register_cb(uint16_t handle, uint16_t offset,
 		return;
 	}
 
+	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
+
 	/* TODO handle CCC */
 
 	/* Set services changed notification flag */
-- 
1.9.3

