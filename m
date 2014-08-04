Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/tester: Add Gatt Client connect cases
Date: Mon,  4 Aug 2014 12:53:35 +0200
Message-Id: <1407149616-2224-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds gatt connect cases.
---
 android/tester-gatt.c | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  62 +++++++++++++-
 android/tester-main.h |  21 +++++
 3 files changed, 299 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 2ee999c..c81b8da 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -21,7 +21,17 @@
 #include "tester-main.h"
 #include "src/shared/util.h"
 
+#define L2CAP_ATT_EXCHANGE_MTU_REQ		0x02
+#define L2CAP_ATT_EXCHANGE_MTU_RSP		0x03
+
+#define GATT_STATUS_SUCCESS	0x00000000
+#define GATT_STATUS_FAILURE	0x00000101
+
 #define CLIENT1_ID	1
+#define CLIENT2_ID	2
+
+#define CONN1_ID	1
+#define CONN2_ID	2
 
 static struct queue *list; /* List of gatt test cases */
 
@@ -30,6 +40,24 @@ static bt_uuid_t client_app_uuid = {
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
 };
 
+struct emu_cid_data {
+	const int pdu_len;
+	const void *pdu;
+
+	uint16_t handle;
+	uint16_t cid;
+};
+
+struct gatt_connect_data {
+	const int client_id;
+	const int conn_id;
+};
+
+static bt_uuid_t client2_app_uuid = {
+	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
+				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -38,6 +66,21 @@ static bt_property_t prop_emu_remotes_default_set[] = {
 						&emu_remote_bdaddr_val },
 };
 
+static struct emu_cid_data cid_data;
+
+static struct gatt_connect_data client1_conn_req = {
+	.client_id = CLIENT1_ID,
+	.conn_id = CONN1_ID,
+};
+
+static struct gatt_connect_data client2_conn_req = {
+	.client_id = CLIENT2_ID,
+	.conn_id = CONN2_ID,
+};
+
+static const uint8_t exchange_mtu_req_pdu[] = { 0x02, 0xa0, 0x02 };
+static const uint8_t exchange_mtu_resp_pdu[] = { 0x03, 0xa0, 0x02 };
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -91,6 +134,98 @@ static void gatt_client_stop_scan_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_client_connect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct gatt_connect_data *conn_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->connect(
+							conn_data->client_id,
+							&emu_remote_bdaddr_val,
+							0);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_client_disconnect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct gatt_connect_data *conn_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->disconnect(
+							conn_data->client_id,
+							&emu_remote_bdaddr_val,
+							conn_data->conn_id);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	struct emu_cid_data *cid_data = user_data;
+	const uint8_t *pdu = data;
+
+	switch (pdu[0]) {
+	case L2CAP_ATT_EXCHANGE_MTU_REQ:
+		tester_print("Exchange MTU request received.");
+
+		if (!memcmp(exchange_mtu_req_pdu, pdu, len))
+			bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
+						exchange_mtu_resp_pdu,
+						sizeof(exchange_mtu_resp_pdu));
+
+		break;
+	case L2CAP_ATT_EXCHANGE_MTU_RSP:
+		tester_print("Exchange MTU response received.");
+
+		break;
+	default:
+		tester_print("Unknown ATT packet.");
+
+		break;
+	}
+}
+
+static void gatt_conn_cb(uint16_t handle, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	tester_print("New connection with handle 0x%04x", handle);
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDR) {
+		tester_warn("Not handled device type.");
+		return;
+	}
+
+	cid_data.cid = 0x0004;
+	cid_data.handle = handle;
+
+	bthost_add_cid_hook(bthost, handle, cid_data.cid, gatt_cid_hook_cb,
+								&cid_data);
+}
+
+static void emu_set_connect_cb_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *current_data_step = queue_peek_head(data->steps);
+	void *cb = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_set_connect_cb(bthost, cb, data);
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -122,6 +257,89 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Connect",
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
+		ACTION_SUCCESS(gatt_client_connect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Gatt Client - Disconnect",
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
+		ACTION_SUCCESS(gatt_client_connect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(gatt_client_disconnect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Gatt Client - Multiple Client Conn./Disc.",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_register_action, &client2_app_uuid),
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
+		ACTION_SUCCESS(gatt_client_connect_action, &client2_conn_req),
+		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN2_ID, CLIENT2_ID),
+		ACTION_SUCCESS(gatt_client_disconnect_action,
+							&client2_conn_req),
+		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN2_ID, CLIENT2_ID),
+		ACTION_SUCCESS(gatt_client_disconnect_action,
+							&client1_conn_req),
+		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
+						prop_emu_remotes_default_set,
+						CONN1_ID, CLIENT1_ID),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index df608fc..e683150 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -455,6 +455,18 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.conn_id !=
+						step->callback_result.conn_id) {
+			tester_debug("Callback conn_id don't match");
+			return false;
+		}
+
+		if (exp->callback_result.client_id !=
+					step->callback_result.client_id) {
+				tester_debug("Callback client_id don't match");
+				return false;
+		}
+
 		if (exp->callback_result.properties &&
 				verify_property(exp->callback_result.properties,
 				exp->callback_result.num_properties,
@@ -895,11 +907,57 @@ static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
 	schedule_callback_call(step);
 }
 
+static void gattc_connect_cb(int conn_id, int status, int client_if,
+							bt_bdaddr_t *bda)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[1];
+
+	step->callback = CB_GATTC_OPEN;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.client_id = client_if;
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
+static void gattc_disconnect_cb(int conn_id, int status, int client_if,
+							bt_bdaddr_t *bda)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[1];
+
+	step->callback = CB_GATTC_CLOSE;
+	step->callback_result.status = status;
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.client_id = client_if;
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
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = gattc_scan_result_cb,
-	.open_cb = NULL,
-	.close_cb = NULL,
+	.open_cb = gattc_connect_cb,
+	.close_cb = gattc_disconnect_cb,
 	.search_complete_cb = NULL,
 	.search_result_cb = NULL,
 	.get_characteristic_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 9fb3034..778bdc4 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -127,6 +127,24 @@
 		.callback_result.adv_data = cb_adv_data, \
 	}
 
+#define CALLBACK_GATTC_CONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
+		.callback = CB_GATTC_OPEN, \
+		.callback_result.status = cb_res, \
+		.callback_result.properties = cb_prop, \
+		.callback_result.num_properties = 1, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.client_id = cb_client_id, \
+	}
+
+#define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id, cb_client_id) { \
+		.callback = CB_GATTC_CLOSE, \
+		.callback_result.status = cb_res, \
+		.callback_result.properties = cb_prop, \
+		.callback_result.num_properties = 1, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.client_id = cb_client_id, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -289,6 +307,9 @@ struct bt_callback_data {
 	int report_size;
 
 	bool adv_data;
+
+	int client_id;
+	int conn_id;
 };
 
 /*
-- 
1.9.1

