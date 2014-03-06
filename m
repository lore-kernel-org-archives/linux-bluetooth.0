Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/hal-gatt: Add Client API calls
Date: Thu,  6 Mar 2014 12:27:57 +0100
Message-Id: <1394105279-9165-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394105279-9165-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send API calls data using IPC.
---
 android/hal-gatt.c | 308 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 287 insertions(+), 21 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index ce59f96..83b6303 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -21,7 +21,9 @@
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
+#include "ipc-common.h"
 #include "hal-ipc.h"
+#include "hal-utils.h"
 
 static const btgatt_callbacks_t *cbs = NULL;
 
@@ -37,6 +39,12 @@ static void gatt_id_from_hal(btgatt_gatt_id_t *to,
 	to->inst_id = from->inst_id;
 }
 
+static void gatt_id_to_hal(struct hal_gatt_gatt_id *to, btgatt_gatt_id_t *from)
+{
+	memcpy(to->uuid, &from->uuid, sizeof(from->uuid));
+	to->inst_id = from->inst_id;
+}
+
 static void srvc_id_from_hal(btgatt_srvc_id_t *to,
 						struct hal_gatt_srvc_id *from)
 {
@@ -45,6 +53,13 @@ static void srvc_id_from_hal(btgatt_srvc_id_t *to,
 	to->is_primary = from->is_primary;
 }
 
+static void srvc_id_to_hal(struct hal_gatt_srvc_id *to, btgatt_srvc_id_t *from)
+{
+	memcpy(to->uuid, &from->id.uuid, sizeof(from->id.uuid));
+	to->inst_id = from->id.inst_id;
+	to->is_primary = from->is_primary;
+}
+
 /* Client Event Handlers */
 
 static void handle_register_client(void *buf, uint16_t len)
@@ -429,70 +444,196 @@ static const struct hal_ipc_handler ev_handlers[] = {
 
 static bt_status_t register_client(bt_uuid_t *uuid)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_register cmd;
+
+	memcpy(cmd.uuid, uuid, sizeof(*uuid));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t unregister_client(int client_if)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_unregister cmd;
+
+	cmd.client_if = client_if;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_UNREGISTER,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t scan(int client_if, bool start)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_scan cmd;
+
+	cmd.client_if = client_if;
+	cmd.start = start;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SCAN,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
 								bool is_direct)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_connect cmd;
+
+	cmd.client_if = client_if;
+	cmd.is_direct = is_direct;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t disconnect(int client_if, const bt_bdaddr_t *bd_addr,
 								int conn_id)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_disconnect cmd;
+
+	cmd.client_if = client_if;
+	cmd.conn_id = conn_id;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_DISCONNECT,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t listen(int client_if, bool start)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_listen cmd;
+
+	cmd.client_if = client_if;
+	cmd.start = start;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_LISTEN,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t refresh(int client_if, const bt_bdaddr_t *bd_addr)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_refresh cmd;
+
+	cmd.client_if = client_if;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REFRESH,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t search_service(int conn_id, bt_uuid_t *filter_uuid)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_search_service *cmd = (void *) buf;
+	size_t len = sizeof(*cmd);
+
+	memset(cmd, 0, sizeof(*cmd));
+
+	cmd->conn_id = conn_id;
+
+	if (filter_uuid) {
+		memcpy(cmd->filter_uuid, filter_uuid, sizeof(*filter_uuid));
+		len += sizeof(*filter_uuid);
+		cmd->number = 1;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SEARCH_SERVICE,
+					len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t get_included_service(int conn_id, btgatt_srvc_id_t *srvc_id,
 					btgatt_srvc_id_t *start_incl_srvc_id)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_get_included_service *cmd = (void *) buf;
+	size_t len = sizeof(*cmd);
+
+	cmd->conn_id = conn_id;
+
+	srvc_id_to_hal(&cmd->srvc_id[0], srvc_id);
+	len += sizeof(cmd->srvc_id[0]);
+	cmd->number = 1;
+
+	if (start_incl_srvc_id) {
+		srvc_id_to_hal(&cmd->srvc_id[1], start_incl_srvc_id);
+		len += sizeof(cmd->srvc_id[1]);
+		cmd->number++;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
+					len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t get_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 						btgatt_gatt_id_t *start_char_id)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_get_characteristic *cmd = (void *) buf;
+	size_t len = sizeof(*cmd);
+
+	cmd->conn_id = conn_id;
+
+	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
+	len += sizeof(cmd->srvc_id);
+
+	if (start_char_id) {
+		gatt_id_to_hal(&cmd->gatt_id[0], start_char_id);
+		len += sizeof(cmd->gatt_id[0]);
+		cmd->number = 1;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC,
+					len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 					btgatt_gatt_id_t *char_id,
 					btgatt_gatt_id_t *start_descr_id)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_get_descriptor *cmd = (void *) buf;
+	size_t len = sizeof(*cmd);
+
+	cmd->conn_id = conn_id;
+
+	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
+
+	gatt_id_to_hal(&cmd->gatt_id[0], char_id);
+	len += sizeof(cmd->gatt_id[0]);
+	cmd->number = 1;
+
+	if (start_descr_id) {
+		gatt_id_to_hal(&cmd->gatt_id[1], char_id);
+		len += sizeof(cmd->gatt_id[1]);
+		cmd->number++;
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
+					len, &cmd, 0 , NULL, NULL);
 }
 
 static bt_status_t read_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 					btgatt_gatt_id_t *char_id,
 					int auth_req)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_read_characteristic cmd;
+
+	cmd.conn_id = conn_id;
+	cmd.auth_req = auth_req;
+
+	srvc_id_to_hal(&cmd.srvc_id, srvc_id);
+	gatt_id_to_hal(&cmd.gatt_id, char_id);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t write_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -500,7 +641,23 @@ static bt_status_t write_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 					int write_type, int len, int auth_req,
 					char *p_value)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_write_characteristic *cmd = (void *) buf;
+	size_t cmd_len = sizeof(*cmd) + len;
+
+	cmd->conn_id = conn_id;
+	cmd->write_type = write_type;
+	cmd->len = len;
+	cmd->auth_req = auth_req;
+
+	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
+	gatt_id_to_hal(&cmd->gatt_id, char_id);
+
+	memcpy(cmd->value, p_value, len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC,
+					cmd_len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t read_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -508,6 +665,19 @@ static bt_status_t read_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 						btgatt_gatt_id_t *descr_id,
 						int auth_req)
 {
+	struct hal_cmd_gatt_client_read_descriptor cmd;
+
+	cmd.conn_id = conn_id;
+	cmd.auth_req = auth_req;
+
+	srvc_id_to_hal(&cmd.srvc_id, srvc_id);
+	gatt_id_to_hal(&cmd.char_id, char_id);
+	gatt_id_to_hal(&cmd.descr_id, descr_id);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_READ_DESCRIPTOR,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
 	return BT_STATUS_UNSUPPORTED;
 }
 
@@ -517,12 +687,36 @@ static bt_status_t write_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 					int write_type, int len, int auth_req,
 					char *p_value)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_write_descriptor *cmd = (void *) buf;
+	size_t cmd_len = sizeof(*cmd) + len;
+
+	cmd->conn_id = conn_id;
+	cmd->write_type = write_type;
+	cmd->len = len;
+	cmd->auth_req = auth_req;
+
+	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
+	gatt_id_to_hal(&cmd->char_id, char_id);
+	gatt_id_to_hal(&cmd->descr_id, descr_id);
+
+	memcpy(cmd->value, p_value, len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_WRITE_DESCRIPTOR,
+					cmd_len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t execute_write(int conn_id, int execute)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_execute_write cmd;
+
+	cmd.conn_id = conn_id;
+	cmd.execute = execute;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_EXECUTE_WRITE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t register_for_notification(int client_if,
@@ -530,7 +724,18 @@ static bt_status_t register_for_notification(int client_if,
 						btgatt_srvc_id_t *srvc_id,
 						btgatt_gatt_id_t *char_id)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_register_for_notification cmd;
+
+	cmd.client_if = client_if;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	srvc_id_to_hal(&cmd.srvc_id, srvc_id);
+	gatt_id_to_hal(&cmd.char_id, char_id);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
+				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t deregister_for_notification(int client_if,
@@ -538,17 +743,48 @@ static bt_status_t deregister_for_notification(int client_if,
 						btgatt_srvc_id_t *srvc_id,
 						btgatt_gatt_id_t *char_id)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_deregister_for_notification cmd;
+
+	cmd.client_if = client_if;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	srvc_id_to_hal(&cmd.srvc_id, srvc_id);
+	gatt_id_to_hal(&cmd.char_id, char_id);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION,
+				sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bt_status_t read_remote_rssi(int client_if, const bt_bdaddr_t *bd_addr)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_read_remote_rssi cmd;
+
+	cmd.client_if = client_if;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_READ_REMOTE_RSSI,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int get_device_type(const bt_bdaddr_t *bd_addr)
 {
-	return 0;
+	struct hal_cmd_gatt_client_get_device_type cmd;
+	uint8_t dev_type = 0;
+	size_t resp_len = sizeof(dev_type);
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_GET_DEVICE_TYPE,
+			sizeof(cmd), &cmd, &resp_len, &dev_type, NULL);
+
+	if (resp_len != sizeof(dev_type))
+		return 0;
+
+	return dev_type;
 }
 
 static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
@@ -557,12 +793,42 @@ static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
 				int appearance, uint16_t manufacturer_len,
 				char *manufacturer_data)
 {
-	return BT_STATUS_UNSUPPORTED;
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_set_adv_data *cmd = (void *) buf;
+	size_t cmd_len = sizeof(*cmd) + manufacturer_len;
+
+	cmd->server_if = server_if;
+	cmd->set_scan_rsp = set_scan_rsp;
+	cmd->include_name = include_name;
+	cmd->include_txpower = include_txpower;
+	cmd->min_interval = min_interval;
+	cmd->max_interval = max_interval;
+	cmd->appearance = appearance;
+	cmd->manufacturer_len = manufacturer_len;
+
+	memcpy(cmd->manufacturer_data, manufacturer_data, manufacturer_len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SET_ADV_DATA,
+						cmd_len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t test_command(int command, btgatt_test_params_t *params)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_gatt_client_test_command cmd;
+
+	cmd.command = command;
+
+	memcpy(cmd.bda1, params->bda1, sizeof(*params->bda1));
+	memcpy(cmd.uuid1, params->uuid1, sizeof(*params->uuid1));
+
+	cmd.u1 = params->u1;
+	cmd.u2 = params->u2;
+	cmd.u3 = params->u3;
+	cmd.u4 = params->u4;
+	cmd.u5 = params->u5;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_TEST_COMMAND,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 /* Server API */
-- 
1.9.0

