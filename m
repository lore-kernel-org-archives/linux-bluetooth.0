Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 7/7] android/tester: Add Hidhost rejecting connection case
Date: Tue,  9 Sep 2014 09:47:03 +0200
Message-Id: <1410248823-8975-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410248823-8975-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case checks if hidhost rejects connections from
unknown devices.
---
 android/tester-hidhost.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h    |  1 +
 2 files changed, 99 insertions(+)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index d5741f9..64945e8 100644
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
@@ -312,7 +324,13 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 
 		schedule_callback_verification(step);
 		break;
+	case HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_CONNECTION_REJECTED;
 
+		schedule_callback_verification(step);
+		break;
 	}
 }
 static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
@@ -500,6 +518,68 @@ static void hidhost_send_data_action(void)
 	schedule_action_verification(step);
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
@@ -647,6 +727,24 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(hidhost_send_data_action, NULL),
 		CALLBACK(CB_EMU_CONFIRM_SEND_DATA),
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
+		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		CALLBACK(CB_EMU_CONNECTION_REJECTED),
+	),
 	TEST_CASE_BREDRLE("HidHost Encrypted Out. Conn. Success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
diff --git a/android/tester-main.h b/android/tester-main.h
index c6c76d9..6f6e57f 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -311,6 +311,7 @@ typedef enum {
 	CB_EMU_CONFIRM_SEND_DATA,
 	CB_EMU_ENCRYPTION_ENABLED,
 	CB_EMU_ENCRYPTION_DISABLED,
+	CB_EMU_CONNECTION_REJECTED,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.1

