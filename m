Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/8] android/tester: Add PAN Disconnect test case
Date: Tue,  5 Aug 2014 14:19:09 +0300
Message-Id: <1407237554-5079-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index df0e4ec..848cc83 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -78,6 +78,20 @@ static void pan_connect_action(void)
 	schedule_action_verification(step);
 }
 
+static void pan_disconnect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *pan_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) pan_addr, &bdaddr);
+
+	step->action_status = data->if_pan->disconnect(&bdaddr);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("PAN Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -106,6 +120,32 @@ static struct test_case test_cases[] = {
 					BTPAN_ROLE_PANU, BTPAN_ROLE_PANNAP),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("PAN Disconnect - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
+		ACTION_SUCCESS(pan_connect_action, NULL),
+		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
+					BT_STATUS_SUCCESS,
+					BTPAN_STATE_CONNECTING,
+					BTPAN_ROLE_PANU, BTPAN_ROLE_PANNAP),
+		CALLBACK_PAN_CTRL_STATE(CB_PAN_CONTROL_STATE, BT_STATUS_SUCCESS,
+					BTPAN_STATE_ENABLED, BTPAN_ROLE_PANU),
+		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
+					BT_STATUS_SUCCESS,
+					BTPAN_STATE_CONNECTED,
+					BTPAN_ROLE_PANU, BTPAN_ROLE_PANNAP),
+		ACTION_SUCCESS(pan_disconnect_action, NULL),
+		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
+					BT_STATUS_SUCCESS,
+					BTPAN_STATE_DISCONNECTED,
+					BTPAN_ROLE_PANU, BTPAN_ROLE_PANNAP),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+
 };
 
 struct queue *get_pan_tests(void)
-- 
1.9.1

