Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/5] android/tester: Add GATT Notification test - Notify
Date: Thu,  2 Oct 2014 14:34:11 +0200
Message-Id: <1412253251-7258-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412253251-7258-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412253251-7258-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test receiving notifications in GATT Client.
---
 android/tester-gatt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index cd838f2..4c9eba5 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -404,6 +404,16 @@ static struct set_notify_params set_notify_param_1 = {
 	.bdaddr = &emu_remote_bdaddr_val
 };
 
+static struct set_notify_params set_notify_param_2 = {
+	.params = &notify_params_1,
+	.value = value_1,
+	.len = sizeof(value_1),
+	.is_notify = 1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.bdaddr = &emu_remote_bdaddr_val
+};
+
 static struct iovec search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -654,6 +664,19 @@ static struct iovec notification_2[] = {
 	end_pdu
 };
 
+static struct iovec notification_3[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x00, 0x00, 0x19, 0x00),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	raw_pdu(0x1b, 0x03, 0x00, 0x01),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -2078,6 +2101,41 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Register For Notification - Notify",
+		ACTION_SUCCESS(init_pdus, notification_3),
+		ACTION_SUCCESS(init_notify_params_action, &set_notify_param_2),
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
+		ACTION_SUCCESS(gatt_remote_send_frame_action, NULL),
+		CALLBACK_GATTC_NOTIFY(CONN1_ID, &notify_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 
 	TEST_CASE_BREDRLE("Gatt Server - Register",
 		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
-- 
1.9.3

