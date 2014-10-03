Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 3/4] android/tester: Add Gatt Write Descriptor Wrong Param
Date: Fri,  3 Oct 2014 14:58:00 +0200
Message-Id: <1412341081-20594-3-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1412341081-20594-1-git-send-email-mariusz.skamra@tieto.com>
References: <1412341081-20594-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Write descriptor value using wrong parameters test case
---
 android/tester-gatt.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 79de14f..3c686aa 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -287,6 +287,17 @@ static struct write_char_data write_char_data_1 = {
 	.auth_req = 0
 };
 
+static struct write_desc_data write_desc_data_2 = {
+	.conn_id = CONN1_ID,
+	.service = &service_1,
+	.characteristic = &characteristic_1,
+	.descriptor = &desc_2,
+	.write_type = 2,
+	.len = sizeof(value_2),
+	.auth_req = 0,
+	.p_value = value_2,
+};
+
 static struct write_char_data write_char_data_2 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1,
@@ -424,6 +435,14 @@ static struct set_write_params set_write_param_4 = {
 	.status = BT_STATUS_SUCCESS
 };
 
+static struct set_write_params set_write_param_5 = {
+	.params = &write_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.descr_id = &desc_2,
+	.status = 0x01
+};
+
 static struct set_notify_params set_notify_param_1 = {
 	.params = &notify_params_1,
 	.value = value_1,
@@ -2256,6 +2275,42 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 		),
+	TEST_CASE_BREDRLE("Gatt Client - Write Descriptor - Wrong Param",
+		ACTION_SUCCESS(init_pdus, write_descriptor_1),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_write_params_action, &set_write_param_5),
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
+		ACTION_FAIL(gatt_client_write_descriptor_action,
+							&write_desc_data_2),
+		CALLBACK_GATTC_WRITE_DESCRIPTOR(GATT_STATUS_FAILURE,
+						CONN1_ID, &write_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+		),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.1

