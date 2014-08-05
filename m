Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/8] android/tester: Add PAN Get Local Role test case
Date: Tue,  5 Aug 2014 14:19:10 +0300
Message-Id: <1407237554-5079-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index 848cc83..abf4b34 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -92,6 +92,25 @@ static void pan_disconnect_action(void)
 	schedule_action_verification(step);
 }
 
+static void pan_get_local_role_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *pan_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+	int role;
+
+	bdaddr2android((const bdaddr_t *) pan_addr, &bdaddr);
+
+	role = data->if_pan->get_local_role();
+	if (role == BTPAN_ROLE_PANU)
+		step->action_status = BT_STATUS_SUCCESS;
+	else
+		step->action_status = BT_STATUS_FAIL;
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("PAN Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -145,7 +164,31 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
-
+	TEST_CASE_BREDRLE("PAN GetLocalRole - Success",
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
+		ACTION_SUCCESS(pan_get_local_role_action, NULL),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_PAN_CONN_STATE(CB_PAN_CONNECTION_STATE,
+					BT_STATUS_SUCCESS,
+					BTPAN_STATE_DISCONNECTED,
+					BTPAN_ROLE_PANU, BTPAN_ROLE_PANNAP),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_pan_tests(void)
-- 
1.9.1

