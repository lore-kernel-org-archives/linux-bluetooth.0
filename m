Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/5] android/tester: Rename and expose callback verification function
Date: Fri,  3 Oct 2014 15:08:39 +0200
Message-Id: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to verify action result on remotes side by using hciemu
hooks for example. As hooks are test specific, we need this to be
exposed to other testers.
---
 android/tester-main.c | 78 +++++++++++++++++++++++++--------------------------
 android/tester-main.h |  1 +
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index ddae668..5d66fe1 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -880,7 +880,7 @@ static gboolean verify_callback(gpointer user_data)
 	return FALSE;
 }
 
-static void schedule_callback_call(struct step *step)
+void schedule_callback_verification(struct step *step)
 {
 	g_atomic_int_inc(&scheduled_cbacks_num);
 	g_idle_add(verify_callback, step);
@@ -898,7 +898,7 @@ static void adapter_state_changed_cb(bt_state_t state)
 	step->callback_result.state = state;
 	step->callback = CB_BT_ADAPTER_STATE_CHANGED;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static bt_property_t *copy_properties(int num_properties,
@@ -954,7 +954,7 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 								properties);
 	step->callback = CB_BT_ADAPTER_PROPERTIES;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void discovery_state_changed_cb(bt_discovery_state_t state)
@@ -964,7 +964,7 @@ static void discovery_state_changed_cb(bt_discovery_state_t state)
 	step->callback = CB_BT_DISCOVERY_STATE_CHANGED;
 	step->callback_result.state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void device_found_cb(int num_properties, bt_property_t *properties)
@@ -977,7 +977,7 @@ static void device_found_cb(int num_properties, bt_property_t *properties)
 
 	step->callback = CB_BT_DEVICE_FOUND;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void remote_device_properties_cb(bt_status_t status,
@@ -992,7 +992,7 @@ static void remote_device_properties_cb(bt_status_t status,
 
 	step->callback = CB_BT_REMOTE_DEVICE_PROPERTIES;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void bond_state_changed_cb(bt_status_t status,
@@ -1012,7 +1012,7 @@ static void bond_state_changed_cb(bt_status_t status,
 
 	step->callback = CB_BT_BOND_STATE_CHANGED;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
@@ -1041,7 +1041,7 @@ static void pin_request_cb(bt_bdaddr_t *remote_bd_addr,
 	g_free(props[2]->val);
 	g_free(props[2]);
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
@@ -1072,7 +1072,7 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr,
 	g_free(props[2]->val);
 	g_free(props[2]);
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void acl_state_changed_cb(bt_status_t status,
@@ -1085,7 +1085,7 @@ static void acl_state_changed_cb(bt_status_t status,
 	step->callback_result.status = status;
 	step->callback_result.state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static bt_callbacks_t bt_callbacks = {
@@ -1112,7 +1112,7 @@ static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
 	step->callback = CB_HH_CONNECTION_STATE;
 	step->callback_result.state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
@@ -1122,7 +1122,7 @@ static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
 	step->callback = CB_HH_VIRTUAL_UNPLUG;
 	step->callback_result.status = status;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
@@ -1137,7 +1137,7 @@ static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
 
 	/* TODO: add bdaddr to verify? */
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
@@ -1146,7 +1146,7 @@ static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
 
 	step->callback = CB_HH_HID_INFO;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
@@ -1159,7 +1159,7 @@ static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
 	step->callback_result.status = status;
 	step->callback_result.report_size = size;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static bthh_callbacks_t bthh_callbacks = {
@@ -1181,7 +1181,7 @@ static void gattc_register_client_cb(int status, int client_if,
 
 	step->callback_result.status = status;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
@@ -1205,7 +1205,7 @@ static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
 	g_free(props[1]->val);
 	g_free(props[1]);
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_connect_cb(int conn_id, int status, int client_if,
@@ -1228,7 +1228,7 @@ static void gattc_connect_cb(int conn_id, int status, int client_if,
 	g_free(props[0]->val);
 	g_free(props[0]);
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_disconnect_cb(int conn_id, int status, int client_if,
@@ -1251,7 +1251,7 @@ static void gattc_disconnect_cb(int conn_id, int status, int client_if,
 	g_free(props[0]->val);
 	g_free(props[0]);
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_listen_cb(int status, int server_if)
@@ -1261,7 +1261,7 @@ static void gattc_listen_cb(int status, int server_if)
 	step->callback = CB_GATTC_LISTEN;
 	step->callback_result.status = status;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_search_result_cb(int conn_id, btgatt_srvc_id_t *srvc_id)
@@ -1272,7 +1272,7 @@ static void gattc_search_result_cb(int conn_id, btgatt_srvc_id_t *srvc_id)
 	step->callback_result.conn_id = conn_id;
 	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_search_complete_cb(int conn_id, int status)
@@ -1282,7 +1282,7 @@ static void gattc_search_complete_cb(int conn_id, int status)
 	step->callback = CB_GATTC_SEARCH_COMPLETE;
 	step->callback_result.conn_id = conn_id;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_get_characteristic_cb(int conn_id, int status,
@@ -1299,7 +1299,7 @@ static void gattc_get_characteristic_cb(int conn_id, int status,
 							sizeof(*char_id));
 	step->callback_result.char_prop = char_prop;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_get_descriptor_cb(int conn_id, int status,
@@ -1317,7 +1317,7 @@ static void gattc_get_descriptor_cb(int conn_id, int status,
 	step->callback_result.descriptor = g_memdup(descr_id,
 							sizeof(*descr_id));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_get_included_service_cb(int conn_id, int status,
@@ -1332,7 +1332,7 @@ static void gattc_get_included_service_cb(int conn_id, int status,
 	step->callback_result.included = g_memdup(incl_srvc_id,
 							sizeof(*srvc_id));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_read_characteristic_cb(int conn_id, int status,
@@ -1345,7 +1345,7 @@ static void gattc_read_characteristic_cb(int conn_id, int status,
 	step->callback_result.conn_id = conn_id;
 	step->callback_result.read_params = g_memdup(p_data, sizeof(*p_data));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_read_descriptor_cb(int conn_id, int status,
@@ -1358,7 +1358,7 @@ static void gattc_read_descriptor_cb(int conn_id, int status,
 	step->callback_result.conn_id = conn_id;
 	step->callback_result.read_params = g_memdup(p_data, sizeof(*p_data));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_write_characteristic_cb(int conn_id, int status,
@@ -1371,7 +1371,7 @@ static void gattc_write_characteristic_cb(int conn_id, int status,
 	step->callback_result.conn_id = conn_id;
 	step->callback_result.write_params = g_memdup(p_data, sizeof(*p_data));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_write_descriptor_cb(int conn_id, int status,
@@ -1384,7 +1384,7 @@ static void gattc_write_descriptor_cb(int conn_id, int status,
 	step->callback_result.conn_id = conn_id;
 	step->callback_result.write_params = g_memdup(p_data, sizeof(*p_data));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_register_for_notification_cb(int conn_id, int registered,
@@ -1402,7 +1402,7 @@ static void gattc_register_for_notification_cb(int conn_id, int registered,
 							sizeof(*char_id));
 	step->callback_result.notification_registered = registered;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gattc_notif_cb(int conn_id, btgatt_notify_params_t *p_data)
@@ -1413,7 +1413,7 @@ static void gattc_notif_cb(int conn_id, btgatt_notify_params_t *p_data)
 	step->callback_result.conn_id = conn_id;
 	step->callback_result.notify_params = g_memdup(p_data, sizeof(*p_data));
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gatts_register_server_cb(int status, int server_if,
@@ -1425,7 +1425,7 @@ static void gatts_register_server_cb(int status, int server_if,
 
 	step->callback_result.status = status;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void gatts_connection_cb(int conn_id, int server_if, int connected,
@@ -1448,7 +1448,7 @@ static void gatts_connection_cb(int conn_id, int server_if, int connected,
 	g_free(props[0]->val);
 	g_free(props[0]);
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void pan_control_state_cb(btpan_control_state_t state,
@@ -1462,7 +1462,7 @@ static void pan_control_state_cb(btpan_control_state_t state,
 	step->callback_result.ctrl_state = error;
 	step->callback_result.local_role = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void pan_connection_state_cb(btpan_connection_state_t state,
@@ -1478,7 +1478,7 @@ static void pan_connection_state_cb(btpan_connection_state_t state,
 	step->callback_result.local_role = local_role;
 	step->callback_result.remote_role = remote_role;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static btpan_callbacks_t btpan_callbacks = {
@@ -1495,7 +1495,7 @@ static void hdp_app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 	step->callback_result.app_id = app_id;
 	step->callback_result.app_state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void hdp_channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
@@ -1510,7 +1510,7 @@ static void hdp_channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
 	step->callback_result.mdep_cfg_index = mdep_cfg_index;
 	step->callback_result.channel_state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static bthl_callbacks_t bthl_callbacks = {
@@ -1527,7 +1527,7 @@ static void a2dp_connection_state_cb(btav_connection_state_t state,
 	step->callback = CB_A2DP_CONN_STATE;
 	step->callback_result.state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static void a2dp_audio_state_cb(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
@@ -1537,7 +1537,7 @@ static void a2dp_audio_state_cb(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
 	step->callback = CB_A2DP_AUDIO_STATE;
 	step->callback_result.state = state;
 
-	schedule_callback_call(step);
+	schedule_callback_verification(step);
 }
 
 static btav_callbacks_t bta2dp_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index a343589..3e5c27d 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -561,6 +561,7 @@ void remove_gatt_tests(void);
 
 /* Generic tester API */
 void schedule_action_verification(struct step *step);
+void schedule_callback_verification(struct step *step);
 
 /* Emulator actions */
 void emu_setup_powered_remote_action(void);
-- 
1.9.1

