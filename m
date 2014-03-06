Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/hal-gatt: Add Server API calls
Date: Thu,  6 Mar 2014 12:27:59 +0100
Message-Id: <1394105279-9165-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send API calls data using IPC.
---
 android/hal-gatt.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 130 insertions(+), 12 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 37c0191..065c2f8 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -903,72 +903,189 @@ static bt_status_t test_command(int command, btgatt_test_params_t *params)
 
 static bt_status_t register_server(bt_uuid_t *uuid)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_register cmd;
+
+	memcpy(cmd.uuid, uuid, sizeof(*uuid));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_REGISTER,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t unregister_server(int server_if)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_unregister cmd;
+
+	cmd.server_if = server_if;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_UNREGISTER,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
 								bool is_direct)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_connect cmd;
+
+	cmd.server_if = server_if;
+	cmd.is_direct = is_direct;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_CONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t server_disconnect(int server_if, const bt_bdaddr_t *bd_addr,
+								int conn_id)
+{
+	struct hal_cmd_gatt_server_disconnect cmd;
+
+	cmd.server_if = server_if;
+	cmd.conn_id = conn_id;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_DISCONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t add_service(int server_if, btgatt_srvc_id_t *srvc_id,
 								int num_handles)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_add_service cmd;
+
+	cmd.server_if = server_if;
+	cmd.num_handles = num_handles;
+
+	srvc_id_to_hal(&cmd.srvc_id, srvc_id);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_ADD_SERVICE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t add_included_service(int server_if, int service_handle,
 						int included_handle)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_add_inc_service cmd;
+
+	cmd.server_if = server_if;
+	cmd.service_handle = service_handle;
+	cmd.included_handle = included_handle;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_ADD_INC_SERVICE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t add_characteristic(int server_if, int service_handle,
 						bt_uuid_t *uuid, int properties,
 						int permissions)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_add_characteristic cmd;
+
+	cmd.server_if = server_if;
+	cmd.service_handle = service_handle;
+	cmd.properties = properties;
+	cmd.permissions = permissions;
+
+	memcpy(cmd.uuid, uuid, sizeof(*uuid));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_ADD_CHARACTERISTIC,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t add_descriptor(int server_if, int service_handle,
 					bt_uuid_t *uuid, int permissions)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_add_descriptor cmd;
+
+	cmd.server_if = server_if;
+	cmd.service_handle = service_handle;
+	cmd.permissions = permissions;
+
+	memcpy(cmd.uuid, uuid, sizeof(*uuid));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_ADD_DESCRIPTOR,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t start_service(int server_if, int service_handle,
 								int transport)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_start_service cmd;
+
+	cmd.server_if = server_if;
+	cmd.service_handle = service_handle;
+	cmd.transport = transport;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_START_SERVICE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t stop_service(int server_if, int service_handle)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_stop_service cmd;
+
+	cmd.server_if = server_if;
+	cmd.service_handle = service_handle;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_STOP_SERVICE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t delete_service(int server_if, int service_handle)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_server_delete_service cmd;
+
+	cmd.server_if = server_if;
+	cmd.service_handle = service_handle;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_DELETE_SERVICE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t send_indication(int server_if, int attribute_handle,
 					int conn_id, int len, int confirm,
 					char *p_value)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_server_send_indication *cmd = (void *) buf;
+	size_t cmd_len = sizeof(*cmd) + len;
+
+	cmd->server_if = server_if;
+	cmd->attribute_handle = attribute_handle;
+	cmd->conn_id = conn_id;
+	cmd->len = len;
+	cmd->confirm = confirm;
+
+	memcpy(cmd->value, p_value, len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_SEND_INDICATION,
+					cmd_len, &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t send_response(int conn_id, int trans_id, int status,
 						btgatt_response_t *response)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_server_send_response *cmd = (void *) buf;
+	size_t cmd_len = sizeof(*cmd) + sizeof(*response);
+
+	cmd->conn_id = conn_id;
+	cmd->trans_id = trans_id;
+	cmd->status = status;
+	cmd->len = sizeof(*response);
+
+	memcpy(cmd->data, response, sizeof(*response));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_SERVER_SEND_RESPONSE,
+					cmd_len, &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t init(const btgatt_callbacks_t *callbacks)
@@ -1047,6 +1164,7 @@ static btgatt_server_interface_t server_iface = {
 	.register_server = register_server,
 	.unregister_server = unregister_server,
 	.connect = server_connect,
+	.disconnect = server_disconnect,
 	.add_service = add_service,
 	.add_included_service = add_included_service,
 	.add_characteristic = add_characteristic,
-- 
1.9.0

