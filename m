Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/tester: Add Gatt Client Listen cases
Date: Mon,  4 Aug 2014 12:53:36 +0200
Message-Id: <1407149616-2224-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  12 ++++-
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index c81b8da..d69b027 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -66,6 +66,15 @@ static bt_property_t prop_emu_remotes_default_set[] = {
 						&emu_remote_bdaddr_val },
 };
 
+static bt_scan_mode_t setprop_scan_mode_conn_val =
+					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
+
+static bt_property_t prop_test_scan_mode_conn = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &setprop_scan_mode_conn_val,
+	.len = sizeof(setprop_scan_mode_conn_val),
+};
+
 static struct emu_cid_data cid_data;
 
 static struct gatt_connect_data client1_conn_req = {
@@ -73,6 +82,11 @@ static struct gatt_connect_data client1_conn_req = {
 	.conn_id = CONN1_ID,
 };
 
+static struct gatt_connect_data client1_conn2_req = {
+	.client_id = CLIENT1_ID,
+	.conn_id = CONN2_ID,
+};
+
 static struct gatt_connect_data client2_conn_req = {
 	.client_id = CLIENT2_ID,
 	.conn_id = CONN2_ID,
@@ -164,6 +178,34 @@ static void gatt_client_disconnect_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_do_listen_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct gatt_connect_data *conn_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->listen(
+							conn_data->client_id,
+							1);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_client_stop_listen_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct gatt_connect_data *conn_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->listen(
+							conn_data->client_id,
+							0);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -226,6 +268,24 @@ static void emu_set_connect_cb_action(void)
 	schedule_action_verification(step);
 }
 
+static void emu_remote_connect_hci_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	const uint8_t *master_addr;
+
+	master_addr = hciemu_get_master_bdaddr(data->hciemu);
+
+	tester_print("Trying to connect hci");
+
+	bthost_hci_connect(bthost, master_addr, BDADDR_LE_PUBLIC);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -340,6 +400,76 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Listen and Disconnect",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(bt_set_property_action,
+						&prop_test_scan_mode_conn),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_stop_listen_action,
+							&client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_disconnect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Gatt Client - Double Listen",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(bt_set_property_action,
+						&prop_test_scan_mode_conn),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_stop_listen_action,
+							&client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_disconnect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN2_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_disconnect_action,
+							&client1_conn2_req),
+		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN2_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_stop_listen_action,
+							&client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index e683150..ba1ae9f 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -953,6 +953,16 @@ static void gattc_disconnect_cb(int conn_id, int status, int client_if,
 	schedule_callback_call(step);
 }
 
+static void gattc_listen_cb(int status, int server_if)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_LISTEN;
+	step->callback_result.status = status;
+
+	schedule_callback_call(step);
+}
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = gattc_scan_result_cb,
@@ -971,7 +981,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.write_descriptor_cb = NULL,
 	.execute_write_cb = NULL,
 	.read_remote_rssi_cb = NULL,
-	.listen_cb = NULL
+	.listen_cb = gattc_listen_cb
 };
 
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
-- 
1.9.1

