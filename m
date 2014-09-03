Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/8] android/tester: Enable SSP in emulator by default
Date: Wed,  3 Sep 2014 11:02:47 +0200
Message-Id: <1409734969-10716-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should decide if the SSP feature will be used before the emulated
adapter features are retrieved so the SSP feature flag is correct.
For this setting the ssp feature had to be moved to 'pre_setup' stage.

To make this possible and most of the time automatic the '_NOSSP'
postfixed macros were added.
---
 android/tester-a2dp.c      |  4 ----
 android/tester-bluetooth.c | 12 ++----------
 android/tester-gatt.c      | 10 ----------
 android/tester-hdp.c       |  4 ----
 android/tester-hidhost.c   |  9 ---------
 android/tester-main.c      | 20 +++++---------------
 android/tester-main.h      | 19 ++++++++++++++++++-
 android/tester-pan.c       |  4 +---
 android/tester-socket.c    |  2 --
 9 files changed, 26 insertions(+), 58 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 6d4043b..17bf168 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -190,7 +190,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(a2dp_connect_action, NULL),
 		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
@@ -207,7 +206,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(a2dp_connect_action, NULL),
 		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
@@ -227,7 +225,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(a2dp_connect_action, NULL),
 		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
@@ -246,7 +243,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(a2dp_connect_action, NULL),
 		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index a97e28e..a9d8d43 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -982,7 +982,7 @@ static struct test_case test_cases[] = {
 		ACTION_FAIL(bt_set_device_prop_action,
 					&prop_test_remote_ble_disc_timeout_req),
 	),
-	TEST_CASE_BREDR("Bluetooth Create Bond PIN - Success",
+	TEST_CASE_BREDR_NOSSP("Bluetooth Create Bond PIN - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -1005,7 +1005,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
 						&prop_emu_remote_bdadr, 1),
 	),
-	TEST_CASE_BREDR("Bluetooth Create Bond PIN - Bad PIN",
+	TEST_CASE_BREDR_NOSSP("Bluetooth Create Bond PIN - Bad PIN",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -1033,7 +1033,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STARTED),
@@ -1056,7 +1055,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STARTED),
@@ -1080,7 +1078,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_create_bond_action,
 					&prop_test_remote_ble_bdaddr_req),
 		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
@@ -1098,7 +1095,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_create_bond_action, &prop_test_bdaddr_req),
 		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
 							&prop_test_bdaddr, 1),
@@ -1112,7 +1108,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STARTED),
@@ -1137,7 +1132,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_start_discovery_action, NULL),
 		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
 							BT_DISCOVERY_STARTED),
@@ -1168,7 +1162,6 @@ static struct test_case test_cases[] = {
 					&prop_test_scanmode_conn_discov),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scanmode_conn_discov, 1),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_io_cap, &no_input_no_output_io_cap),
 		ACTION_SUCCESS(emu_set_connect_cb_action, conn_cb),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
@@ -1189,7 +1182,6 @@ static struct test_case test_cases[] = {
 					&prop_test_scanmode_conn_discov),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scanmode_conn_discov, 1),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_io_cap, &no_input_no_output_io_cap),
 		ACTION_SUCCESS(emu_set_connect_cb_action, conn_cb),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 625d949..c042800 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -441,7 +441,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
@@ -456,7 +455,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
@@ -477,7 +475,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
@@ -503,7 +500,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
@@ -539,7 +535,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(bt_set_property_action,
 						&prop_test_scan_mode_conn),
@@ -567,7 +562,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(bt_set_property_action,
 						&prop_test_scan_mode_conn),
@@ -615,7 +609,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
@@ -640,7 +633,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
@@ -666,7 +658,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
@@ -690,7 +681,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
 		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 9ecef21..569ecd3 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -482,7 +482,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -503,7 +502,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -527,7 +525,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -551,7 +548,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 143b5a6..99bc146 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -516,7 +516,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -535,7 +534,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -553,7 +551,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -571,7 +568,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -588,7 +584,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -605,7 +600,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -623,7 +617,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -641,7 +634,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 							&l2cap_setup_sdp_data),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
@@ -657,7 +649,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action,
 						&l2cap_setup_keyboard_sdp_data),
diff --git a/android/tester-main.c b/android/tester-main.c
index 34a71ac..5266a08 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -282,12 +282,17 @@ static void index_added_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct test_case *test_steps = data->test_data;
+	struct bthost *bthost;
 
 	tester_print("Index Added callback");
 	tester_print("  Index: 0x%04x", index);
 
 	data->mgmt_index = index;
 
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_write_ssp_mode(bthost, test_steps->no_ssp_feat ? 0x00 : 0x01);
+
 	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
 					read_info_callback, NULL, NULL);
 }
@@ -1714,21 +1719,6 @@ void emu_set_pin_code_action(void)
 	schedule_action_verification(step);
 }
 
-void emu_set_ssp_mode_action(void)
-{
-	struct test_data *data = tester_get_data();
-	struct bthost *bthost;
-	struct step *step = g_new0(struct step, 1);
-
-	bthost = hciemu_client_get_host(data->hciemu);
-
-	bthost_write_ssp_mode(bthost, 0x01);
-
-	step->action_status = BT_STATUS_SUCCESS;
-
-	schedule_action_verification(step);
-}
-
 void emu_set_connect_cb_action(void)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 5fa4649..f3cfcb2 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -54,6 +54,14 @@
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
 
+ #define TEST_CASE_BREDR_NOSSP(text, ...) { \
+		HCIEMU_TYPE_BREDR, \
+		text, \
+		sizeof((struct step[]) {__VA_ARGS__}) / sizeof(struct step), \
+		(struct step[]) {__VA_ARGS__}, \
+		true, \
+	}
+
 #define TEST_CASE_BREDR(text, ...) { \
 		HCIEMU_TYPE_BREDR, \
 		text, \
@@ -61,6 +69,14 @@
 		(struct step[]) {__VA_ARGS__}, \
 	}
 
+#define TEST_CASE_BREDRLE_NOSSP(text, ...) { \
+		HCIEMU_TYPE_BREDRLE, \
+		text, \
+		sizeof((struct step[]) {__VA_ARGS__}) / sizeof(struct step), \
+		(struct step[]) {__VA_ARGS__}, \
+		true, \
+	}
+
 #define TEST_CASE_BREDRLE(text, ...) { \
 		HCIEMU_TYPE_BREDRLE, \
 		text, \
@@ -431,6 +447,8 @@ struct test_case {
 	const char *title;
 	const uint16_t step_num;
 	const struct step *step;
+
+	const bool no_ssp_feat;
 };
 
 /* Get, remove test cases API */
@@ -455,7 +473,6 @@ void schedule_action_verification(struct step *step);
 /* Emulator actions */
 void emu_setup_powered_remote_action(void);
 void emu_set_pin_code_action(void);
-void emu_set_ssp_mode_action(void);
 void emu_set_connect_cb_action(void);
 void emu_remote_connect_hci_action(void);
 void emu_remote_disconnect_hci_action(void);
diff --git a/android/tester-pan.c b/android/tester-pan.c
index 8d41d34..0cc2409 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (C) 2014 Intel Corporation
  *
@@ -151,7 +152,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(pan_connect_action, NULL),
 		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
@@ -176,7 +176,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(pan_connect_action, NULL),
 		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
@@ -202,7 +201,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
 		ACTION_SUCCESS(pan_connect_action, NULL),
 		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
diff --git a/android/tester-socket.c b/android/tester-socket.c
index c44fa28..672599d 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -403,7 +403,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_create_bond_action,
 						&prop_emu_remote_bdaddr_req),
 		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
@@ -427,7 +426,6 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(bt_create_bond_action,
 						&prop_emu_remote_bdaddr_req),
 		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
-- 
1.9.1

