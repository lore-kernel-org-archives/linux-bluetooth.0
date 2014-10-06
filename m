Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH v2 1/4] android/tester: Add Gatt Write Descriptor Success
Date: Mon,  6 Oct 2014 16:28:46 +0200
Message-Id: <1412605729-21818-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Write descriptor value test case.
---
 android/tester-gatt.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 6827995..1f479e1 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -102,6 +102,17 @@ struct write_char_data {
 	char *p_value;
 };
 
+struct write_desc_data {
+	int conn_id;
+	btgatt_srvc_id_t *service;
+	btgatt_gatt_id_t *characteristic;
+	btgatt_gatt_id_t *descriptor;
+	int write_type;
+	int len;
+	int auth_req;
+	char *p_value;
+};
+
 struct notif_data {
 	int conn_id;
 	const bt_bdaddr_t *bdaddr;
@@ -297,6 +308,17 @@ static struct write_char_data write_char_data_2 = {
 	.auth_req = 0
 };
 
+static struct write_desc_data write_desc_data_1 = {
+	.conn_id = CONN1_ID,
+	.service = &service_1,
+	.characteristic = &characteristic_1,
+	.descriptor = &desc_1,
+	.write_type = 2,
+	.len = sizeof(value_2),
+	.auth_req = 0,
+	.p_value = value_2,
+};
+
 static struct notif_data notif_data_1 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1,
@@ -405,6 +427,14 @@ static struct set_write_params set_write_param_3 = {
 	.status = 0x01
 };
 
+static struct set_write_params set_write_param_4 = {
+	.params = &write_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.descr_id = &desc_1,
+	.status = BT_STATUS_SUCCESS
+};
+
 static struct set_notify_params set_notify_param_1 = {
 	.params = &notify_params_1,
 	.value = value_1,
@@ -649,6 +679,24 @@ static struct iovec write_characteristic_3[] = {
 	end_pdu
 };
 
+static struct iovec write_descriptor_1[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x00, 0x00, 0x19, 0x00),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	raw_pdu(0x04, 0x01, 0x00, 0x10, 0x00),
+	raw_pdu(0x05, 0x01, 0x04, 0x00, 0x00, 0x29),
+	raw_pdu(0x04, 0x05, 0x00, 0x10, 0x00),
+	raw_pdu(0x01, 0x04, 0x05, 0x00, 0x0a),
+	raw_pdu(0x12, 0x04, 0x00, 0x00, 0x01, 0x02, 0x03),
+	raw_pdu(0x13),
+	end_pdu
+};
+
 static struct iovec notification_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -1003,6 +1051,29 @@ static void gatt_server_disconnect_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_write_descriptor_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct write_desc_data *write_desc_data = current_data_step->set_data;
+	const btgatt_client_interface_t *client = data->if_gatt->client;
+	struct step *step = g_new0(struct step, 1);
+	int status;
+
+	status = client->write_descriptor(write_desc_data->conn_id,
+						write_desc_data->service,
+						write_desc_data->characteristic,
+						write_desc_data->descriptor,
+						write_desc_data->write_type,
+						write_desc_data->len,
+						write_desc_data->auth_req,
+						write_desc_data->p_value);
+
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -2180,7 +2251,42 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-
+	TEST_CASE_BREDRLE("Gatt Client - Write Descriptor - Success",
+		ACTION_SUCCESS(init_pdus, write_descriptor_1),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_write_params_action, &set_write_param_4),
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
+						CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
+		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
+		ACTION_SUCCESS(gatt_client_get_characteristic_action,
+							&get_char_data_1),
+		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
+				CONN1_ID, &service_1, &characteristic_1, 4),
+		ACTION_SUCCESS(gatt_client_get_descriptor_action,
+							&get_desc_data_1),
+		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
+				&service_1, &characteristic_1, &desc_1),
+		ACTION_SUCCESS(gatt_client_write_descriptor_action,
+							&write_desc_data_1),
+		CALLBACK_GATTC_WRITE_DESCRIPTOR(GATT_STATUS_SUCCESS,
+						CONN1_ID, &write_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 	TEST_CASE_BREDRLE("Gatt Server - Register",
 		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
-- 
1.9.1

