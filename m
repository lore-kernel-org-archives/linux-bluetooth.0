Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/4] android/tester: Add AVRCP GetPlayStatus test case
Date: Mon, 27 Oct 2014 16:56:14 +0200
Message-Id: <1414421776-4029-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1414421776-4029-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1414421776-4029-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-avrcp.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c  | 33 ++++++++++++++++++++++++
 android/tester-main.h  | 14 ++++++++++
 3 files changed, 116 insertions(+)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 192a48e..5a66910 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -25,6 +25,8 @@
 
 static struct queue *list;
 
+#define AVRCP_GET_PLAY_STATUS		0x30
+
 #define sdp_rsp_pdu	0x07, \
 			0x00, 0x00, \
 			0x00, 0x7f, \
@@ -73,6 +75,12 @@ static struct emu_l2cap_cid_data sdp_data = {
 #define req_suspend 0x50, 0x09, 0x04
 #define rsp_suspend 0x52, 0x09
 
+#define req_play_status 0x00, 0x11, 0x0e, 0x01, 0x48, 0x00, 0x00, 0x19, \
+			0x58, 0x30, 0x00, 0x00, 0x00
+#define rsp_play_status 0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00, 0x00, 0x19, \
+			0x58, 0x30, 0x00, 0x00, 0x09, 0xbb, 0xbb, 0xbb, \
+			0xbb, 0xaa, 0xaa, 0xaa, 0xaa, 0x00
+
 static const struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
 	{ raw_pdu(req_get), raw_pdu(rsp_get) },
@@ -97,7 +105,22 @@ static void print_avrcp(const char *str, void *user_data)
 
 static void avrcp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
+	struct step *step;
+	uint8_t pdu;
+
 	util_hexdump('>', data, len, print_avrcp, NULL);
+
+	pdu = ((uint8_t *) data)[9];
+	switch (pdu) {
+	case AVRCP_GET_PLAY_STATUS:
+		step = g_new0(struct step, 1);
+		step->callback = CB_AVRCP_PLAY_STATUS_RSP;
+		step->callback_result.song_length = get_be32(data + 13);
+		step->callback_result.song_position = get_be32(data + 17);
+		step->callback_result.play_status = ((uint8_t *) data)[21];
+		schedule_callback_verification(step);
+		break;
+	}
 }
 
 static void avrcp_connect_request_cb(uint16_t handle, uint16_t cid,
@@ -129,6 +152,8 @@ static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
 
 	cid_data->handle = handle;
 	cid_data->cid = cid;
+	avrcp_data.handle = handle;
+	avrcp_data.cid = cid;
 
 	tester_handle_l2cap_data_exchange(cid_data);
 }
@@ -182,6 +207,28 @@ static void avrcp_disconnect_action(void)
 	schedule_action_verification(step);
 }
 
+static void avrcp_get_play_status_req(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	const struct iovec pdu = raw_pdu(req_play_status);
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_send_cid_v(bthost, avrcp_data.handle, avrcp_data.cid, &pdu, 1);
+	step->action_status = BT_STATUS_SUCCESS;
+	schedule_action_verification(step);
+}
+
+static void avrcp_get_play_status_rsp(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_avrcp->get_play_status_rsp(0x00,
+						0xbbbbbbbb, 0xaaaaaaaa);
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("AVRCP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -225,6 +272,28 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("AVRCP GetPlayStatus - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &sdp_setup_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &a2dp_setup_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &avrcp_setup_data),
+		ACTION_SUCCESS(avrcp_connect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_CONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_CONNECTED),
+		ACTION_SUCCESS(avrcp_get_play_status_req, NULL),
+		CALLBACK(CB_AVRCP_PLAY_STATUS_REQ),
+		ACTION_SUCCESS(avrcp_get_play_status_rsp, NULL),
+		CALLBACK_RC_PLAY_STATUS(CB_AVRCP_PLAY_STATUS_RSP, 0xbbbbbbbb,
+							0xaaaaaaaa, 0x00),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_avrcp_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 8cf62c2..7b1e4d8 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -670,6 +670,30 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.song_length !=
+					step->callback_result.song_length) {
+		tester_debug("Callback song_length mismatch: 0x%x vs 0x%x",
+					step->callback_result.song_length,
+					exp->callback_result.song_length);
+		return false;
+	}
+
+	if (exp->callback_result.song_position !=
+					step->callback_result.song_position) {
+		tester_debug("Callback song_position mismatch: 0x%x vs 0x%x",
+					step->callback_result.song_position,
+					exp->callback_result.song_position);
+		return false;
+	}
+
+	if (exp->callback_result.play_status !=
+					step->callback_result.play_status) {
+		tester_debug("Callback play_status mismatch: 0x%x vs 0x%x",
+					step->callback_result.play_status,
+					exp->callback_result.play_status);
+		return false;
+	}
+
 	if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 		tester_debug("Callback pairing result mismatch: %d vs %d",
@@ -1900,8 +1924,17 @@ static btav_callbacks_t bta2dp_callbacks = {
 	.audio_state_cb = a2dp_audio_state_cb,
 };
 
+static void avrcp_get_play_status_cb(void)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_AVRCP_PLAY_STATUS_REQ;
+	schedule_callback_verification(step);
+}
+
 static btrc_callbacks_t btavrcp_callbacks = {
 	.size = sizeof(btavrcp_callbacks),
+	.get_play_status_cb = avrcp_get_play_status_cb,
 };
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index ff6e43c..7301501 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -397,6 +397,13 @@ struct pdu_set {
 		.callback_result.av_audio_state = cb_av_audio_state, \
 	}
 
+#define CALLBACK_RC_PLAY_STATUS(cb, cb_length, cb_position, cb_status) { \
+		.callback = cb, \
+		.callback_result.song_length = cb_length, \
+		.callback_result.song_position = cb_position, \
+		.callback_result.play_status = cb_status, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -467,6 +474,10 @@ typedef enum {
 	CB_A2DP_CONN_STATE,
 	CB_A2DP_AUDIO_STATE,
 
+	/* AVRCP */
+	CB_AVRCP_PLAY_STATUS_REQ,
+	CB_AVRCP_PLAY_STATUS_RSP,
+
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
 	CB_GATTC_SCAN_RESULT,
@@ -644,6 +655,9 @@ struct bt_callback_data {
 
 	btav_connection_state_t av_conn_state;
 	btav_audio_state_t av_audio_state;
+	uint32_t song_length;
+	uint32_t song_position;
+	btrc_play_status_t play_status;
 };
 
 /*
-- 
2.1.0

