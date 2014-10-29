Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/4] android/tester: Add AVRCP RegNotifTrackChanged test case
Date: Wed, 29 Oct 2014 14:13:31 +0200
Message-Id: <1414584812-7477-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1414584812-7477-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1414584812-7477-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-avrcp.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c  | 16 ++++++++++++
 android/tester-main.h  |  8 ++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index c01f5b7..dda8eb2 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -26,6 +26,7 @@
 static struct queue *list;
 
 #define AVRCP_GET_PLAY_STATUS		0x30
+#define AVRCP_REGISTER_NOTIFICATION	0x31
 
 #define sdp_rsp_pdu	0x07, \
 			0x00, 0x00, \
@@ -81,6 +82,13 @@ static struct emu_l2cap_cid_data sdp_data = {
 			0x30, 0x00, 0x00, 0x09, 0xbb, 0xbb, 0xbb, 0xbb, 0xaa, \
 							0xaa, 0xaa, 0xaa, 0x00
 
+#define req_track_notif 0x00, 0x11, 0x0e, 0x03, 0x48, 0x00, 0x00, 0x19, 0x58, \
+			0x31, 0x00, 0x00, 0x05, 0x02, 0x00, 0x00, 0x00, 0x00
+
+#define rsp_track_notif 0x00, 0x11, 0x0e, 0x0F, 0x48, 0x00, 0x00, 0x19, 0x58, \
+			0x31, 0x00, 0x00, 0x09, 0x02, 0xFF, 0xFF, 0xFF, 0xFF, \
+							0xFF, 0xFF, 0xFF, 0xFF
+
 static const struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
 	{ raw_pdu(req_get), raw_pdu(rsp_get) },
@@ -106,7 +114,7 @@ static void print_avrcp(const char *str, void *user_data)
 static void avrcp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct step *step;
-	uint8_t pdu;
+	uint8_t pdu, event;
 
 	util_hexdump('>', data, len, print_avrcp, NULL);
 
@@ -120,6 +128,15 @@ static void avrcp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 		step->callback_result.play_status = ((uint8_t *) data)[21];
 		schedule_callback_verification(step);
 		break;
+	case AVRCP_REGISTER_NOTIFICATION:
+		event = ((uint8_t *) data)[13];
+		if (event == 0x02) {
+			step = g_new0(struct step, 1);
+			step->callback = CB_AVRCP_REG_NOTIF_RSP;
+			step->callback_result.rc_index = get_be64(data + 14);
+			schedule_callback_verification(step);
+		}
+		break;
 	}
 }
 
@@ -229,6 +246,34 @@ static void avrcp_get_play_status_rsp(void)
 	schedule_action_verification(step);
 }
 
+static void avrcp_reg_notif_track_changed_req(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	const struct iovec pdu = raw_pdu(req_track_notif);
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_send_cid_v(bthost, avrcp_data.handle, avrcp_data.cid, &pdu, 1);
+	step->action_status = BT_STATUS_SUCCESS;
+	schedule_action_verification(step);
+}
+
+static void avrcp_reg_notif_track_changed_rsp(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+	uint64_t track;
+	btrc_register_notification_t reg;
+
+	track = 0xffffffffffffffff;
+	memcpy(reg.track, &track, sizeof(btrc_uid_t));
+	step->action_status = data->if_avrcp->register_notification_rsp(
+							BTRC_EVT_TRACK_CHANGE,
+					BTRC_NOTIFICATION_TYPE_INTERIM, &reg);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("AVRCP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -294,6 +339,28 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("AVRCP RegNotifTrackChanged - Success",
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
+		ACTION_SUCCESS(avrcp_reg_notif_track_changed_req, NULL),
+		CALLBACK(CB_AVRCP_REG_NOTIF_REQ),
+		ACTION_SUCCESS(avrcp_reg_notif_track_changed_rsp, NULL),
+		CALLBACK_RC_REG_NOTIF_TRACK_CHANGED(CB_AVRCP_REG_NOTIF_RSP,
+							0xffffffffffffffff),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_avrcp_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 7b1e4d8..a416914 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -694,6 +694,12 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.rc_index !=
+					step->callback_result.rc_index) {
+		tester_debug("Callback rc_index mismatch");
+		return false;
+	}
+
 	if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 		tester_debug("Callback pairing result mismatch: %d vs %d",
@@ -1932,9 +1938,19 @@ static void avrcp_get_play_status_cb(void)
 	schedule_callback_verification(step);
 }
 
+static void avrcp_register_notification_cb(btrc_event_id_t event_id,
+								uint32_t param)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_AVRCP_REG_NOTIF_REQ;
+	schedule_callback_verification(step);
+}
+
 static btrc_callbacks_t btavrcp_callbacks = {
 	.size = sizeof(btavrcp_callbacks),
 	.get_play_status_cb = avrcp_get_play_status_cb,
+	.register_notification_cb = avrcp_register_notification_cb,
 };
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index 7301501..d46b262 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -404,6 +404,11 @@ struct pdu_set {
 		.callback_result.play_status = cb_status, \
 	}
 
+#define CALLBACK_RC_REG_NOTIF_TRACK_CHANGED(cb, cb_index) { \
+		.callback = cb, \
+		.callback_result.rc_index = cb_index, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -477,6 +482,8 @@ typedef enum {
 	/* AVRCP */
 	CB_AVRCP_PLAY_STATUS_REQ,
 	CB_AVRCP_PLAY_STATUS_RSP,
+	CB_AVRCP_REG_NOTIF_REQ,
+	CB_AVRCP_REG_NOTIF_RSP,
 
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
@@ -658,6 +665,7 @@ struct bt_callback_data {
 	uint32_t song_length;
 	uint32_t song_position;
 	btrc_play_status_t play_status;
+	uint64_t rc_index;
 };
 
 /*
-- 
2.1.0

