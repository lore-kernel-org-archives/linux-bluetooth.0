Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/2] android/tester: Add AVRCP RegNotifPlayStatusChanged test case
Date: Tue,  2 Dec 2014 11:53:13 +0200
Message-Id: <1417513993-21189-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1417513993-21189-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1417513993-21189-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-avrcp.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h  |  5 ++++
 2 files changed, 67 insertions(+)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 10cf1b6..41a5fd3 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -98,6 +98,12 @@ static struct emu_l2cap_cid_data sdp_data = {
 				0x58, 0x31, 0x00, 0x00, 0x04, 0x05, 0xFF, \
 							0xFF, 0xFF, 0xFF
 
+#define req_status_notif 0x00, 0x11, 0x0e, 0x03, 0x48, 0x00, 0x00, 0x19, \
+				0x58, 0x31, 0x00, 0x00, 0x05, 0x01, 0x00, \
+							0x00, 0x00, 0x00
+
+#define rsp_status_notif 0x00, 0x11, 0x0e, 0x0D, 0x48, 0x00, 0x00, 0x19, \
+				0x58, 0x31, 0x00, 0x00, 0x01, 0x01, 0x00
 
 #define req_ele_attr 0x00, 0x11, 0x0e, 0x01, 0x48, 0x00, 0x00, 0x19, 0x58, \
 			0x20, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x00, \
@@ -167,6 +173,14 @@ static void avrcp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	case AVRCP_REGISTER_NOTIFICATION:
 		event = ((uint8_t *) data)[13];
 		switch (event) {
+		case 0x01:
+			step = g_new0(struct step, 1);
+			step->callback = CB_AVRCP_REG_NOTIF_RSP;
+			step->callback_result.play_status =
+							((uint8_t *) data)[14];
+			schedule_callback_verification(step);
+			break;
+
 		case 0x02:
 			step = g_new0(struct step, 1);
 			step->callback = CB_AVRCP_REG_NOTIF_RSP;
@@ -359,6 +373,32 @@ static void avrcp_reg_notif_play_position_changed_rsp(void)
 	schedule_action_verification(step);
 }
 
+static void avrcp_reg_notif_play_status_changed_req(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	const struct iovec pdu = raw_pdu(req_status_notif);
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_send_cid_v(bthost, avrcp_data.handle, avrcp_data.cid, &pdu, 1);
+	step->action_status = BT_STATUS_SUCCESS;
+	schedule_action_verification(step);
+}
+
+static void avrcp_reg_notif_play_status_changed_rsp(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+	btrc_register_notification_t reg;
+
+	reg.play_status = BTRC_PLAYSTATE_STOPPED;
+	step->action_status = data->if_avrcp->register_notification_rsp(
+						BTRC_EVT_PLAY_STATUS_CHANGED,
+					BTRC_NOTIFICATION_TYPE_CHANGED, &reg);
+
+	schedule_action_verification(step);
+}
+
 static void avrcp_get_element_attributes_req(void)
 {
 	struct test_data *data = tester_get_data();
@@ -491,6 +531,28 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("AVRCP RegNotifPlayStatusChanged - Success",
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
+		ACTION_SUCCESS(avrcp_reg_notif_play_status_changed_req, NULL),
+		CALLBACK(CB_AVRCP_REG_NOTIF_REQ),
+		ACTION_SUCCESS(avrcp_reg_notif_play_status_changed_rsp, NULL),
+		CALLBACK_RC_REG_NOTIF_STATUS_CHANGED(CB_AVRCP_REG_NOTIF_RSP,
+									0x00),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 	TEST_CASE_BREDRLE("AVRCP GetElementAttributes - Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
diff --git a/android/tester-main.h b/android/tester-main.h
index 1a779a2..4407514 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -414,6 +414,11 @@ struct pdu_set {
 		.callback_result.song_position = cb_position, \
 	}
 
+#define CALLBACK_RC_REG_NOTIF_STATUS_CHANGED(cb, cb_status) { \
+		.callback = cb, \
+		.callback_result.play_status = cb_status, \
+	}
+
 #define CALLBACK_RC_GET_ELEMENT_ATTRIBUTES(cb, cb_num_of_attrs, cb_attrs) { \
 		.callback = cb, \
 		.callback_result.num_of_attrs = cb_num_of_attrs, \
-- 
2.1.0

