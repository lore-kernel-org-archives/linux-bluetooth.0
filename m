Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android: Fix using plain integer as NULL pointer
Date: Tue,  1 Jul 2014 15:50:39 +0300
Message-Id: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/gatt.c          |  2 +-
 android/hal-a2dp.c      |  4 +--
 android/hal-avrcp.c     | 34 +++++++++++------------
 android/hal-bluetooth.c | 53 +++++++++++++++++-------------------
 android/hal-gatt.c      | 72 ++++++++++++++++++++++++-------------------------
 android/hal-handsfree.c | 32 +++++++++++-----------
 android/hal-health.c    | 10 +++----
 android/hal-hidhost.c   | 22 +++++++--------
 android/hal-pan.c       | 10 +++----
 android/handsfree.c     | 18 ++++++-------
 10 files changed, 127 insertions(+), 130 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 406f10c..9c2b5dc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1553,7 +1553,7 @@ static struct gatt_app *register_app(const uint8_t *uuid, gatt_type_t type)
 	app = new0(struct gatt_app, 1);
 	if (!app) {
 		error("gatt: Cannot allocate memory for registering app");
-		return 0;
+		return NULL;
 	}
 
 	app->type = type;
diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 87aebde..7d3a651 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -108,7 +108,7 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
@@ -132,7 +132,7 @@ static void cleanup()
 	cmd.service_id = HAL_SERVICE_ID_A2DP;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_A2DP);
 }
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 09f5463..51ab7da 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -225,7 +225,7 @@ static bt_status_t init(btrc_callbacks_t *callbacks)
 	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
@@ -250,7 +250,7 @@ static bt_status_t get_play_status_rsp(btrc_play_status_t status,
 	cmd.position = song_pos;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAY_STATUS,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t list_player_app_attr_rsp(int num_attr,
@@ -277,7 +277,7 @@ static bt_status_t list_player_app_attr_rsp(int num_attr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_LIST_PLAYER_ATTRS,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
@@ -304,7 +304,7 @@ static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_LIST_PLAYER_VALUES,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
@@ -338,7 +338,7 @@ static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_GET_PLAYER_ATTRS,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static int write_text(uint8_t *ptr, uint8_t id, uint8_t *text, size_t *len)
@@ -405,7 +405,7 @@ static bt_status_t get_player_app_attr_text_rsp(int num_attr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_player_app_value_text_rsp(int num_val,
@@ -430,7 +430,7 @@ static bt_status_t get_player_app_value_text_rsp(int num_val,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static uint8_t write_element_attr_text(uint8_t *ptr, uint8_t num_attr,
@@ -471,7 +471,7 @@ static bt_status_t get_element_attr_rsp(uint8_t num_attr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t set_player_app_value_rsp(btrc_status_t rsp_status)
@@ -487,7 +487,7 @@ static bt_status_t set_player_app_value_rsp(btrc_status_t rsp_status)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t play_status_changed_rsp(btrc_notification_type_t type,
@@ -506,7 +506,7 @@ static bt_status_t play_status_changed_rsp(btrc_notification_type_t type,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t track_change_rsp(btrc_notification_type_t type,
@@ -525,7 +525,7 @@ static bt_status_t track_change_rsp(btrc_notification_type_t type,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t track_reached_end_rsp(btrc_notification_type_t type)
@@ -538,7 +538,7 @@ static bt_status_t track_reached_end_rsp(btrc_notification_type_t type)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t track_reached_start_rsp(btrc_notification_type_t type)
@@ -551,7 +551,7 @@ static bt_status_t track_reached_start_rsp(btrc_notification_type_t type)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t play_pos_changed_rsp(btrc_notification_type_t type,
@@ -570,7 +570,7 @@ static bt_status_t play_pos_changed_rsp(btrc_notification_type_t type,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t settings_changed_rsp(btrc_notification_type_t type,
@@ -600,7 +600,7 @@ static bt_status_t settings_changed_rsp(btrc_notification_type_t type,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
 					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t register_notification_rsp(btrc_event_id_t event_id,
@@ -642,7 +642,7 @@ static bt_status_t set_volume(uint8_t volume)
 	cmd.value = volume;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_VOLUME,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static void cleanup()
@@ -659,7 +659,7 @@ static void cleanup()
 	cmd.service_id = HAL_SERVICE_ID_AVRCP;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_AVRCP);
 }
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4291430..44eddbd 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -475,8 +475,8 @@ static int enable(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, 0, NULL, 0,
-								NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_ENABLE, 0, NULL,
+							NULL, NULL, NULL);
 }
 
 static int disable(void)
@@ -486,8 +486,8 @@ static int disable(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, 0, NULL, 0,
-								NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DISABLE, 0, NULL,
+							NULL, NULL, NULL);
 }
 
 static void cleanup(void)
@@ -512,7 +512,7 @@ static int get_adapter_properties(void)
 		return BT_STATUS_NOT_READY;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROPS,
-						0, NULL, 0, NULL, NULL);
+						0, NULL, NULL, NULL, NULL);
 }
 
 static int get_adapter_property(bt_property_type_t type)
@@ -528,7 +528,7 @@ static int get_adapter_property(bt_property_type_t type)
 	cmd.type = type;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_ADAPTER_PROP,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int set_adapter_property(const bt_property_t *property)
@@ -547,7 +547,7 @@ static int set_adapter_property(const bt_property_t *property)
 	len = sizeof(*cmd) + cmd->len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SET_ADAPTER_PROP,
-						len, cmd, 0, NULL, NULL);
+						len, cmd, NULL, NULL, NULL);
 }
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
@@ -563,7 +563,7 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
 					HAL_OP_GET_REMOTE_DEVICE_PROPS,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
@@ -584,7 +584,7 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
 					HAL_OP_GET_REMOTE_DEVICE_PROP,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
@@ -611,7 +611,7 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
 					HAL_OP_SET_REMOTE_DEVICE_PROP,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
@@ -628,7 +628,7 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
 					HAL_OP_GET_REMOTE_SERVICE_REC,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
@@ -642,9 +642,8 @@ static int get_remote_services(bt_bdaddr_t *remote_addr)
 
 	memcpy(cmd.bdaddr, remote_addr, sizeof(cmd.bdaddr));
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
-			HAL_OP_GET_REMOTE_SERVICES, sizeof(cmd), &cmd, 0,
-			NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_GET_REMOTE_SERVICES,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int start_discovery(void)
@@ -654,9 +653,8 @@ static int start_discovery(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
-				HAL_OP_START_DISCOVERY, 0, NULL, 0,
-				NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY, 0,
+						NULL, NULL, NULL, NULL);
 }
 
 static int cancel_discovery(void)
@@ -666,9 +664,8 @@ static int cancel_discovery(void)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH,
-				HAL_OP_CANCEL_DISCOVERY, 0, NULL, 0,
-				NULL, NULL);
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_DISCOVERY, 0,
+						NULL, NULL, NULL, NULL);
 }
 
 static int create_bond(const bt_bdaddr_t *bd_addr)
@@ -683,7 +680,7 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int cancel_bond(const bt_bdaddr_t *bd_addr)
@@ -698,7 +695,7 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int remove_bond(const bt_bdaddr_t *bd_addr)
@@ -713,7 +710,7 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
@@ -732,7 +729,7 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 	memcpy(cmd.pin_code, pin_code, sizeof(cmd.pin_code));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_PIN_REPLY,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
@@ -752,7 +749,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 	cmd.passkey = passkey;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SSP_REPLY,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static const void *get_profile_interface(const char *profile_id)
@@ -801,7 +798,7 @@ static int dut_mode_configure(uint8_t enable)
 	cmd.enable = enable;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
@@ -822,7 +819,7 @@ static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
 	len = sizeof(*cmd) + cmd->len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_SEND,
-						len, cmd, 0, NULL, NULL);
+						len, cmd, NULL, NULL, NULL);
 }
 
 static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
@@ -843,7 +840,7 @@ static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t buf_len)
 	len = sizeof(*cmd) + cmd->len;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_LE_TEST_MODE,
-						len, cmd, 0, NULL, NULL);
+						len, cmd, NULL, NULL, NULL);
 }
 
 static int config_hci_snoop_log(uint8_t enable)
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index c22113f..1cc4897 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -579,7 +579,7 @@ static bt_status_t register_client(bt_uuid_t *uuid)
 	memcpy(cmd.uuid, uuid, sizeof(*uuid));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t unregister_client(int client_if)
@@ -592,7 +592,7 @@ static bt_status_t unregister_client(int client_if)
 	cmd.client_if = client_if;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_UNREGISTER,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t scan(int client_if, bool start)
@@ -606,7 +606,7 @@ static bt_status_t scan(int client_if, bool start)
 	cmd.start = start;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SCAN,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
@@ -623,7 +623,7 @@ static bt_status_t connect(int client_if, const bt_bdaddr_t *bd_addr,
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t disconnect(int client_if, const bt_bdaddr_t *bd_addr,
@@ -640,7 +640,7 @@ static bt_status_t disconnect(int client_if, const bt_bdaddr_t *bd_addr,
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_DISCONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t listen(int client_if, bool start)
@@ -654,7 +654,7 @@ static bt_status_t listen(int client_if, bool start)
 	cmd.start = start;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_LISTEN,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t refresh(int client_if, const bt_bdaddr_t *bd_addr)
@@ -669,7 +669,7 @@ static bt_status_t refresh(int client_if, const bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REFRESH,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t search_service(int conn_id, bt_uuid_t *filter_uuid)
@@ -693,7 +693,7 @@ static bt_status_t search_service(int conn_id, bt_uuid_t *filter_uuid)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_SEARCH_SERVICE,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_included_service(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -719,7 +719,7 @@ static bt_status_t get_included_service(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -745,7 +745,7 @@ static bt_status_t get_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -773,7 +773,7 @@ static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
-					len, cmd, 0 , NULL, NULL);
+					len, cmd, NULL , NULL, NULL);
 }
 
 static bt_status_t read_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -793,7 +793,7 @@ static bt_status_t read_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t write_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -820,7 +820,7 @@ static bt_status_t write_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC,
-					cmd_len, cmd, 0, NULL, NULL);
+					cmd_len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t read_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -842,7 +842,7 @@ static bt_status_t read_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_READ_DESCRIPTOR,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t write_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -871,7 +871,7 @@ static bt_status_t write_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_WRITE_DESCRIPTOR,
-					cmd_len, cmd, 0, NULL, NULL);
+					cmd_len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t execute_write(int conn_id, int execute)
@@ -886,7 +886,7 @@ static bt_status_t execute_write(int conn_id, int execute)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_EXECUTE_WRITE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t register_for_notification(int client_if,
@@ -908,7 +908,7 @@ static bt_status_t register_for_notification(int client_if,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
-				sizeof(cmd), &cmd, 0, NULL, NULL);
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t deregister_for_notification(int client_if,
@@ -930,7 +930,7 @@ static bt_status_t deregister_for_notification(int client_if,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION,
-				sizeof(cmd), &cmd, 0, NULL, NULL);
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t read_remote_rssi(int client_if, const bt_bdaddr_t *bd_addr)
@@ -946,7 +946,7 @@ static bt_status_t read_remote_rssi(int client_if, const bt_bdaddr_t *bd_addr)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_READ_REMOTE_RSSI,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int get_device_type(const bt_bdaddr_t *bd_addr)
@@ -1022,7 +1022,7 @@ static bt_status_t set_adv_data_real(int server_if, bool set_scan_rsp,
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SET_ADV_DATA,
-						cmd_len, cmd, 0, NULL, NULL);
+						cmd_len, cmd, NULL, NULL, NULL);
 }
 
 /*
@@ -1079,7 +1079,7 @@ static bt_status_t test_command(int command, btgatt_test_params_t *params)
 	cmd.u5 = params->u5;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_TEST_COMMAND,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 /* Server API */
@@ -1094,7 +1094,7 @@ static bt_status_t register_server(bt_uuid_t *uuid)
 	memcpy(cmd.uuid, uuid, sizeof(*uuid));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_REGISTER,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t unregister_server(int server_if)
@@ -1107,7 +1107,7 @@ static bt_status_t unregister_server(int server_if)
 	cmd.server_if = server_if;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_UNREGISTER,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
@@ -1124,7 +1124,7 @@ static bt_status_t server_connect(int server_if, const bt_bdaddr_t *bd_addr,
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_CONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t server_disconnect(int server_if, const bt_bdaddr_t *bd_addr,
@@ -1141,7 +1141,7 @@ static bt_status_t server_disconnect(int server_if, const bt_bdaddr_t *bd_addr,
 	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_DISCONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t add_service(int server_if, btgatt_srvc_id_t *srvc_id,
@@ -1158,7 +1158,7 @@ static bt_status_t add_service(int server_if, btgatt_srvc_id_t *srvc_id,
 	srvc_id_to_hal(&cmd.srvc_id, srvc_id);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_ADD_SERVICE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t add_included_service(int server_if, int service_handle,
@@ -1175,7 +1175,7 @@ static bt_status_t add_included_service(int server_if, int service_handle,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_ADD_INC_SERVICE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t add_characteristic(int server_if, int service_handle,
@@ -1196,7 +1196,7 @@ static bt_status_t add_characteristic(int server_if, int service_handle,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_ADD_CHARACTERISTIC,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t add_descriptor(int server_if, int service_handle,
@@ -1215,7 +1215,7 @@ static bt_status_t add_descriptor(int server_if, int service_handle,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_ADD_DESCRIPTOR,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t start_service(int server_if, int service_handle,
@@ -1232,7 +1232,7 @@ static bt_status_t start_service(int server_if, int service_handle,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_START_SERVICE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t stop_service(int server_if, int service_handle)
@@ -1246,7 +1246,7 @@ static bt_status_t stop_service(int server_if, int service_handle)
 	cmd.service_handle = service_handle;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_SERVER_STOP_SERVICE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t delete_service(int server_if, int service_handle)
@@ -1261,7 +1261,7 @@ static bt_status_t delete_service(int server_if, int service_handle)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_DELETE_SERVICE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t send_indication(int server_if, int attribute_handle,
@@ -1285,7 +1285,7 @@ static bt_status_t send_indication(int server_if, int attribute_handle,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_SEND_INDICATION,
-					cmd_len, cmd, 0, NULL, NULL);
+					cmd_len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t send_response(int conn_id, int trans_id, int status,
@@ -1312,7 +1312,7 @@ static bt_status_t send_response(int conn_id, int trans_id, int status,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_SEND_RESPONSE,
-					cmd_len, cmd, 0, NULL, NULL);
+					cmd_len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t init(const btgatt_callbacks_t *callbacks)
@@ -1334,7 +1334,7 @@ static bt_status_t init(const btgatt_callbacks_t *callbacks)
 	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
@@ -1358,7 +1358,7 @@ static void cleanup(void)
 	cmd.service_id = HAL_SERVICE_ID_GATT;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_GATT);
 }
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 1d9a1a2..0f5e1d7 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -245,7 +245,7 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 	cmd.mode = get_mode();
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
@@ -270,7 +270,7 @@ static bt_status_t handsfree_connect(bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_CONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
@@ -289,7 +289,7 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_DISCONNECT, sizeof(cmd), &cmd,
-				0, NULL, NULL);
+				NULL, NULL, NULL);
 }
 
 static bt_status_t connect_audio(bt_bdaddr_t *bd_addr)
@@ -308,7 +308,7 @@ static bt_status_t connect_audio(bt_bdaddr_t *bd_addr)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_CONNECT_AUDIO, sizeof(cmd),
-				&cmd, 0, NULL, NULL);
+				&cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
@@ -327,7 +327,7 @@ static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_DISCONNECT_AUDIO, sizeof(cmd),
-				&cmd, 0, NULL, NULL);
+				&cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t start_voice_recognition(void)
@@ -338,7 +338,7 @@ static bt_status_t start_voice_recognition(void)
 		return BT_STATUS_NOT_READY;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_START_VR,
-							0, NULL, 0, NULL, NULL);
+						0, NULL, NULL, NULL, NULL);
 }
 
 static bt_status_t stop_voice_recognition(void)
@@ -349,7 +349,7 @@ static bt_status_t stop_voice_recognition(void)
 		return BT_STATUS_NOT_READY;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_STOP_VR,
-							0, NULL, 0, NULL, NULL);
+						0, NULL, NULL, NULL, NULL);
 }
 
 static bt_status_t volume_control(bthf_volume_type_t type, int volume)
@@ -366,7 +366,7 @@ static bt_status_t volume_control(bthf_volume_type_t type, int volume)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 				HAL_OP_HANDSFREE_VOLUME_CONTROL, sizeof(cmd),
-				&cmd, 0, NULL, NULL);
+				&cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t device_status_notification(bthf_network_state_t state,
@@ -387,7 +387,7 @@ static bt_status_t device_status_notification(bthf_network_state_t state,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t cops_response(const char *cops)
@@ -411,7 +411,7 @@ static bt_status_t cops_response(const char *cops)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 						HAL_OP_HANDSFREE_COPS_RESPONSE,
-						len, cmd, 0, NULL, NULL);
+						len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t cind_response(int svc, int num_active, int num_held,
@@ -435,7 +435,7 @@ static bt_status_t cind_response(int svc, int num_active, int num_held,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_CIND_RESPONSE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t formatted_at_response(const char *rsp)
@@ -459,7 +459,7 @@ static bt_status_t formatted_at_response(const char *rsp)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t at_response(bthf_at_response_t response, int error)
@@ -476,7 +476,7 @@ static bt_status_t at_response(bthf_at_response_t response, int error)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_AT_RESPONSE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
@@ -513,7 +513,7 @@ static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 						HAL_OP_HANDSFREE_CLCC_RESPONSE,
-						len, cmd, 0, NULL, NULL);
+						len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t phone_state_change(int num_active, int num_held,
@@ -546,7 +546,7 @@ static bt_status_t phone_state_change(int num_active, int num_held,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_PHONE_STATE_CHANGE,
-					len, cmd, 0, NULL, NULL);
+					len, cmd, NULL, NULL, NULL);
 }
 
 static void cleanup(void)
@@ -563,7 +563,7 @@ static void cleanup(void)
 	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
 }
diff --git a/android/hal-health.c b/android/hal-health.c
index 858d499..20ba459 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -139,7 +139,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 
 		status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
 						sizeof(*mdep) + mdep->descr_len,
-						buf, 0, NULL, NULL);
+						buf, NULL, NULL, NULL);
 
 		if (status != BT_STATUS_SUCCESS)
 			return status;
@@ -162,7 +162,7 @@ static bt_status_t unregister_application(int app_id)
 	cmd.app_id = app_id;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_UNREG_APP,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t connect_channel(int app_id, bt_bdaddr_t *bd_addr,
@@ -208,7 +208,7 @@ static bt_status_t destroy_channel(int channel_id)
 	cmd.channel_id = channel_id;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_DESTROY_CHANNEL,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t init(bthl_callbacks_t *callbacks)
@@ -231,7 +231,7 @@ static bt_status_t init(bthl_callbacks_t *callbacks)
 	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbacks = NULL;
@@ -255,7 +255,7 @@ static void cleanup(void)
 	cmd.service_id = HAL_SERVICE_ID_HEALTH;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_HEALTH);
 }
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 949e2a0..31997e2 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -137,7 +137,7 @@ static bt_status_t hidhost_connect(bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_CONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
@@ -155,7 +155,7 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_DISCONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t virtual_unplug(bt_bdaddr_t *bd_addr)
@@ -174,7 +174,7 @@ static bt_status_t virtual_unplug(bt_bdaddr_t *bd_addr)
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
 					HAL_OP_HIDHOST_VIRTUAL_UNPLUG,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
@@ -200,7 +200,7 @@ static bt_status_t set_info(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info)
 	memcpy(cmd.descr, hid_info.dsc_list, cmd.descr_len);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_INFO,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_protocol(bt_bdaddr_t *bd_addr,
@@ -223,7 +223,7 @@ static bt_status_t get_protocol(bt_bdaddr_t *bd_addr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
 				HAL_OP_HIDHOST_GET_PROTOCOL,
-				sizeof(cmd), &cmd, 0, NULL, NULL);
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t set_protocol(bt_bdaddr_t *bd_addr,
@@ -246,7 +246,7 @@ static bt_status_t set_protocol(bt_bdaddr_t *bd_addr,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
 				HAL_OP_HIDHOST_SET_PROTOCOL,
-				sizeof(cmd), &cmd, 0, NULL, NULL);
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t get_report(bt_bdaddr_t *bd_addr,
@@ -272,7 +272,7 @@ static bt_status_t get_report(bt_bdaddr_t *bd_addr,
 	cmd.type = report_type;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_GET_REPORT,
-			sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t set_report(bt_bdaddr_t *bd_addr,
@@ -298,7 +298,7 @@ static bt_status_t set_report(bt_bdaddr_t *bd_addr,
 	cmd->type = report_type;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SET_REPORT,
-				sizeof(*cmd) + cmd->len, buf, 0, NULL, NULL);
+				sizeof(*cmd) + cmd->len, buf, NULL, NULL, NULL);
 }
 
 static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
@@ -319,7 +319,7 @@ static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 	memcpy(cmd->data, data, cmd->len);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HIDHOST_SEND_DATA,
-				sizeof(*cmd) + cmd->len, buf, 0, NULL, NULL);
+			sizeof(*cmd) + cmd->len, buf, NULL, NULL, NULL);
 }
 
 static bt_status_t init(bthh_callbacks_t *callbacks)
@@ -342,7 +342,7 @@ static bt_status_t init(bthh_callbacks_t *callbacks)
 	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbacks = NULL;
@@ -366,7 +366,7 @@ static void cleanup(void)
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_HIDHOST);
 }
diff --git a/android/hal-pan.c b/android/hal-pan.c
index d3f93ff..0f71ef6 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -83,7 +83,7 @@ static bt_status_t pan_enable(int local_role)
 	cmd.local_role = local_role;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static int pan_get_local_role(void)
@@ -120,7 +120,7 @@ static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 	cmd.remote_role = remote_role;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_CONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t pan_disconnect(const bt_bdaddr_t *bd_addr)
@@ -135,7 +135,7 @@ static bt_status_t pan_disconnect(const bt_bdaddr_t *bd_addr)
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_DISCONNECT,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
@@ -157,7 +157,7 @@ static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
@@ -181,7 +181,7 @@ static void pan_cleanup(void)
 	cmd.service_id = HAL_SERVICE_ID_PAN;
 
 	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 
 	hal_ipc_unregister(HAL_SERVICE_ID_PAN);
 }
diff --git a/android/handsfree.c b/android/handsfree.c
index 7ca0ba8..599f16f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2263,34 +2263,34 @@ static sdp_record_t *headset_ag_record(void)
 	}
 
 	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(0, &root_uuid);
+	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(record, root);
 
 	sdp_uuid16_create(&svclass_uuid, HEADSET_AGW_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &svclass_uuid);
+	svclass_id = sdp_list_append(NULL, &svclass_uuid);
 	sdp_uuid16_create(&ga_svclass_uuid, GENERIC_AUDIO_SVCLASS_ID);
 	svclass_id = sdp_list_append(svclass_id, &ga_svclass_uuid);
 	sdp_set_service_classes(record, svclass_id);
 
 	sdp_uuid16_create(&profile.uuid, HEADSET_PROFILE_ID);
 	profile.version = 0x0102;
-	pfseq = sdp_list_append(0, &profile);
+	pfseq = sdp_list_append(NULL, &profile);
 	sdp_set_profile_descs(record, pfseq);
 
 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap_uuid);
-	apseq = sdp_list_append(0, proto[0]);
+	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
+	apseq = sdp_list_append(NULL, proto[0]);
 
 	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
-	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
 	channel = sdp_data_alloc(SDP_UINT8, &ch);
 	proto[1] = sdp_list_append(proto[1], channel);
 	apseq = sdp_list_append(apseq, proto[1]);
 
-	aproto = sdp_list_append(0, apseq);
+	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	sdp_set_info_attr(record, "Voice Gateway", 0, 0);
+	sdp_set_info_attr(record, "Voice Gateway", NULL, NULL);
 
 	sdp_attr_add(record, SDP_ATTR_EXTERNAL_NETWORK, network);
 
@@ -2441,7 +2441,7 @@ static sdp_record_t *hfp_ag_record(void)
 	sdp_set_profile_descs(record, pfseq);
 
 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
 	apseq = sdp_list_append(NULL, proto[0]);
 
 	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
-- 
1.9.3

