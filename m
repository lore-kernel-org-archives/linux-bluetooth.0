Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] android/tester: Add GATT Characteristic Read negative test case
Date: Mon, 22 Sep 2014 13:29:43 +0200
Message-Id: <1411385387-2811-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Insufficient Authorization error will be returned.
---
 android/tester-gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 9649fdb..3981bbd 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -26,6 +26,7 @@
 
 #define GATT_STATUS_SUCCESS	0x00000000
 #define GATT_STATUS_FAILURE	0x00000101
+#define GATT_STATUS_INS_AUTH	0x08
 
 #define CLIENT1_ID	1
 #define CLIENT2_ID	2
@@ -261,6 +262,13 @@ static struct set_read_params set_read_param_1 = {
 	.status = BT_STATUS_SUCCESS
 };
 
+static struct set_read_params set_read_param_2 = {
+	.params = &read_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.status = GATT_STATUS_INS_AUTH
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -394,6 +402,20 @@ static struct pdu read_characteristic_1[] = {
 	end_pdu
 };
 
+static struct pdu read_characteristic_2[] = {
+	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
+	raw_pdu(0x10, 0x11, 0x00, 0xff, 0xff, 0x00, 0x28),
+	raw_pdu(0x01, 0x11, 0x11, 0x00, 0x0a),
+	raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x09, 0x07, 0x02, 0x00, 0x04, 0x03, 0x00, 0x19, 0x00),
+	raw_pdu(0x08, 0x03, 0x00, 0x10, 0x00, 0x03, 0x28),
+	raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+	raw_pdu(0x0a, 0x03, 0x00),
+	raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1232,6 +1254,38 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Read Characteristic - Ins. Author.",
+		ACTION_SUCCESS(init_pdus, read_characteristic_2),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_read_params_action, &set_read_param_2),
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
+		ACTION_SUCCESS(gatt_client_read_characteristic_action,
+							&read_char_data_1),
+		CALLBACK_GATTC_READ_CHARACTERISTIC(GATT_STATUS_INS_AUTH,
+						CONN1_ID, &read_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

