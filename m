Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/tester: Add GATT server connect successful test case
Date: Tue, 30 Sep 2014 13:23:45 +0200
Message-Id: <1412076227-32664-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412076227-32664-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412076227-32664-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will connect to powered on and visible device.
---
 android/tester-gatt.c | 38 ++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 33 ++++++++++++++++++++++++++++++++-
 android/tester-main.h | 10 ++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 67a09a5..a8b62c5 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -28,6 +28,9 @@
 #define GATT_STATUS_FAILURE	0x00000101
 #define GATT_STATUS_INS_AUTH	0x08
 
+#define GATT_SERVER_DISCONNECTED	0
+#define GATT_SERVER_CONNECTED		1
+
 #define APP1_ID	1
 #define APP2_ID	2
 
@@ -873,6 +876,21 @@ static void gatt_server_unregister_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_connect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct gatt_connect_data *conn_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->connect(
+							conn_data->app_id,
+							&emu_remote_bdaddr_val,
+							0);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -1875,6 +1893,26 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
 		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - LE Connect",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		ACTION_SUCCESS(gatt_server_connect_action, &app1_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index eaf5d34..8afb464 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -720,6 +720,14 @@ static bool match_data(struct step *step)
 		}
 	}
 
+	if (exp->callback_result.connected !=
+				step->callback_result.connected) {
+		tester_debug("Gatt server conn status mismatch: %d vs %d",
+						step->callback_result.connected,
+						exp->callback_result.connected);
+		return false;
+	}
+
 	return true;
 }
 
@@ -1372,6 +1380,29 @@ static void gatts_register_server_cb(int status, int server_if,
 	schedule_callback_call(step);
 }
 
+static void gatts_connection_cb(int conn_id, int server_if, int connected,
+							bt_bdaddr_t *bda)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[1];
+
+	step->callback = CB_GATTS_CONNECTION;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.gatt_app_id = server_if;
+	step->callback_result.connected = connected;
+
+	/* Utilize property verification mechanism for bdaddr */
+	props[0] = create_property(BT_PROPERTY_BDADDR, bda, sizeof(*bda));
+
+	step->callback_result.num_properties = 1;
+	step->callback_result.properties = repack_properties(1, props);
+
+	g_free(props[0]->val);
+	g_free(props[0]);
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1494,7 +1525,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.register_server_cb = gatts_register_server_cb,
-	.connection_cb = NULL,
+	.connection_cb = gatts_connection_cb,
 	.service_added_cb = NULL,
 	.included_service_added_cb = NULL,
 	.characteristic_added_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 7c55ca5..2f4e8df 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -212,6 +212,15 @@
 		.callback_result.gatt_app_id = cb_client_id, \
 	}
 
+#define CALLBACK_GATTS_CONNECTION(cb_res, cb_prop, cb_conn_id, cb_server_id) { \
+		.callback = CB_GATTS_CONNECTION, \
+		.callback_result.connected = cb_res, \
+		.callback_result.properties = cb_prop, \
+		.callback_result.num_properties = 1, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.gatt_app_id = cb_server_id, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -445,6 +454,7 @@ struct bt_callback_data {
 
 	int gatt_app_id;
 	int conn_id;
+	int connected;
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
 	btgatt_gatt_id_t *descriptor;
-- 
1.9.3

