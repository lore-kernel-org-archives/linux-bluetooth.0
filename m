Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/15] android/tester: Add GATT Characteristic Write Cmd Success
Date: Wed, 24 Sep 2014 13:37:56 +0200
Message-Id: <1411558680-26856-12-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test Characteristic write command.
---
 android/tester-gatt.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index e52adc0..747b545 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -107,6 +107,16 @@ struct read_desc_data {
 	int auth_req;
 };
 
+struct write_char_data {
+	int conn_id;
+	btgatt_srvc_id_t *service;
+	btgatt_gatt_id_t *characteristic;
+	int write_type;
+	int len;
+	int auth_req;
+	char *p_value;
+};
+
 static bt_uuid_t client2_app_uuid = {
 	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
 				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
@@ -213,6 +223,7 @@ static btgatt_gatt_id_t desc_2 = {
 };
 
 static btgatt_read_params_t read_params_1;
+static btgatt_write_params_t write_params_1;
 
 static struct get_char_data get_char_data_1 = {
 	.conn_id = CONN1_ID,
@@ -268,6 +279,18 @@ static struct get_incl_data get_incl_data_1 = {
 	.service = &service_1
 };
 
+static char value_2[] = {0x00, 0x01, 0x02, 0x03};
+
+static struct write_char_data write_char_data_1 = {
+	.conn_id = CONN1_ID,
+	.service = &service_1,
+	.characteristic = &characteristic_1,
+	.write_type = 1,
+	.len = sizeof(value_2),
+	.p_value = value_2,
+	.auth_req = 0
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -279,6 +302,14 @@ struct set_read_params {
 	uint8_t status;
 };
 
+struct set_write_params {
+	btgatt_write_params_t *params;
+	btgatt_srvc_id_t *srvc_id;
+	btgatt_gatt_id_t *char_id;
+	btgatt_gatt_id_t *descr_id;
+	uint8_t status;
+};
+
 static uint8_t value_1[] = {0x01};
 
 static struct set_read_params set_read_param_1 = {
@@ -330,6 +361,13 @@ static struct set_read_params set_read_param_6 = {
 	.status = 0x01
 };
 
+static struct set_write_params set_write_param_1 = {
+	.params = &write_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.status = BT_STATUS_SUCCESS
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -513,6 +551,19 @@ static struct pdu read_descriptor_2[] = {
 	end_pdu
 };
 
+static struct pdu write_characteristic_1[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x03, 0x00, 0x19, 0x00),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	raw_pdu(0x52, 0x03, 0x00, 0x00, 0x01, 0x02, 0x03),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -711,6 +762,28 @@ static void gatt_client_read_descriptor_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_write_characteristic_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct write_char_data *write_char_data = current_data_step->set_data;
+	const btgatt_client_interface_t *client = data->if_gatt->client;
+	struct step *step = g_new0(struct step, 1);
+	int status;
+
+	status = client->write_characteristic(write_char_data->conn_id,
+						write_char_data->service,
+						write_char_data->characteristic,
+						write_char_data->write_type,
+						write_char_data->len,
+						write_char_data->auth_req,
+						write_char_data->p_value);
+
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -850,6 +923,35 @@ static void init_read_params_action(void)
 	schedule_action_verification(step);
 }
 
+static void init_write_params_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct step *step = g_new0(struct step, 1);
+	struct set_write_params *set_param_data = current_data_step->set_data;
+	btgatt_write_params_t *param = set_param_data->params;
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
+	if (set_param_data->descr_id)
+		memcpy(&param->descr_id, set_param_data->descr_id,
+						sizeof(btgatt_gatt_id_t));
+
+	param->status = set_param_data->status;
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -1549,6 +1651,38 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Write Characteristic Cmd - Success",
+		ACTION_SUCCESS(init_pdus, write_characteristic_1),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_write_params_action, &set_write_param_1),
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
+		ACTION_SUCCESS(gatt_client_write_characteristic_action,
+							&write_char_data_1),
+		CALLBACK_GATTC_WRITE_CHARACTERISTIC(GATT_STATUS_SUCCESS,
+						CONN1_ID, &write_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

