Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/5] android/tester: Add GATT Notification test - Indicate
Date: Thu,  2 Oct 2014 14:34:10 +0200
Message-Id: <1412253251-7258-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412253251-7258-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412253251-7258-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test receiving notifications from remote device.
---
 android/tester-gatt.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 51de407..cd838f2 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -208,6 +208,7 @@ static btgatt_gatt_id_t desc_2 = {
 
 static btgatt_read_params_t read_params_1;
 static btgatt_write_params_t write_params_1;
+static btgatt_notify_params_t notify_params_1;
 
 static struct get_char_data get_char_data_1 = {
 	.conn_id = CONN1_ID,
@@ -311,6 +312,16 @@ struct set_write_params {
 	uint8_t status;
 };
 
+struct set_notify_params {
+	btgatt_notify_params_t *params;
+	uint8_t *value;
+	uint16_t len;
+	uint8_t is_notify;
+	btgatt_srvc_id_t *srvc_id;
+	btgatt_gatt_id_t *char_id;
+	bt_bdaddr_t *bdaddr;
+};
+
 static uint8_t value_1[] = {0x01};
 
 static struct set_read_params set_read_param_1 = {
@@ -383,6 +394,16 @@ static struct set_write_params set_write_param_3 = {
 	.status = 0x01
 };
 
+static struct set_notify_params set_notify_param_1 = {
+	.params = &notify_params_1,
+	.value = value_1,
+	.len = sizeof(value_1),
+	.is_notify = 0,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.bdaddr = &emu_remote_bdaddr_val
+};
+
 static struct iovec search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -619,6 +640,20 @@ static struct iovec notification_1[] = {
 	end_pdu
 };
 
+static struct iovec notification_2[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x00, 0x00, 0x19, 0x00),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	raw_pdu(0x1d, 0x03, 0x00, 0x01),
+	raw_pdu(0x1e),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -955,6 +990,25 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	}
 }
 
+static void gatt_remote_send_frame_action(void)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	struct iovec *gatt_pdu = queue_pop_head(t_data->pdus);
+	struct step *step = g_new0(struct step, 1);
+
+	if (!gatt_pdu) {
+		tester_print("No frame to send");
+		step->action_status = BT_STATUS_FAIL;
+	} else {
+		bthost_send_cid_v(bthost, cid_data.handle, cid_data.cid,
+								gatt_pdu, 1);
+		step->action_status = BT_STATUS_SUCCESS;
+	}
+
+	schedule_action_verification(step);
+}
+
 static void gatt_conn_cb(uint16_t handle, void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1072,6 +1126,36 @@ static void init_write_params_action(void)
 	schedule_action_verification(step);
 }
 
+static void init_notify_params_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct step *step = g_new0(struct step, 1);
+	struct set_notify_params *set_param_data = current_data_step->set_data;
+	btgatt_notify_params_t *param = set_param_data->params;
+
+	memset(param, 0, sizeof(*param));
+
+	if (set_param_data->srvc_id)
+		memcpy(&param->srvc_id, set_param_data->srvc_id,
+						sizeof(btgatt_srvc_id_t));
+
+	if (set_param_data->char_id)
+		memcpy(&param->char_id, set_param_data->char_id,
+						sizeof(btgatt_gatt_id_t));
+
+	param->len = set_param_data->len;
+	param->is_notify = set_param_data->is_notify;
+
+	memcpy(&param->bda, set_param_data->bdaddr, sizeof(bt_bdaddr_t));
+	if (param->len != 0)
+		memcpy(&param->value, set_param_data->value, param->len);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -1959,6 +2043,41 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Register For Notification - Indicate",
+		ACTION_SUCCESS(init_pdus, notification_2),
+		ACTION_SUCCESS(init_notify_params_action, &set_notify_param_1),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_start_scan_action,
+							INT_TO_PTR(APP1_ID)),
+		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
+		ACTION_SUCCESS(gatt_client_stop_scan_action,
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+							CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
+		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
+		ACTION_SUCCESS(gatt_client_get_characteristic_action,
+							&get_char_data_1),
+		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
+				CONN1_ID, &service_1, &characteristic_1, 4),
+		ACTION_SUCCESS(gatt_client_register_for_notification_action,
+								&notif_data_1),
+		CALLBACK_GATTC_REGISTER_FOR_NOTIF(GATT_STATUS_SUCCESS, CONN1_ID,
+							&characteristic_1,
+							&service_1, 1),
+		ACTION_SUCCESS(gatt_remote_send_frame_action, NULL),
+		CALLBACK_GATTC_NOTIFY(CONN1_ID, &notify_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 
 	TEST_CASE_BREDRLE("Gatt Server - Register",
 		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
-- 
1.9.3

