Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 08/15] android/tester: Add GATT Descriptor Read Success
Date: Wed, 24 Sep 2014 13:37:53 +0200
Message-Id: <1411558680-26856-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test Reading Descriptor Value.
---
 android/tester-gatt.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 055ce7b..855bd5a 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -99,6 +99,14 @@ struct read_char_data {
 	int auth_req;
 };
 
+struct read_desc_data {
+	const int conn_id;
+	btgatt_srvc_id_t *service;
+	btgatt_gatt_id_t *characteristic;
+	btgatt_gatt_id_t *descriptor;
+	int auth_req;
+};
+
 static bt_uuid_t client2_app_uuid = {
 	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
 				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
@@ -241,6 +249,13 @@ static struct read_char_data read_char_data_2 = {
 	.characteristic = &characteristic_1,
 };
 
+static struct read_desc_data read_desc_data_1 = {
+	.conn_id = CONN1_ID,
+	.service = &service_1,
+	.characteristic = &characteristic_1,
+	.descriptor = &desc_1,
+};
+
 static struct get_incl_data get_incl_data_1 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1
@@ -282,6 +297,16 @@ static struct set_read_params set_read_param_3 = {
 	.status = 0x01,
 };
 
+static struct set_read_params set_read_param_4 = {
+	.params = &read_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.descr_id = &desc_1,
+	.value = value_1,
+	.len = 1,
+	.status = BT_STATUS_SUCCESS
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -429,6 +454,24 @@ static struct pdu read_characteristic_2[] = {
 	end_pdu
 };
 
+static struct pdu read_descriptor_1[] = {
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
+	raw_pdu(0x0a, 0x04, 0x00),
+	raw_pdu(0x0b, 0x01),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -608,6 +651,25 @@ static void gatt_client_read_characteristic_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_read_descriptor_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct read_desc_data *read_desc_data = current_data_step->set_data;
+	const btgatt_client_interface_t *client = data->if_gatt->client;
+	struct step *step = g_new0(struct step, 1);
+	int status;
+
+	status = client->read_descriptor(read_desc_data->conn_id,
+			read_desc_data->service, read_desc_data->characteristic,
+			read_desc_data->descriptor,
+			read_desc_data->auth_req);
+
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -1338,6 +1400,42 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Read Descriptor - Success",
+		ACTION_SUCCESS(init_pdus, read_descriptor_1),
+		ACTION_SUCCESS(init_read_params_action, &set_read_param_4),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_start_scan_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
+		ACTION_SUCCESS(gatt_client_stop_scan_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
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
+		ACTION_SUCCESS(gatt_client_read_descriptor_action,
+							&read_desc_data_1),
+		CALLBACK_GATTC_READ_DESCRIPTOR(GATT_STATUS_SUCCESS,
+						CONN1_ID, &read_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

