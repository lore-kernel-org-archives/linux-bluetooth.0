Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH v2 4/4] android/tester: Add Gatt Write Descriptor Insuf. Auth.
Date: Mon,  6 Oct 2014 16:28:49 +0200
Message-Id: <1412605729-21818-4-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1412605729-21818-1-git-send-email-mariusz.skamra@tieto.com>
References: <1412605729-21818-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test case for insufficient authorization error
---
 android/tester-gatt.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 07e49ac..d5d504e 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -454,6 +454,14 @@ static struct set_write_params set_write_param_5 = {
 	.status = 0x01
 };
 
+static struct set_write_params set_write_param_6 = {
+	.params = &write_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.descr_id = &desc_1,
+	.status = GATT_STATUS_INS_AUTH
+};
+
 static struct set_notify_params set_notify_param_1 = {
 	.params = &notify_params_1,
 	.value = value_1,
@@ -716,6 +724,24 @@ static struct iovec write_descriptor_1[] = {
 	end_pdu
 };
 
+static struct iovec write_descriptor_2[] = {
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
+	raw_pdu(0x01, 0x12, 0x04, 0x00, 0x08),
+	end_pdu
+};
+
 static struct iovec notification_1[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -2306,6 +2332,42 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Write Descriptor - Insuf. Auth.",
+		ACTION_SUCCESS(init_pdus, write_descriptor_2),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_write_params_action, &set_write_param_6),
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
+		CALLBACK_GATTC_WRITE_DESCRIPTOR(GATT_STATUS_INS_AUTH,
+						CONN1_ID, &write_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 	TEST_CASE_BREDRLE("Gatt Client - Write Descriptor - Wrong Param",
 		ACTION_SUCCESS(init_pdus, write_descriptor_1),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-- 
1.9.1

