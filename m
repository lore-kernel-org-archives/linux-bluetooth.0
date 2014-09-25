Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/tester: Make client and server id unified
Date: Thu, 25 Sep 2014 16:03:09 +0200
Message-Id: <1411653793-5254-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes unified id numers for both gatt server and client defined
as application id.
---
 android/tester-gatt.c | 328 +++++++++++++++++++++++++-------------------------
 android/tester-main.c |  12 +-
 android/tester-main.h |   6 +-
 3 files changed, 173 insertions(+), 173 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 5d18bf0..26470d5 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -28,8 +28,8 @@
 #define GATT_STATUS_FAILURE	0x00000101
 #define GATT_STATUS_INS_AUTH	0x08
 
-#define CLIENT1_ID	1
-#define CLIENT2_ID	2
+#define APP1_ID	1
+#define APP2_ID	2
 
 #define CONN1_ID	1
 #define CONN2_ID	2
@@ -51,7 +51,7 @@ struct pdu {
 	uint16_t size;
 };
 
-static bt_uuid_t client_app_uuid = {
+static bt_uuid_t app1_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
 };
@@ -65,7 +65,7 @@ struct emu_cid_data {
 };
 
 struct gatt_connect_data {
-	const int client_id;
+	const int app_id;
 	const int conn_id;
 };
 
@@ -141,18 +141,18 @@ static bt_property_t prop_test_scan_mode_conn = {
 
 static struct emu_cid_data cid_data;
 
-static struct gatt_connect_data client1_conn_req = {
-	.client_id = CLIENT1_ID,
+static struct gatt_connect_data app1_conn_req = {
+	.app_id = APP1_ID,
 	.conn_id = CONN1_ID,
 };
 
-static struct gatt_connect_data client1_conn2_req = {
-	.client_id = CLIENT1_ID,
+static struct gatt_connect_data app1_conn2_req = {
+	.app_id = APP1_ID,
 	.conn_id = CONN2_ID,
 };
 
-static struct gatt_connect_data client2_conn_req = {
-	.client_id = CLIENT2_ID,
+static struct gatt_connect_data app2_conn_req = {
+	.app_id = APP2_ID,
 	.conn_id = CONN2_ID,
 };
 
@@ -677,7 +677,7 @@ static void gatt_client_connect_action(void)
 	struct step *step = g_new0(struct step, 1);
 
 	step->action_status = data->if_gatt->client->connect(
-							conn_data->client_id,
+							conn_data->app_id,
 							&emu_remote_bdaddr_val,
 							0);
 
@@ -692,7 +692,7 @@ static void gatt_client_disconnect_action(void)
 	struct step *step = g_new0(struct step, 1);
 
 	step->action_status = data->if_gatt->client->disconnect(
-							conn_data->client_id,
+							conn_data->app_id,
 							&emu_remote_bdaddr_val,
 							conn_data->conn_id);
 
@@ -707,7 +707,7 @@ static void gatt_client_do_listen_action(void)
 	struct step *step = g_new0(struct step, 1);
 
 	step->action_status = data->if_gatt->client->listen(
-							conn_data->client_id,
+							conn_data->app_id,
 							1);
 
 	schedule_action_verification(step);
@@ -721,7 +721,7 @@ static void gatt_client_stop_listen_action(void)
 	struct step *step = g_new0(struct step, 1);
 
 	step->action_status = data->if_gatt->client->listen(
-							conn_data->client_id,
+							conn_data->app_id,
 							0);
 
 	schedule_action_verification(step);
@@ -1009,15 +1009,15 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
 	TEST_CASE_BREDRLE("Gatt Client - Register",
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 	),
 	TEST_CASE_BREDRLE("Gatt Client - Unregister",
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_unregister_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 	),
 	TEST_CASE_BREDRLE("Gatt Client - Scan",
@@ -1025,13 +1025,13 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -1041,17 +1041,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -1061,22 +1061,22 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -1086,33 +1086,33 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_register_action, &client2_app_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
-		ACTION_SUCCESS(gatt_client_connect_action, &client2_conn_req),
+						CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(gatt_client_connect_action, &app2_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN2_ID, CLIENT2_ID),
+						CONN2_ID, APP2_ID),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
-							&client2_conn_req),
+							&app2_conn_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN2_ID, CLIENT2_ID),
+						CONN2_ID, APP2_ID),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -1125,22 +1125,22 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bt_set_property_action,
 						&prop_test_scan_mode_conn),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
+		ACTION_SUCCESS(gatt_client_do_listen_action, &app1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, &bearer_type),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_stop_listen_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -1153,40 +1153,40 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bt_set_property_action,
 						&prop_test_scan_mode_conn),
 		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
-		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
+		ACTION_SUCCESS(gatt_client_do_listen_action, &app1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, &bearer_type),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_stop_listen_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		/* Close ACL on emulated remotes side so it can reconnect */
 		ACTION_SUCCESS(emu_remote_disconnect_hci_action,
 							&cid_data.handle),
 		CALLBACK_STATE(CB_BT_ACL_STATE_CHANGED,
 						BT_ACL_STATE_DISCONNECTED),
-		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
+		ACTION_SUCCESS(gatt_client_do_listen_action, &app1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, &bearer_type),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN2_ID, CLIENT1_ID),
+						CONN2_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
-							&client1_conn2_req),
+							&app1_conn2_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN2_ID, CLIENT1_ID),
+						CONN2_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_stop_listen_action,
-							&client1_conn_req),
+							&app1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
@@ -1198,17 +1198,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_RESULT(CONN1_ID, &service_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
@@ -1222,17 +1222,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_RESULT(CONN1_ID, &service_1),
 		CALLBACK_GATTC_SEARCH_RESULT(CONN1_ID, &service_2),
@@ -1247,17 +1247,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
@@ -1270,17 +1270,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1297,17 +1297,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_FAIL(gatt_client_get_characteristic_action,
@@ -1325,17 +1325,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1356,17 +1356,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1394,17 +1394,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1425,17 +1425,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_included_action,
@@ -1452,17 +1452,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_included_action,
@@ -1479,17 +1479,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_included_action,
@@ -1507,17 +1507,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1540,17 +1540,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1572,17 +1572,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1604,17 +1604,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1640,17 +1640,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1676,17 +1676,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1712,17 +1712,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1744,17 +1744,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1776,17 +1776,17 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
-		ACTION_SUCCESS(gatt_client_connect_action, &client1_conn_req),
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_client_connect_action, &app1_conn_req),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
-						CONN1_ID, CLIENT1_ID),
+						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
 		ACTION_SUCCESS(gatt_client_get_characteristic_action,
@@ -1808,13 +1808,13 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
 		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
 		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
-		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_start_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
 		ACTION_SUCCESS(gatt_client_stop_scan_action,
-							INT_TO_PTR(CLIENT1_ID)),
+							INT_TO_PTR(APP1_ID)),
 		ACTION_FAIL(gatt_client_write_characteristic_action,
 							&write_char_data_2),
 		CALLBACK_GATTC_WRITE_CHARACTERISTIC(GATT_STATUS_FAILURE,
diff --git a/android/tester-main.c b/android/tester-main.c
index 081a1ce..61a6bcd 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -534,10 +534,10 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
-		if (exp->callback_result.client_id !=
-					step->callback_result.client_id) {
-				tester_debug("Callback client_id don't match");
-				return false;
+		if (exp->callback_result.gatt_app_id !=
+					step->callback_result.gatt_app_id) {
+			tester_debug("Callback gatt_app_id don't match");
+			return false;
 		}
 
 		if (exp->callback_result.properties &&
@@ -1083,7 +1083,7 @@ static void gattc_connect_cb(int conn_id, int status, int client_if,
 	step->callback = CB_GATTC_OPEN;
 	step->callback_result.status = status;
 	step->callback_result.conn_id = conn_id;
-	step->callback_result.client_id = client_if;
+	step->callback_result.gatt_app_id = client_if;
 
 	/* Utilize property verification mechanism for bdaddr */
 	props[0] = create_property(BT_PROPERTY_BDADDR, bda, sizeof(*bda));
@@ -1106,7 +1106,7 @@ static void gattc_disconnect_cb(int conn_id, int status, int client_if,
 	step->callback = CB_GATTC_CLOSE;
 	step->callback_result.status = status;
 	step->callback_result.conn_id = conn_id;
-	step->callback_result.client_id = client_if;
+	step->callback_result.gatt_app_id = client_if;
 
 	/* Utilize property verification mechanism for bdaddr */
 	props[0] = create_property(BT_PROPERTY_BDADDR, bda, sizeof(*bda));
diff --git a/android/tester-main.h b/android/tester-main.h
index 6afc553..86291d8 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -132,7 +132,7 @@
 		.callback_result.properties = cb_prop, \
 		.callback_result.num_properties = 1, \
 		.callback_result.conn_id = cb_conn_id, \
-		.callback_result.client_id = cb_client_id, \
+		.callback_result.gatt_app_id = cb_client_id, \
 	}
 
 #define CALLBACK_GATTC_SEARCH_RESULT(cb_conn_id, cb_service) { \
@@ -209,7 +209,7 @@
 		.callback_result.properties = cb_prop, \
 		.callback_result.num_properties = 1, \
 		.callback_result.conn_id = cb_conn_id, \
-		.callback_result.client_id = cb_client_id, \
+		.callback_result.gatt_app_id = cb_client_id, \
 	}
 
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
@@ -440,7 +440,7 @@ struct bt_callback_data {
 
 	bool adv_data;
 
-	int client_id;
+	int gatt_app_id;
 	int conn_id;
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
-- 
1.9.3

