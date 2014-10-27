Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/4] android/tester: Add AVRCP GetElementAttributes test case
Date: Mon, 27 Oct 2014 16:56:16 +0200
Message-Id: <1414421776-4029-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1414421776-4029-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1414421776-4029-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-avrcp.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c  | 26 +++++++++++++++
 android/tester-main.h  | 10 ++++++
 3 files changed, 121 insertions(+)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 06c2bd8..c78131e 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -25,6 +25,7 @@
 
 static struct queue *list;
 
+#define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
 #define AVRCP_GET_PLAY_STATUS		0x30
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 
@@ -90,6 +91,18 @@ static struct emu_l2cap_cid_data sdp_data = {
 			0x58, 0x31, 0x00, 0x00, 0x09, 0x02, 0xFF, 0xFF, \
 			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
 
+#define req_ele_attr 0x00, 0x11, 0x0e, 0x01, 0x48, 0x00, 0x00, 0x19, 0x58, \
+			0x20, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x00, \
+			0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x07
+
+#define rsp_ele_attr 0x02, 0x11, 0x0e, 0x0c, 0x48, 0x00, 0x00, 0x19, 0x58, \
+			0x20, 0x00, 0x00, 0x2a, 0x02, 0x00, 0x00, 0x00, 0x01, \
+			0x00, 0x6a, 0x00, 0x13, 0x47, 0x69, 0x76, 0x65, 0x20, \
+			0x50, 0x65, 0x61, 0x63, 0x65, 0x20, 0x61, 0x20, 0x43, \
+			0x68, 0x61, 0x6e, 0x63, 0x65, 0x00, 0x00, 0x00, 0x07, \
+			0x00, 0x6a, 0x00, 0x06, 0x31, 0x30, 0x33, 0x30, 0x30, \
+			0x30
+
 static const struct pdu_set pdus[] = {
 	{ raw_pdu(req_dsc), raw_pdu(rsp_dsc) },
 	{ raw_pdu(req_get), raw_pdu(rsp_get) },
@@ -107,6 +120,20 @@ static struct emu_l2cap_cid_data a2dp_data = {
 
 static struct emu_l2cap_cid_data avrcp_data;
 
+static btrc_element_attr_val_t ele_attrs[2] = {
+	{
+	.attr_id = BTRC_MEDIA_ATTR_TITLE,
+	.text = {0x47, 0x69, 0x76, 0x65, 0x20, 0x50, 0x65, 0x61, 0x63, 0x65, \
+		 0x20, 0x61, 0x20, 0x43, 0x68, 0x61, 0x6e, 0x63, 0x65}
+	},
+	{
+	.attr_id = BTRC_MEDIA_ATTR_PLAYING_TIME,
+	.text = {0x31, 0x30, 0x33, 0x30, 0x30, 0x30}
+	}
+};
+
+static btrc_element_attr_val_t exp_attrs[2];
+
 static void print_avrcp(const char *str, void *user_data)
 {
 	tester_debug("avrcp: %s", str);
@@ -138,6 +165,19 @@ static void avrcp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 			schedule_callback_verification(step);
 		}
 		break;
+	case AVRCP_GET_ELEMENT_ATTRIBUTES:
+		step = g_new0(struct step, 1);
+		step->callback = CB_AVRCP_GET_ATTR_RSP;
+		step->callback_result.num_of_attrs = ((uint8_t *) data)[13];
+
+		memset(exp_attrs, 0, 2 * sizeof(btrc_element_attr_val_t));
+		exp_attrs[0].attr_id = get_be16(data + 16);
+		memcpy(exp_attrs[0].text, data + 22, 19);
+		exp_attrs[1].attr_id = get_be16(data + 43);
+		memcpy(exp_attrs[1].text, data + 49, 6);
+		step->callback_result.attrs = exp_attrs;
+		schedule_callback_verification(step);
+		break;
 	}
 }
 
@@ -275,6 +315,29 @@ static void avrcp_reg_notif_track_changed_rsp(void)
 	schedule_action_verification(step);
 }
 
+static void avrcp_get_element_attributes_req(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	const struct iovec pdu = raw_pdu(req_ele_attr);
+	struct step *step = g_new0(struct step, 1);
+
+	bthost_send_cid_v(bthost, avrcp_data.handle, avrcp_data.cid, &pdu, 1);
+	step->action_status = BT_STATUS_SUCCESS;
+	schedule_action_verification(step);
+}
+
+static void avrcp_get_element_attributes_rsp(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_avrcp->get_element_attr_rsp(2,
+								ele_attrs);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("AVRCP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -362,6 +425,28 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("AVRCP GetElementAttributes - Success",
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
+		ACTION_SUCCESS(avrcp_get_element_attributes_req, NULL),
+		CALLBACK(CB_AVRCP_GET_ATTR_REQ),
+		ACTION_SUCCESS(avrcp_get_element_attributes_rsp, NULL),
+		CALLBACK_RC_GET_ELEMENT_ATTRIBUTES(CB_AVRCP_GET_ATTR_RSP, 2,
+								ele_attrs),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_avrcp_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index a416914..515c69e 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -700,6 +700,22 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.num_of_attrs !=
+					step->callback_result.num_of_attrs) {
+		tester_debug("Callback rc num of attrs mismatch");
+		return false;
+	}
+
+	if (exp->callback_result.attrs) {
+		if (memcmp(step->callback_result.attrs,
+				exp->callback_result.attrs,
+				exp->callback_result.num_of_attrs *
+				sizeof(btrc_element_attr_val_t))) {
+			tester_debug("Callback rc element attributes doesn't match");
+			return false;
+		}
+	}
+
 	if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 		tester_debug("Callback pairing result mismatch: %d vs %d",
@@ -1947,10 +1963,20 @@ static void avrcp_register_notification_cb(btrc_event_id_t event_id,
 	schedule_callback_verification(step);
 }
 
+static void avrcp_get_element_attr_cb(uint8_t num_attr,
+						btrc_media_attr_t *p_attrs)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_AVRCP_GET_ATTR_REQ;
+	schedule_callback_verification(step);
+}
+
 static btrc_callbacks_t btavrcp_callbacks = {
 	.size = sizeof(btavrcp_callbacks),
 	.get_play_status_cb = avrcp_get_play_status_cb,
 	.register_notification_cb = avrcp_register_notification_cb,
+	.get_element_attr_cb = avrcp_get_element_attr_cb,
 };
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index d46b262..ac310a3 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -409,6 +409,12 @@ struct pdu_set {
 		.callback_result.rc_index = cb_index, \
 	}
 
+#define CALLBACK_RC_GET_ELEMENT_ATTRIBUTES(cb, cb_num_of_attrs, cb_attrs) { \
+		.callback = cb, \
+		.callback_result.num_of_attrs = cb_num_of_attrs, \
+		.callback_result.attrs = cb_attrs, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -484,6 +490,8 @@ typedef enum {
 	CB_AVRCP_PLAY_STATUS_RSP,
 	CB_AVRCP_REG_NOTIF_REQ,
 	CB_AVRCP_REG_NOTIF_RSP,
+	CB_AVRCP_GET_ATTR_REQ,
+	CB_AVRCP_GET_ATTR_RSP,
 
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
@@ -666,6 +674,8 @@ struct bt_callback_data {
 	uint32_t song_position;
 	btrc_play_status_t play_status;
 	uint64_t rc_index;
+	uint8_t num_of_attrs;
+	btrc_element_attr_val_t *attrs;
 };
 
 /*
-- 
2.1.0

