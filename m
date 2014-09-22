Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] android/tester: Add GATT Descriptor Read negative test case
Date: Mon, 22 Sep 2014 13:29:46 +0200
Message-Id: <1411385387-2811-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411385387-2811-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Read will return Insufficient Authorization error.
---
 android/tester-gatt.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 314db55..1d2c18f 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -307,6 +307,14 @@ static struct set_read_params set_read_param_4 = {
 	.status = BT_STATUS_SUCCESS
 };
 
+static struct set_read_params set_read_param_5 = {
+	.params = &read_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.descr_id = &desc_1,
+	.status = GATT_STATUS_INS_AUTH
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -472,6 +480,24 @@ static struct pdu read_descriptor_1[] = {
 	end_pdu
 };
 
+static struct pdu read_descriptor_2[] = {
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
+	raw_pdu(0x01, 0x0a, 0x04, 0x00, 0x08),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1428,6 +1454,41 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Read Descriptor - Ins. Author.",
+		ACTION_SUCCESS(init_pdus, read_descriptor_2),
+		ACTION_SUCCESS(init_read_params_action, &set_read_param_5),
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
+		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_1),
+		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
+				&service_1, &characteristic_1, &desc_1),
+		ACTION_SUCCESS(gatt_client_read_descriptor_action,
+							&read_desc_data_1),
+		CALLBACK_GATTC_READ_DESCRIPTOR(GATT_STATUS_INS_AUTH,
+						CONN1_ID, &read_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

