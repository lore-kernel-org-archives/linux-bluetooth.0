Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 15/15] android/tester: Add GATT Write Characteristic Wrong params
Date: Wed, 24 Sep 2014 13:38:00 +0200
Message-Id: <1411558680-26856-16-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test calling write characteristic with wrong params.
---
 android/tester-gatt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b0aee0d..04b79c7 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -385,6 +385,13 @@ static struct set_write_params set_write_param_2 = {
 	.status = GATT_STATUS_INS_AUTH
 };
 
+static struct set_write_params set_write_param_3 = {
+	.params = &write_params_1,
+	.srvc_id = &service_1,
+	.char_id = &characteristic_1,
+	.status = 0x01
+};
+
 static struct pdu search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -1792,6 +1799,28 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Write Characteristic - Wrong Params",
+		ACTION_SUCCESS(init_pdus, write_characteristic_3),
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(init_write_params_action, &set_write_param_3),
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
+		ACTION_FAIL(gatt_client_write_characteristic_action,
+							&write_char_data_2),
+		CALLBACK_GATTC_WRITE_CHARACTERISTIC(GATT_STATUS_FAILURE,
+						CONN1_ID, &write_params_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.3

