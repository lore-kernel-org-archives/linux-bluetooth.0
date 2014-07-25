Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/9] android/tester-ng: Add HIDHost get protocol case
Date: Fri, 25 Jul 2014 15:13:29 +0200
Message-Id: <1406294015-8172-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c    | 34 +++++++++++++++++++++++++++--
 android/tester-main.h    | 17 +++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index ac58636..c2ac0b9 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -37,6 +37,10 @@
 #define HID_GET_OUTPUT_REPORT		0x4a
 #define HID_GET_FEATURE_REPORT		0x4b
 
+#define HID_MODE_DEFAULT		0x00
+#define HID_MODE_BREDR			0x01
+#define HID_MODE_LE			0x02
+
 static struct queue *list; /* List of hidhost test cases */
 
 struct emu_cid_data {
@@ -77,6 +81,12 @@ static struct bt_action_data ssp_confirm_accept_reply = {
 	.accept = TRUE,
 };
 
+static struct bt_action_data prop_test_remote_ble_bdaddr_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDADDR,
+	.prop = &prop_emu_remote_bdadr,
+};
+
 static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
 			0x00, 0x00, /* Transaction id */
 			0x00, 0x0f, /* Req length */
@@ -332,6 +342,21 @@ static void hidhost_virtual_unplug_action(void)
 	schedule_action_verification(step);
 }
 
+static void hidhost_get_protocol_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	step->action_status = data->if_hid->get_protocol(&bdaddr,
+							BTHH_REPORT_MODE);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -420,6 +445,38 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
 						BTHH_CONN_STATE_DISCONNECTED),
 	),
+	TEST_CASE_BREDRLE("HidHost GetProtocol Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(bt_create_bond_action,
+					&prop_test_remote_ble_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 1),
+		CALLBACK_SSP_REQ(BT_SSP_VARIANT_PASSKEY_CONFIRMATION,
+					prop_emu_remotes_pin_req_set, 2),
+		ACTION_SUCCESS(bt_ssp_reply_accept_action,
+						&ssp_confirm_accept_reply),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+						&prop_emu_remote_bdadr, 1),
+		CALLBACK_DEVICE_PROPS(NULL, 0),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		ACTION_SUCCESS(hidhost_connect_action, NULL),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTING),
+		CALLBACK(CB_HH_HID_INFO),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hidhost_get_protocol_action, NULL),
+		CALLBACK_HH_MODE(CB_HH_PROTOCOL_MODE, BTHH_OK, HID_MODE_BREDR),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 4a7f2cd..efda577 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -431,6 +431,12 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.mode !=
+						step->callback_result.mode) {
+			tester_debug("Callback mode don't match");
+			return false;
+		}
+
 		if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 			tester_debug("Callback pairing result don't match");
@@ -791,11 +797,35 @@ static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
 	schedule_callback_call(step);
 }
 
+static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
+						bthh_status_t status,
+						bthh_protocol_mode_t mode)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HH_PROTOCOL_MODE;
+	step->callback_result.status = status;
+	step->callback_result.mode = mode;
+
+	/* TODO: add bdaddr to verify? */
+
+	schedule_callback_call(step);
+}
+
+static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HH_HID_INFO;
+
+	schedule_callback_call(step);
+}
+
 static bthh_callbacks_t bthh_callbacks = {
 	.size = sizeof(bthh_callbacks),
 	.connection_state_cb = hidhost_connection_state_cb,
-	.hid_info_cb = NULL,
-	.protocol_mode_cb = NULL,
+	.hid_info_cb = hidhost_hid_info_cb,
+	.protocol_mode_cb = hidhost_protocol_mode_cb,
 	.idle_time_cb = NULL,
 	.get_report_cb = NULL,
 	.virtual_unplug_cb = hidhost_virual_unplug_cb
diff --git a/android/tester-main.h b/android/tester-main.h
index e2ecaab..eebcc1e 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -82,11 +82,20 @@
 		.set_data = data_set, \
 	}
 
+#define CALLBACK(cb) { \
+		.callback = cb, \
+	}
+
 #define CALLBACK_STATE(cb, cb_res) { \
 		.callback = cb, \
 		.callback_result.state = cb_res, \
 	}
 
+#define CALLBACK_STATUS(cb, cb_res) { \
+		.callback = cb, \
+		.callback_result.status = cb_res, \
+	}
+
 #define CALLBACK_ADAPTER_PROPS(props, prop_cnt) { \
 		.callback = CB_BT_ADAPTER_PROPERTIES, \
 		.callback_result.properties = props, \
@@ -99,6 +108,12 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
+#define CALLBACK_HH_MODE(cb, cb_res, cb_mode) { \
+		.callback = cb, \
+		.callback_result.status = cb_res, \
+		.callback_result.mode = cb_mode, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -253,6 +268,8 @@ struct bt_callback_data {
 	bt_property_t *properties;
 
 	bt_ssp_variant_t pairing_variant;
+
+	bthh_protocol_mode_t mode;
 };
 
 /*
-- 
1.9.1

