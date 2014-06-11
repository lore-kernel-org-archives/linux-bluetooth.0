Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/10] android/hal-ipc: Pass FD to notification handlers
Date: Wed, 11 Jun 2014 16:32:51 +0200
Message-Id: <1402497172-12436-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-a2dp.c      |  4 ++--
 android/hal-avrcp.c     | 24 +++++++++----------
 android/hal-bluetooth.c | 22 +++++++++---------
 android/hal-gatt.c      | 62 ++++++++++++++++++++++++-------------------------
 android/hal-handsfree.c | 32 ++++++++++++-------------
 android/hal-health.c    |  2 +-
 android/hal-hidhost.c   | 12 +++++-----
 android/hal-ipc.c       |  6 ++---
 android/hal-ipc.h       |  2 +-
 android/hal-pan.c       |  4 ++--
 10 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index d43c873..87aebde 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -31,7 +31,7 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_conn_state(void *buf, uint16_t len)
+static void handle_conn_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_a2dp_conn_state *ev = buf;
 
@@ -40,7 +40,7 @@ static void handle_conn_state(void *buf, uint16_t len)
 						(bt_bdaddr_t *) (ev->bdaddr));
 }
 
-static void handle_audio_state(void *buf, uint16_t len)
+static void handle_audio_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_a2dp_audio_state *ev = buf;
 
diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 5e07366..09f5463 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -33,7 +33,7 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_remote_features(void *buf, uint16_t len)
+static void handle_remote_features(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_remote_features *ev = buf;
 
@@ -42,19 +42,19 @@ static void handle_remote_features(void *buf, uint16_t len)
 								ev->features);
 }
 
-static void handle_get_play_status(void *buf, uint16_t len)
+static void handle_get_play_status(void *buf, uint16_t len, int fd)
 {
 	if (cbs->get_play_status_cb)
 		cbs->get_play_status_cb();
 }
 
-static void handle_list_player_attrs(void *buf, uint16_t len)
+static void handle_list_player_attrs(void *buf, uint16_t len, int fd)
 {
 	if (cbs->list_player_app_attr_cb)
 		cbs->list_player_app_attr_cb();
 }
 
-static void handle_list_player_values(void *buf, uint16_t len)
+static void handle_list_player_values(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_list_player_values *ev = buf;
 
@@ -62,7 +62,7 @@ static void handle_list_player_values(void *buf, uint16_t len)
 		cbs->list_player_app_values_cb(ev->attr);
 }
 
-static void handle_get_player_values(void *buf, uint16_t len)
+static void handle_get_player_values(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_get_player_values *ev = buf;
 	btrc_player_attr_t attrs[4];
@@ -78,7 +78,7 @@ static void handle_get_player_values(void *buf, uint16_t len)
 	cbs->get_player_app_value_cb(ev->number, attrs);
 }
 
-static void handle_get_player_attrs_text(void *buf, uint16_t len)
+static void handle_get_player_attrs_text(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_get_player_attrs_text *ev = buf;
 	btrc_player_attr_t attrs[4];
@@ -94,7 +94,7 @@ static void handle_get_player_attrs_text(void *buf, uint16_t len)
 	cbs->get_player_app_attrs_text_cb(ev->number, attrs);
 }
 
-static void handle_get_player_values_text(void *buf, uint16_t len)
+static void handle_get_player_values_text(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_get_player_values_text *ev = buf;
 
@@ -103,7 +103,7 @@ static void handle_get_player_values_text(void *buf, uint16_t len)
 								ev->values);
 }
 
-static void handle_set_player_value(void *buf, uint16_t len)
+static void handle_set_player_value(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_set_player_values *ev = buf;
 	struct hal_avrcp_player_attr_value *attrs;
@@ -125,7 +125,7 @@ static void handle_set_player_value(void *buf, uint16_t len)
 	cbs->set_player_app_value_cb(&values);
 }
 
-static void handle_get_element_attrs(void *buf, uint16_t len)
+static void handle_get_element_attrs(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_get_element_attrs *ev = buf;
 	btrc_media_attr_t attrs[BTRC_MAX_APP_SETTINGS];
@@ -141,7 +141,7 @@ static void handle_get_element_attrs(void *buf, uint16_t len)
 	cbs->get_element_attr_cb(ev->number, attrs);
 }
 
-static void handle_register_notification(void *buf, uint16_t len)
+static void handle_register_notification(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_register_notification *ev = buf;
 
@@ -149,7 +149,7 @@ static void handle_register_notification(void *buf, uint16_t len)
 		cbs->register_notification_cb(ev->event, ev->param);
 }
 
-static void handle_volume_changed(void *buf, uint16_t len)
+static void handle_volume_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_volume_changed *ev = buf;
 
@@ -157,7 +157,7 @@ static void handle_volume_changed(void *buf, uint16_t len)
 		cbs->volume_change_cb(ev->volume, ev->type);
 }
 
-static void handle_passthrough_cmd(void *buf, uint16_t len)
+static void handle_passthrough_cmd(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_avrcp_passthrough_cmd *ev = buf;
 
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index b8eae69..4291430 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -52,7 +52,7 @@ static const bt_callbacks_t *bt_hal_cbacks = NULL;
 	*hal_len = 1; \
 } while (0)
 
-static void handle_adapter_state_changed(void *buf, uint16_t len)
+static void handle_adapter_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_adapter_state_changed *ev = buf;
 
@@ -197,7 +197,7 @@ static void device_props_to_hal(bt_property_t *send_props,
 	exit(EXIT_FAILURE);
 }
 
-static void handle_adapter_props_changed(void *buf, uint16_t len)
+static void handle_adapter_props_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_adapter_props_changed *ev = buf;
 	bt_property_t props[ev->num_props];
@@ -213,7 +213,7 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 	bt_hal_cbacks->adapter_properties_cb(ev->status, ev->num_props, props);
 }
 
-static void handle_bond_state_change(void *buf, uint16_t len)
+static void handle_bond_state_change(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_bond_state_changed *ev = buf;
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
@@ -225,7 +225,7 @@ static void handle_bond_state_change(void *buf, uint16_t len)
 								ev->state);
 }
 
-static void handle_pin_request(void *buf, uint16_t len)
+static void handle_pin_request(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_pin_request *ev = buf;
 	/* Those are declared as packed, so it's safe to assign pointers */
@@ -238,7 +238,7 @@ static void handle_pin_request(void *buf, uint16_t len)
 		bt_hal_cbacks->pin_request_cb(addr, name, ev->class_of_dev);
 }
 
-static void handle_ssp_request(void *buf, uint16_t len)
+static void handle_ssp_request(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_ssp_request *ev = buf;
 	/* Those are declared as packed, so it's safe to assign pointers */
@@ -270,7 +270,7 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
-static void handle_discovery_state_changed(void *buf, uint16_t len)
+static void handle_discovery_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_discovery_state_changed *ev = buf;
 
@@ -280,7 +280,7 @@ static void handle_discovery_state_changed(void *buf, uint16_t len)
 		bt_hal_cbacks->discovery_state_changed_cb(ev->state);
 }
 
-static void handle_device_found(void *buf, uint16_t len)
+static void handle_device_found(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_device_found *ev = buf;
 	bt_property_t props[ev->num_props];
@@ -296,7 +296,7 @@ static void handle_device_found(void *buf, uint16_t len)
 	bt_hal_cbacks->device_found_cb(ev->num_props, props);
 }
 
-static void handle_device_state_changed(void *buf, uint16_t len)
+static void handle_device_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_remote_device_props *ev = buf;
 	bt_property_t props[ev->num_props];
@@ -314,7 +314,7 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 						ev->num_props, props);
 }
 
-static void handle_acl_state_changed(void *buf, uint16_t len)
+static void handle_acl_state_changed(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_acl_state_changed *ev = buf;
 	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
@@ -326,7 +326,7 @@ static void handle_acl_state_changed(void *buf, uint16_t len)
 								ev->state);
 }
 
-static void handle_dut_mode_receive(void *buf, uint16_t len)
+static void handle_dut_mode_receive(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_dut_mode_receive *ev = buf;
 
@@ -341,7 +341,7 @@ static void handle_dut_mode_receive(void *buf, uint16_t len)
 		bt_hal_cbacks->dut_mode_recv_cb(ev->opcode, ev->data, ev->len);
 }
 
-static void handle_le_test_mode(void *buf, uint16_t len)
+static void handle_le_test_mode(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_le_test_mode *ev = buf;
 
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 6f0d2c5..d0a8a70 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -63,7 +63,7 @@ static void srvc_id_to_hal(struct hal_gatt_srvc_id *to, btgatt_srvc_id_t *from)
 
 /* Client Event Handlers */
 
-static void handle_register_client(void *buf, uint16_t len)
+static void handle_register_client(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_register_client *ev = buf;
 
@@ -72,7 +72,7 @@ static void handle_register_client(void *buf, uint16_t len)
 						(bt_uuid_t *) ev->app_uuid);
 }
 
-static void handle_scan_result(void *buf, uint16_t len)
+static void handle_scan_result(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_scan_result *ev = buf;
 	uint8_t ad[62];
@@ -91,7 +91,7 @@ static void handle_scan_result(void *buf, uint16_t len)
 									ad);
 }
 
-static void handle_connect(void *buf, uint16_t len)
+static void handle_connect(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_connect *ev = buf;
 
@@ -100,7 +100,7 @@ static void handle_connect(void *buf, uint16_t len)
 						(bt_bdaddr_t *) ev->bda);
 }
 
-static void handle_disconnect(void *buf, uint16_t len)
+static void handle_disconnect(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_disconnect *ev = buf;
 
@@ -109,7 +109,7 @@ static void handle_disconnect(void *buf, uint16_t len)
 						(bt_bdaddr_t *) ev->bda);
 }
 
-static void handle_search_complete(void *buf, uint16_t len)
+static void handle_search_complete(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_search_complete *ev = buf;
 
@@ -117,7 +117,7 @@ static void handle_search_complete(void *buf, uint16_t len)
 		cbs->client->search_complete_cb(ev->conn_id, ev->status);
 }
 
-static void handle_search_result(void *buf, uint16_t len)
+static void handle_search_result(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_search_result *ev = buf;
 	btgatt_srvc_id_t srvc_id;
@@ -128,7 +128,7 @@ static void handle_search_result(void *buf, uint16_t len)
 		cbs->client->search_result_cb(ev->conn_id, &srvc_id);
 }
 
-static void handle_get_characteristic(void *buf, uint16_t len)
+static void handle_get_characteristic(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_get_characteristic *ev = buf;
 	btgatt_gatt_id_t char_id;
@@ -143,7 +143,7 @@ static void handle_get_characteristic(void *buf, uint16_t len)
 							ev->char_prop);
 }
 
-static void handle_get_descriptor(void *buf, uint16_t len)
+static void handle_get_descriptor(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_get_descriptor *ev = buf;
 	btgatt_gatt_id_t descr_id;
@@ -159,7 +159,7 @@ static void handle_get_descriptor(void *buf, uint16_t len)
 						&srvc_id, &char_id, &descr_id);
 }
 
-static void handle_get_included_service(void *buf, uint16_t len)
+static void handle_get_included_service(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_get_inc_service *ev = buf;
 	btgatt_srvc_id_t srvc_id;
@@ -174,7 +174,7 @@ static void handle_get_included_service(void *buf, uint16_t len)
 								&incl_srvc_id);
 }
 
-static void handle_register_for_notification(void *buf, uint16_t len)
+static void handle_register_for_notification(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_reg_for_notif *ev = buf;
 	btgatt_gatt_id_t char_id;
@@ -191,7 +191,7 @@ static void handle_register_for_notification(void *buf, uint16_t len)
 								&char_id);
 }
 
-static void handle_notify(void *buf, uint16_t len)
+static void handle_notify(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_notify *ev = buf;
 	btgatt_notify_params_t params;
@@ -215,7 +215,7 @@ static void handle_notify(void *buf, uint16_t len)
 		cbs->client->notify_cb(ev->conn_id, &params);
 }
 
-static void handle_read_characteristic(void *buf, uint16_t len)
+static void handle_read_characteristic(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_read_characteristic *ev = buf;
 	btgatt_read_params_t params;
@@ -242,7 +242,7 @@ static void handle_read_characteristic(void *buf, uint16_t len)
 								&params);
 }
 
-static void handle_write_characteristic(void *buf, uint16_t len)
+static void handle_write_characteristic(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_write_characteristic *ev = buf;
 	btgatt_write_params_t params;
@@ -260,7 +260,7 @@ static void handle_write_characteristic(void *buf, uint16_t len)
 								&params);
 }
 
-static void handle_read_descriptor(void *buf, uint16_t len)
+static void handle_read_descriptor(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_read_descriptor *ev = buf;
 	btgatt_read_params_t params;
@@ -287,7 +287,7 @@ static void handle_read_descriptor(void *buf, uint16_t len)
 								&params);
 }
 
-static void handle_write_descriptor(void *buf, uint16_t len)
+static void handle_write_descriptor(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_write_descriptor *ev = buf;
 	btgatt_write_params_t params;
@@ -305,7 +305,7 @@ static void handle_write_descriptor(void *buf, uint16_t len)
 								&params);
 }
 
-static void handle_execute_write(void *buf, uint16_t len)
+static void handle_execute_write(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_exec_write *ev = buf;
 
@@ -313,7 +313,7 @@ static void handle_execute_write(void *buf, uint16_t len)
 		cbs->client->execute_write_cb(ev->conn_id, ev->status);
 }
 
-static void handle_read_remote_rssi(void *buf, uint16_t len)
+static void handle_read_remote_rssi(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_read_remote_rssi *ev = buf;
 
@@ -323,7 +323,7 @@ static void handle_read_remote_rssi(void *buf, uint16_t len)
 						ev->rssi, ev->status);
 }
 
-static void handle_listen(void *buf, uint16_t len)
+static void handle_listen(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_client_listen *ev = buf;
 
@@ -333,7 +333,7 @@ static void handle_listen(void *buf, uint16_t len)
 
 /* Server Event Handlers */
 
-static void handle_register_server(void *buf, uint16_t len)
+static void handle_register_server(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_register *ev = buf;
 
@@ -342,7 +342,7 @@ static void handle_register_server(void *buf, uint16_t len)
 						(bt_uuid_t *) &ev->uuid);
 }
 
-static void handle_connection(void *buf, uint16_t len)
+static void handle_connection(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_connection *ev = buf;
 
@@ -352,7 +352,7 @@ static void handle_connection(void *buf, uint16_t len)
 						(bt_bdaddr_t *) &ev->bdaddr);
 }
 
-static void handle_service_added(void *buf, uint16_t len)
+static void handle_service_added(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_service_added *ev = buf;
 	btgatt_srvc_id_t srvc_id;
@@ -364,7 +364,7 @@ static void handle_service_added(void *buf, uint16_t len)
 						&srvc_id, ev->srvc_handle);
 }
 
-static void handle_included_service_added(void *buf, uint16_t len)
+static void handle_included_service_added(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_inc_srvc_added *ev = buf;
 
@@ -375,7 +375,7 @@ static void handle_included_service_added(void *buf, uint16_t len)
 							ev->incl_srvc_handle);
 }
 
-static void handle_characteristic_added(void *buf, uint16_t len)
+static void handle_characteristic_added(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_characteristic_added *ev = buf;
 
@@ -386,7 +386,7 @@ static void handle_characteristic_added(void *buf, uint16_t len)
 							ev->char_handle);
 }
 
-static void handle_descriptor_added(void *buf, uint16_t len)
+static void handle_descriptor_added(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_descriptor_added *ev = buf;
 
@@ -397,7 +397,7 @@ static void handle_descriptor_added(void *buf, uint16_t len)
 							ev->descr_handle);
 }
 
-static void handle_service_started(void *buf, uint16_t len)
+static void handle_service_started(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_service_started *ev = buf;
 
@@ -406,7 +406,7 @@ static void handle_service_started(void *buf, uint16_t len)
 							ev->srvc_handle);
 }
 
-static void handle_service_stopped(void *buf, uint16_t len)
+static void handle_service_stopped(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_service_stopped *ev = buf;
 
@@ -415,7 +415,7 @@ static void handle_service_stopped(void *buf, uint16_t len)
 							ev->srvc_handle);
 }
 
-static void handle_service_deleted(void *buf, uint16_t len)
+static void handle_service_deleted(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_service_deleted *ev = buf;
 
@@ -424,7 +424,7 @@ static void handle_service_deleted(void *buf, uint16_t len)
 							ev->srvc_handle);
 }
 
-static void handle_request_read(void *buf, uint16_t len)
+static void handle_request_read(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_request_read *ev = buf;
 
@@ -435,7 +435,7 @@ static void handle_request_read(void *buf, uint16_t len)
 						ev->is_long);
 }
 
-static void handle_request_write(void *buf, uint16_t len)
+static void handle_request_write(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_request_write *ev = buf;
 
@@ -452,7 +452,7 @@ static void handle_request_write(void *buf, uint16_t len)
 						ev->is_prep, ev->value);
 }
 
-static void handle_request_exec_write(void *buf, uint16_t len)
+static void handle_request_exec_write(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_request_exec_write *ev = buf;
 
@@ -462,7 +462,7 @@ static void handle_request_exec_write(void *buf, uint16_t len)
 						ev->exec_write);
 }
 
-static void handle_response_confirmation(void *buf, uint16_t len)
+static void handle_response_confirmation(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_gatt_server_rsp_confirmation *ev = buf;
 
diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index d992506..1d9a1a2 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -37,7 +37,7 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_conn_state(void *buf, uint16_t len)
+static void handle_conn_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_conn_state *ev = buf;
 
@@ -46,7 +46,7 @@ static void handle_conn_state(void *buf, uint16_t len)
 						(bt_bdaddr_t *) (ev->bdaddr));
 }
 
-static void handle_audio_state(void *buf, uint16_t len)
+static void handle_audio_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_audio_state *ev = buf;
 
@@ -54,7 +54,7 @@ static void handle_audio_state(void *buf, uint16_t len)
 		cbs->audio_state_cb(ev->state, (bt_bdaddr_t *) (ev->bdaddr));
 }
 
-static void handle_vr_state(void *buf, uint16_t len)
+static void handle_vr_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_vr_state *ev = buf;
 
@@ -62,19 +62,19 @@ static void handle_vr_state(void *buf, uint16_t len)
 		cbs->vr_cmd_cb(ev->state);
 }
 
-static void handle_answer(void *buf, uint16_t len)
+static void handle_answer(void *buf, uint16_t len, int fd)
 {
 	if (cbs->answer_call_cmd_cb)
 		cbs->answer_call_cmd_cb();
 }
 
-static void handle_hangup(void *buf, uint16_t len)
+static void handle_hangup(void *buf, uint16_t len, int fd)
 {
 	if (cbs->hangup_call_cmd_cb)
 		cbs->hangup_call_cmd_cb();
 }
 
-static void handle_volume(void *buf, uint16_t len)
+static void handle_volume(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_volume *ev = buf;
 
@@ -82,7 +82,7 @@ static void handle_volume(void *buf, uint16_t len)
 		cbs->volume_cmd_cb(ev->type, ev->volume);
 }
 
-static void handle_dial(void *buf, uint16_t len)
+static void handle_dial(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_dial *ev = buf;
 	uint16_t num_len = ev->number_len;
@@ -102,7 +102,7 @@ static void handle_dial(void *buf, uint16_t len)
 		cbs->dial_call_cmd_cb(NULL);
 }
 
-static void handle_dtmf(void *buf, uint16_t len)
+static void handle_dtmf(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_dtmf *ev = buf;
 
@@ -110,7 +110,7 @@ static void handle_dtmf(void *buf, uint16_t len)
 		cbs->dtmf_cmd_cb(ev->tone);
 }
 
-static void handle_nrec(void *buf, uint16_t len)
+static void handle_nrec(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_nrec *ev = buf;
 
@@ -118,7 +118,7 @@ static void handle_nrec(void *buf, uint16_t len)
 		cbs->nrec_cmd_cb(ev->nrec);
 }
 
-static void handle_chld(void *buf, uint16_t len)
+static void handle_chld(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_chld *ev = buf;
 
@@ -126,31 +126,31 @@ static void handle_chld(void *buf, uint16_t len)
 		cbs->chld_cmd_cb(ev->chld);
 }
 
-static void handle_cnum(void *buf, uint16_t len)
+static void handle_cnum(void *buf, uint16_t len, int fd)
 {
 	if (cbs->cnum_cmd_cb)
 		cbs->cnum_cmd_cb();
 }
 
-static void handle_cind(void *buf, uint16_t len)
+static void handle_cind(void *buf, uint16_t len, int fd)
 {
 	if (cbs->cind_cmd_cb)
 		cbs->cind_cmd_cb();
 }
 
-static void handle_cops(void *buf, uint16_t len)
+static void handle_cops(void *buf, uint16_t len, int fd)
 {
 	if (cbs->cops_cmd_cb)
 		cbs->cops_cmd_cb();
 }
 
-static void handle_clcc(void *buf, uint16_t len)
+static void handle_clcc(void *buf, uint16_t len, int fd)
 {
 	if (cbs->clcc_cmd_cb)
 		cbs->clcc_cmd_cb();
 }
 
-static void handle_unknown_at(void *buf, uint16_t len)
+static void handle_unknown_at(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_handsfree_unknown_at *ev = buf;
 
@@ -164,7 +164,7 @@ static void handle_unknown_at(void *buf, uint16_t len)
 		cbs->unknown_at_cmd_cb((char *) ev->buf);
 }
 
-static void handle_hsp_key_press(void *buf, uint16_t len)
+static void handle_hsp_key_press(void *buf, uint16_t len, int fd)
 {
 	if (cbs->key_pressed_cmd_cb)
 		cbs->key_pressed_cmd_cb();
diff --git a/android/hal-health.c b/android/hal-health.c
index e7326d7..0ef6afc 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -33,7 +33,7 @@ static bool interface_ready(void)
 	return cbacks != NULL;
 }
 
-static void handle_app_registration_state(void *buf, uint16_t len)
+static void handle_app_registration_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_health_app_reg_state *ev = buf;
 
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index ce93af8..949e2a0 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -33,7 +33,7 @@ static bool interface_ready(void)
 	return cbacks != NULL;
 }
 
-static void handle_conn_state(void *buf, uint16_t len)
+static void handle_conn_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_conn_state *ev = buf;
 
@@ -42,7 +42,7 @@ static void handle_conn_state(void *buf, uint16_t len)
 								ev->state);
 }
 
-static void handle_info(void *buf, uint16_t len)
+static void handle_info(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_info *ev = buf;
 	bthh_hid_info_t info;
@@ -61,7 +61,7 @@ static void handle_info(void *buf, uint16_t len)
 		cbacks->hid_info_cb((bt_bdaddr_t *) ev->bdaddr, info);
 }
 
-static void handle_proto_mode(void *buf, uint16_t len)
+static void handle_proto_mode(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_proto_mode *ev = buf;
 
@@ -70,7 +70,7 @@ static void handle_proto_mode(void *buf, uint16_t len)
 							ev->status, ev->mode);
 }
 
-static void handle_idle_time(void *buf, uint16_t len)
+static void handle_idle_time(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_idle_time *ev = buf;
 
@@ -79,7 +79,7 @@ static void handle_idle_time(void *buf, uint16_t len)
 								ev->idle_rate);
 }
 
-static void handle_get_report(void *buf, uint16_t len)
+static void handle_get_report(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_get_report *ev = buf;
 
@@ -93,7 +93,7 @@ static void handle_get_report(void *buf, uint16_t len)
 							ev->data, ev->len);
 }
 
-static void handle_virtual_unplug(void *buf, uint16_t len)
+static void handle_virtual_unplug(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_hidhost_virtual_unplug *ev = buf;
 
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 7dd6870..494ba85 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -63,7 +63,7 @@ void hal_ipc_unregister(uint8_t service)
 	services[service].size = 0;
 }
 
-static bool handle_msg(void *buf, ssize_t len)
+static bool handle_msg(void *buf, ssize_t len, int fd)
 {
 	struct ipc_hdr *msg = buf;
 	const struct hal_ipc_handler *handler;
@@ -122,7 +122,7 @@ static bool handle_msg(void *buf, ssize_t len)
 		return false;
 	}
 
-	handler->handler(msg->payload, msg->len);
+	handler->handler(msg->payload, msg->len, fd);
 
 	return true;
 }
@@ -185,7 +185,7 @@ static void *notification_handler(void *data)
 			}
 		}
 
-		if (!handle_msg(buf, ret))
+		if (!handle_msg(buf, ret, fd))
 			goto failed;
 	}
 
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index b61d557..08ed7cc 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -16,7 +16,7 @@
  */
 
 struct hal_ipc_handler {
-	void (*handler) (void *buf, uint16_t len);
+	void (*handler) (void *buf, uint16_t len, int fd);
 	bool var_len;
 	size_t data_len;
 };
diff --git a/android/hal-pan.c b/android/hal-pan.c
index e2bc02e..d3f93ff 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -31,7 +31,7 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
-static void handle_conn_state(void *buf, uint16_t len)
+static void handle_conn_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_pan_conn_state *ev = buf;
 
@@ -41,7 +41,7 @@ static void handle_conn_state(void *buf, uint16_t len)
 					ev->local_role, ev->remote_role);
 }
 
-static void handle_ctrl_state(void *buf, uint16_t len)
+static void handle_ctrl_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_pan_ctrl_state *ev = buf;
 
-- 
1.9.1

