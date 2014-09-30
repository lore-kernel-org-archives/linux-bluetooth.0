Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/5] android/tester: Add GATT Register For Notification Success
Date: Tue, 30 Sep 2014 13:03:03 +0200
Message-Id: <1412074986-21285-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412074986-21285-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412074986-21285-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test GATT register for notification command.
---
 android/tester-gatt.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 693a8a3..6f50176 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -117,6 +117,13 @@ struct write_char_data {
 	char *p_value;
 };
 
+struct notif_data {
+	int conn_id;
+	const bt_bdaddr_t *bdaddr;
+	btgatt_srvc_id_t *service;
+	btgatt_gatt_id_t *charac;
+};
+
 static bt_uuid_t client2_app_uuid = {
 	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
 				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
@@ -301,6 +308,13 @@ static struct write_char_data write_char_data_2 = {
 	.auth_req = 0
 };
 
+static struct notif_data notif_data_1 = {
+	.conn_id = CONN1_ID,
+	.service = &service_1,
+	.charac = &characteristic_1,
+	.bdaddr = &emu_remote_bdaddr_val,
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -616,6 +630,18 @@ static struct pdu write_characteristic_3[] = {
 	end_pdu
 };
 
+static struct pdu notification_1[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x00, 0x00, 0x19, 0x00),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -836,6 +862,24 @@ static void gatt_client_write_characteristic_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_register_for_notification_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct notif_data *notif_data = current_data_step->set_data;
+	const btgatt_client_interface_t *client = data->if_gatt->client;
+	struct step *step = g_new0(struct step, 1);
+	int status;
+
+	status = client->register_for_notification(notif_data->conn_id,
+							notif_data->bdaddr,
+							notif_data->service,
+							notif_data->charac);
+	step->action_status = status;
+
+	schedule_action_verification(step);
+}
+
 static void gatt_server_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1851,6 +1895,38 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Register For Notification - Success",
+		ACTION_SUCCESS(init_pdus, notification_1),
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
+						CONN1_ID, APP1_ID),
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
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 
 	TEST_CASE_BREDRLE("Gatt Server - Register",
 		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
-- 
1.9.3

