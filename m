Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/5] android/tester: Add case for reconnecting HID keyboard device
Date: Fri,  3 Oct 2014 15:08:43 +0200
Message-Id: <1412341723-8415-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412341723-8415-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test case checks if we correctly raise security level for
reconnecting keyboard devices when previously paired.
---
 android/tester-hidhost.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c    |  1 +
 android/tester-main.h    |  1 +
 3 files changed, 94 insertions(+)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 24036ce..af340ea 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -43,6 +43,9 @@
 
 #define HID_EXPECTED_REPORT_SIZE	0x02
 
+#define HID_MSG_CONTROL			0x10
+#define HID_VIRTUAL_CABLE_UNPLUG	0x05
+
 static struct queue *list; /* List of hidhost test cases */
 
 #define did_req_pdu	0x06, \
@@ -261,6 +264,13 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 
 		schedule_callback_verification(step);
 		break;
+	case HID_MSG_CONTROL | HID_VIRTUAL_CABLE_UNPLUG:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_CONNECTION_REJECTED;
+
+		schedule_callback_verification(step);
+		break;
 	}
 }
 static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
@@ -306,6 +316,14 @@ static void hid_intr_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
 								cid_data);
 }
 
+static bt_scan_mode_t setprop_scan_mode_conn_val = BT_SCAN_MODE_CONNECTABLE;
+
+static bt_property_t prop_test_scan_mode_conn = {
+	.type = BT_PROPERTY_ADAPTER_SCAN_MODE,
+	.val = &setprop_scan_mode_conn_val,
+	.len = sizeof(setprop_scan_mode_conn_val),
+};
+
 /* Emulate SDP (PSM = 1) */
 static struct emu_set_l2cap_data l2cap_setup_sdp_data = {
 	.psm = 1,
@@ -450,6 +468,62 @@ static void hidhost_send_data_action(void)
 	schedule_action_verification(step);
 }
 
+static void client_l2cap_rsp(uint8_t code, const void *data, uint16_t len,
+							void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	struct emu_l2cap_cid_data *cid_data = user_data;
+	const uint16_t *psm = data;
+	const struct iovec con_req = raw_pdu(0x13, 0x00,	/* PSM */
+						0x41, 0x00);	/* Source CID */
+
+	if (len < sizeof(*psm)) {
+		tester_warn("Invalid l2cap response.");
+		return;
+	}
+
+	switch (*psm) {
+	case 0x40:
+		bthost_add_cid_hook(bthost, cid_data->handle, 0x40,
+						hid_ctrl_cid_hook_cb, cid_data);
+
+		bthost_l2cap_req(bthost, cid_data->handle, 0x02,
+					con_req.iov_base, con_req.iov_len,
+					client_l2cap_rsp, cid_data);
+		break;
+	case 0x41:
+		bthost_add_cid_hook(bthost, cid_data->handle, 0x41,
+						hid_intr_cid_hook_cb, cid_data);
+		break;
+	default:
+		break;
+	}
+}
+
+static void hidhost_conn_cb(uint16_t handle, void *user_data)
+{
+	const struct iovec con_req = raw_pdu(0x11, 0x00,	/* PSM */
+						0x40, 0x00);	/* Source CID */
+
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDR) {
+		tester_warn("Not handled device type.");
+		return;
+	}
+
+	ctrl_cid_data.cid = 0x40;
+	ctrl_cid_data.handle = handle;
+
+	tester_print("Sending L2CAP Request from remote");
+
+	bthost_l2cap_req(bthost, handle, 0x02, con_req.iov_base,
+					con_req.iov_len, client_l2cap_rsp,
+					&ctrl_cid_data);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -619,6 +693,24 @@ static struct test_case test_cases[] = {
 						BTHH_CONN_STATE_DISCONNECTED),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("HidHost Reject Unknown Remote Connection",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(bt_set_property_action,
+						&prop_test_scan_mode_conn),
+		CALLBACK_ADAPTER_PROPS(&prop_test_scan_mode_conn, 1),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+						&l2cap_setup_kb_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		/* Trigger incoming connection */
+		ACTION_SUCCESS(emu_set_connect_cb_action, hidhost_conn_cb),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		CALLBACK(CB_EMU_CONNECTION_REJECTED),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index d5ebe16..bb064b7 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -106,6 +106,7 @@ static struct {
 	DBG_CB(CB_EMU_CONFIRM_SEND_DATA),
 	DBG_CB(CB_EMU_ENCRYPTION_ENABLED),
 	DBG_CB(CB_EMU_ENCRYPTION_DISABLED),
+	DBG_CB(CB_EMU_CONNECTION_REJECTED),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
diff --git a/android/tester-main.h b/android/tester-main.h
index e96ad24..922f1cf 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -402,6 +402,7 @@ typedef enum {
 	CB_EMU_CONFIRM_SEND_DATA,
 	CB_EMU_ENCRYPTION_ENABLED,
 	CB_EMU_ENCRYPTION_DISABLED,
+	CB_EMU_CONNECTION_REJECTED,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.1

