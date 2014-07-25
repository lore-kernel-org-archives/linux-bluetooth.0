Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/9] android/tester-ng: Add HIDHost get report case
Date: Fri, 25 Jul 2014 15:13:31 +0200
Message-Id: <1406294015-8172-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406294015-8172-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c    | 21 +++++++++++++++++++-
 android/tester-main.h    | 10 ++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index d4640a4..d000a31 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -41,6 +41,8 @@
 #define HID_MODE_BREDR			0x01
 #define HID_MODE_LE			0x02
 
+#define HID_EXPECTED_REPORT_SIZE	0x02
+
 static struct queue *list; /* List of hidhost test cases */
 
 struct emu_cid_data {
@@ -372,6 +374,22 @@ static void hidhost_set_protocol_action(void)
 	schedule_action_verification(step);
 }
 
+static void hidhost_get_report_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	step->action_status = data->if_hid->get_report(&bdaddr,
+							BTHH_INPUT_REPORT, 1,
+							20);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -524,6 +542,39 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(hidhost_set_protocol_action, NULL),
 		CALLBACK_HH_MODE(CB_HH_PROTOCOL_MODE, BTHH_OK, HID_MODE_BREDR),
 	),
+	TEST_CASE_BREDRLE("HidHost GetReport Success",
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
+		ACTION_SUCCESS(hidhost_get_report_action, NULL),
+		CALLBACK_HHREPORT(CB_HH_GET_REPORT, BTHH_OK,
+						HID_EXPECTED_REPORT_SIZE),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index efda577..a01a010 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -437,6 +437,12 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.report_size !=
+					step->callback_result.report_size) {
+			tester_debug("Callback report size don't match");
+			return false;
+		}
+
 		if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 			tester_debug("Callback pairing result don't match");
@@ -821,13 +827,26 @@ static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
 	schedule_callback_call(step);
 }
 
+static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
+						uint8_t *report, int size)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HH_GET_REPORT;
+
+	step->callback_result.status = status;
+	step->callback_result.report_size = size;
+
+	schedule_callback_call(step);
+}
+
 static bthh_callbacks_t bthh_callbacks = {
 	.size = sizeof(bthh_callbacks),
 	.connection_state_cb = hidhost_connection_state_cb,
 	.hid_info_cb = hidhost_hid_info_cb,
 	.protocol_mode_cb = hidhost_protocol_mode_cb,
 	.idle_time_cb = NULL,
-	.get_report_cb = NULL,
+	.get_report_cb = hidhost_get_report_cb,
 	.virtual_unplug_cb = hidhost_virual_unplug_cb
 };
 
diff --git a/android/tester-main.h b/android/tester-main.h
index eebcc1e..b70d193 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -114,6 +114,12 @@
 		.callback_result.mode = cb_mode, \
 	}
 
+#define CALLBACK_HHREPORT(cb, cb_res, cb_rep_size) { \
+		.callback = cb, \
+		.callback_result.status = cb_res, \
+		.callback_result.report_size = cb_rep_size, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -247,6 +253,9 @@ struct bt_action_data {
 	const char *service_name;
 	const int flags;
 	int *fd;
+
+	/* HidHost params */
+	const int report_size;
 };
 
 /* bthost's l2cap server setup parameters */
@@ -270,6 +279,7 @@ struct bt_callback_data {
 	bt_ssp_variant_t pairing_variant;
 
 	bthh_protocol_mode_t mode;
+	int report_size;
 };
 
 /*
-- 
1.9.1

