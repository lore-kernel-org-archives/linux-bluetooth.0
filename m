Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 6/6] android/tester: Add Hidhost rejecting connection case
Date: Thu,  4 Sep 2014 14:55:01 +0200
Message-Id: <1409835301-12092-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409835301-12092-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case checks if hidhost rejects connections from
unknown devices.
---
 android/tester-hidhost.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 143b5a6..915c9a0 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -42,6 +42,9 @@
 #define HID_MODE_BREDR			0x01
 #define HID_MODE_LE			0x02
 
+#define HID_MSG_CONTROL			0x10
+#define HID_VIRTUAL_CABLE_UNPLUG	0x05
+
 #define HID_EXPECTED_REPORT_SIZE	0x02
 
 static struct queue *list; /* List of hidhost test cases */
@@ -209,6 +212,15 @@ static struct raw_dataset hid_keyboard_rsp_data = {
 	.len = sizeof(hid_keyboard_rsp_pdu),
 };
 
+static bt_scan_mode_t setprop_scan_mode_conn_val =
+					BT_SCAN_MODE_CONNECTABLE;
+
+static bt_property_t prop_test_scan_mode_conn = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &setprop_scan_mode_conn_val,
+	.len = sizeof(setprop_scan_mode_conn_val),
+};
+
 static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -280,6 +292,7 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 							void *user_data)
 {
 	struct emu_cid_data *cid_data = user_data;
+	struct test_data *t_data = tester_get_data();
 	uint8_t header = ((uint8_t *) data)[0];
 	struct step *step;
 
@@ -310,6 +323,14 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 
 		schedule_action_verification(step);
 		break;
+	case HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG:
+		if (t_data->expect_rejection) {
+			step = g_new0(struct step, 1);
+
+			step->action_status = BT_STATUS_SUCCESS;
+			schedule_action_verification(step);
+		}
+		break;
 	}
 }
 static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
@@ -508,6 +529,68 @@ static void hidhost_send_data_action(void)
 	}
 }
 
+static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
+							void *user_data)
+{
+	static const uint8_t con_req[] = { 0x13, 0x00,		/* PSM */
+						0x41, 0x00 };	/* Source CID */
+	const uint16_t *psm = data;
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+
+	if (len < sizeof(*psm)) {
+		tester_warn("Invalid l2cap response.");
+		return;
+	}
+
+	switch (*psm) {
+	case 0x40:
+		tester_print("Connected ctrl channel");
+
+		bthost_add_cid_hook(bthost, cid_data.ctrl_handle, 0x40,
+					hid_ctrl_cid_hook_cb, &cid_data);
+
+		cid_data.intr_handle = cid_data.ctrl_handle;
+
+		bthost_l2cap_req(bthost, cid_data.intr_handle, 0x02,
+					con_req, sizeof(con_req),
+					client_l2cap_rsp, &cid_data);
+		break;
+	case 0x41:
+		tester_print("Connected intr channel");
+
+		bthost_add_cid_hook(bthost, cid_data.intr_handle, 0x41,
+					hid_intr_cid_hook_cb, &cid_data);
+
+		break;
+	default:
+		break;
+	}
+}
+
+static void hidhost_conn_cb(uint16_t handle, void *user_data)
+{
+	static const uint8_t con_req[] = { 0x11, 0x00,		/* PSM */
+						0x40, 0x00 };	/* Source CID */
+
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDR) {
+		tester_warn("Not handled device type.");
+		return;
+	}
+
+	cid_data.ctrl_cid = 0x40;
+	cid_data.ctrl_handle = handle;
+
+	tester_print("Sending L2CAP Request from remote");
+
+	bthost_l2cap_req(bthost, handle, 0x02,
+					con_req, sizeof(con_req),
+					client_l2cap_rsp, &cid_data);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -653,6 +736,23 @@ static struct test_case test_cases[] = {
 						BTHH_CONN_STATE_CONNECTED),
 		ACTION_SUCCESS(hidhost_send_data_action, NULL),
 	),
+	TEST_CASE_BREDRLE("HidHost Reject Unknown Remote Connection",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action,
+						&prop_test_scan_mode_conn),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+						&l2cap_setup_keyboard_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		/* Trigger incoming connection */
+		ACTION_SUCCESS(emu_set_connect_cb_action, hidhost_conn_cb),
+		ACTION_SUCCESS(emu_remote_connect_hci_rejected_action, NULL),
+	),
 	TEST_CASE_BREDRLE("HidHost Encrypted Out. Conn. Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
-- 
1.9.1

