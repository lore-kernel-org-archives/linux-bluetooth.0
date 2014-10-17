Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] android/tester: Add GATT server send response to read req test cases
Date: Fri, 17 Oct 2014 15:38:18 +0200
Message-Id: <1413553099-19689-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds send response by server to read request test cases.
---
 android/tester-gatt.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  65 ++++++++++++++++++++-
 android/tester-main.h |  27 +++++++++
 3 files changed, 244 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 2ceb295..6655f2d 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -21,8 +21,12 @@
 #include "tester-main.h"
 #include "src/shared/util.h"
 
+#define ATT_HANDLE_SIZE	2
+
 #define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
 #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
+#define L2CAP_ATT_READ_REQ		0x0a
+#define L2CAP_ATT_READ_RSP		0x0b
 #define L2CAP_ATT_HANDLE_VALUE_NOTIFY	0x1b
 #define L2CAP_ATT_HANDLE_VALUE_IND	0x1d
 
@@ -39,6 +43,8 @@
 #define CONN1_ID	1
 #define CONN2_ID	2
 
+#define TRANS1_ID	1
+
 #define GATT_SERVER_TRANSPORT_LE		0x00
 #define GATT_SERVER_TRANSPORT_BREDR		0x01
 #define GATT_SERVER_TRANSPORT_LE_BREDR		0x02
@@ -52,6 +58,13 @@ static struct queue *list; /* List of gatt test cases */
 
 static int srvc1_handle;
 static int inc_srvc1_handle;
+static int char1_handle;
+
+struct set_att_data {
+	char *to;
+	char *from;
+	int len;
+};
 
 static bt_uuid_t app1_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
@@ -187,6 +200,13 @@ struct send_indication_data {
 	char *p_value;
 };
 
+struct send_resp_data {
+	int conn_id;
+	int trans_id;
+	int status;
+	btgatt_response_t *response;
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -746,6 +766,21 @@ static struct set_notify_params set_notify_param_2 = {
 	.bdaddr = &emu_remote_bdaddr_val
 };
 
+static btgatt_response_t response_1 = {
+	.handle = 0x1c,
+	.attr_value.auth_req = 0,
+	.attr_value.handle = 0x1d,
+	.attr_value.len = 0,
+	.attr_value.offset = 0,
+};
+
+static struct send_resp_data send_resp_data_1 = {
+	.conn_id = CONN1_ID,
+	.trans_id = TRANS1_ID,
+	.status = BT_STATUS_SUCCESS,
+	.response = &response_1,
+};
+
 static struct iovec search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -1056,6 +1091,36 @@ static struct iovec send_notification_1[] = {
 	end_pdu
 };
 
+/* att commands define raw pdus */
+static struct iovec att_read_req = raw_pdu(0x0a, 0x00, 0x00);
+
+static void gatt_att_pdu_modify(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct iovec *store_pdu = current_data_step->set_data_to;
+	struct step *step = g_new0(struct step, 1);
+	unsigned char *raw_pdu = store_pdu->iov_base;
+	int set_data_len = current_data_step->set_data_len;
+
+	switch (raw_pdu[0]) {
+	case L2CAP_ATT_READ_REQ: {
+		uint16_t handle = *((int *)current_data_step->set_data);
+
+		memcpy(raw_pdu + 1, &handle, set_data_len);
+		tester_debug("gatt: modify pdu read request handle to 0x%02x",
+									handle);
+
+		break;
+	}
+
+	default:
+		break;
+	}
+
+	schedule_action_verification(step);
+}
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1520,6 +1585,22 @@ static void gatt_server_send_indication_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_send_response_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct send_resp_data *send_resp_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->send_response(
+						send_resp_data->conn_id,
+						send_resp_data->trans_id,
+						send_resp_data->status,
+						send_resp_data->response);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -1559,6 +1640,14 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 		schedule_callback_verification(step);
 		break;
+	case L2CAP_ATT_READ_RSP:
+		/* TODO - More complicated cases should also verify pdu data */
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_READ_RESPONSE;
+
+		schedule_callback_verification(step);
+		break;
 	default:
 		if (!gatt_pdu || !gatt_pdu->iov_base) {
 			tester_print("Unknown ATT packet.");
@@ -1607,6 +1696,26 @@ static void gatt_remote_send_frame_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_remote_send_raw_pdu_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct iovec *pdu = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	if (cid_data.handle && cid_data.cid) {
+		bthost_send_cid_v(bthost, cid_data.handle, cid_data.cid,
+									pdu, 1);
+		step->action_status = BT_STATUS_SUCCESS;
+	} else {
+		tester_debug("No connection set up");
+		step->action_status = BT_STATUS_FAIL;
+	}
+
+	schedule_action_verification(step);
+}
+
 static void gatt_conn_cb(uint16_t handle, void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3247,6 +3356,50 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Send response to read char request",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_5),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_1),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
+							APP1_ID, &app1_uuid,
+							&srvc1_handle, NULL,
+							&char1_handle),
+		ACTION_SUCCESS(gatt_server_start_srvc_action,
+							&start_srvc_data_2),
+		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
+								&srvc1_handle),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		ACTION_SUCCESS(gatt_server_connect_action, &app1_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		MODIFY_DATA(GATT_STATUS_SUCCESS, gatt_att_pdu_modify,
+						&char1_handle, &att_read_req,
+						ATT_HANDLE_SIZE),
+		ACTION_SUCCESS(gatt_remote_send_raw_pdu_action, &att_read_req),
+		CALLBACK_GATTS_REQUEST_READ(CONN1_ID, TRANS1_ID,
+						prop_emu_remotes_default_set,
+						&char1_handle, 0, false),
+		ACTION_SUCCESS(gatt_server_send_response_action,
+							&send_resp_data_1),
+		CALLBACK(CB_EMU_READ_RESPONSE),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 1018cae..e9ebfdd 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -109,6 +109,7 @@ static struct {
 	DBG_CB(CB_EMU_CONNECTION_REJECTED),
 	DBG_CB(CB_EMU_VALUE_INDICATION),
 	DBG_CB(CB_EMU_VALUE_NOTIFICATION),
+	DBG_CB(CB_EMU_READ_RESPONSE),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
@@ -775,6 +776,16 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.attr_handle &&
+					step->callback_result.attr_handle)
+		if (*exp->callback_result.attr_handle !=
+					*step->callback_result.attr_handle) {
+			tester_debug("Gatt attribute handle mismatch: %d vs %d",
+					*step->callback_result.attr_handle,
+					*exp->callback_result.attr_handle);
+			return false;
+		}
+
 	if (exp->callback_result.srvc_handle &&
 					step->callback_result.srvc_handle)
 		if (*exp->callback_result.srvc_handle !=
@@ -803,6 +814,27 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+	if (exp->callback_result.trans_id != step->callback_result.trans_id) {
+		tester_debug("Gatt trans id mismatch: %d vs %d",
+						exp->callback_result.trans_id,
+						step->callback_result.trans_id);
+		return false;
+	}
+
+	if (exp->callback_result.offset != step->callback_result.offset) {
+		tester_debug("Gatt offset mismatch: %d vs %d",
+						exp->callback_result.offset,
+						step->callback_result.offset);
+		return false;
+	}
+
+	if (exp->callback_result.is_long != step->callback_result.is_long) {
+		tester_debug("Gatt is long attr value flag mismatch: %d vs %d",
+						exp->callback_result.is_long,
+						step->callback_result.is_long);
+		return false;
+	}
+
 	if (exp->store_srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
@@ -931,6 +963,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.desc_handle)
 		free(step->callback_result.desc_handle);
 
+	if (step->callback_result.attr_handle)
+		free(step->callback_result.attr_handle);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1652,6 +1687,34 @@ static void gatts_service_deleted_cb(int status, int server_if, int srvc_handle)
 	schedule_callback_verification(step);
 }
 
+static void gatts_request_read_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
+						int attr_handle, int offset,
+						bool is_long)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[1];
+
+	step->callback = CB_GATTS_REQUEST_READ;
+
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.trans_id = trans_id;
+	step->callback_result.attr_handle = g_memdup(&attr_handle,
+							sizeof(attr_handle));
+	step->callback_result.offset = offset;
+	step->callback_result.is_long = is_long;
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
+	schedule_callback_verification(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1782,7 +1845,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.service_started_cb = gatts_service_started_cb,
 	.service_stopped_cb = gatts_service_stopped_cb,
 	.service_deleted_cb = gatts_service_deleted_cb,
-	.request_read_cb = NULL,
+	.request_read_cb = gatts_request_read_cb,
 	.request_write_cb = NULL,
 	.request_exec_write_cb = NULL,
 	.response_confirmation_cb = NULL
diff --git a/android/tester-main.h b/android/tester-main.h
index 31d271a..e710a03 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -84,6 +84,14 @@ struct pdu_set {
 		(struct step[]) {__VA_ARGS__}, \
 	}
 
+#define MODIFY_DATA(status, modif_fun, from, to, len) { \
+		.action_status = status, \
+		.action = modif_fun, \
+		.set_data = from, \
+		.set_data_to = to, \
+		.set_data_len = len, \
+	}
+
 #define ACTION(status, act_fun, data_set) { \
 		.action_status = status, \
 		.action = act_fun, \
@@ -318,6 +326,19 @@ struct pdu_set {
 		.callback_result.srvc_handle = cb_srvc_handle, \
 	}
 
+#define CALLBACK_GATTS_REQUEST_READ(cb_conn_id, cb_trans_id, cb_prop, \
+						cb_attr_handle, cb_offset, \
+						cb_is_long) { \
+		.callback = CB_GATTS_REQUEST_READ, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.trans_id = cb_trans_id, \
+		.callback_result.properties = cb_prop, \
+		.callback_result.num_properties = 1, \
+		.callback_result.attr_handle = cb_attr_handle, \
+		.callback_result.offset = cb_offset, \
+		.callback_result.is_long = cb_is_long, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -471,6 +492,7 @@ typedef enum {
 	CB_EMU_CONNECTION_REJECTED,
 	CB_EMU_VALUE_INDICATION,
 	CB_EMU_VALUE_NOTIFICATION,
+	CB_EMU_READ_RESPONSE,
 } expected_bt_callback_t;
 
 struct test_data {
@@ -568,7 +590,11 @@ struct bt_callback_data {
 
 	int gatt_app_id;
 	int conn_id;
+	int trans_id;
+	int offset;
+	bool is_long;
 	int connected;
+	int *attr_handle;
 	int *srvc_handle;
 	int *inc_srvc_handle;
 	int *char_handle;
@@ -607,6 +633,7 @@ struct step {
 	struct bt_callback_data callback_result;
 
 	void *set_data;
+	void *set_data_to;
 	int set_data_len;
 
 	int *store_srvc_handle;
-- 
1.9.3

