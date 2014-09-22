Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] android/tester: Add GATT Characteristic Read negative 2 test case
Date: Mon, 22 Sep 2014 13:29:44 +0200
Message-Id: <1411385387-2811-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will test Read Characteristic command with wrong parameters.
---
 android/tester-gatt.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 3981bbd..17bf07b 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -235,6 +235,12 @@ static struct read_char_data read_char_data_1 = {
 	.characteristic = &characteristic_1,
 };
 
+static struct read_char_data read_char_data_2 = {
+	.conn_id = CONN1_ID,
+	.service = &service_2,
+	.characteristic = &characteristic_1,
+};
+
 struct get_incl_data get_incl_data_1 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1
@@ -269,6 +275,13 @@ static struct set_read_params set_read_param_2 = {
 	.status = GATT_STATUS_INS_AUTH
 };
 
+static struct set_read_params set_read_param_3 = {
+	.params = &read_params_1,
+	.srvc_id = &service_2,
+	.char_id = &characteristic_1,
+	.status = 0x01,
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -1286,6 +1299,38 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Read Characteristic - Wrong params",
+		ACTION_SUCCESS(init_pdus, read_characteristic_2),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_read_params_action, &set_read_param_3),
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
+		ACTION_FAIL(gatt_client_read_characteristic_action,
+							&read_char_data_2),
+		CALLBACK_GATTC_READ_CHARACTERISTIC(GATT_STATUS_FAILURE,
+						CONN1_ID, &read_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

