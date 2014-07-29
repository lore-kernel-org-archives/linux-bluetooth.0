Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/8] android/tester-ng: Add PAN Disconnect test case
Date: Tue, 29 Jul 2014 15:01:28 +0300
Message-Id: <1406635292-30691-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index baf1d68..5048a43 100644
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
@@ -96,6 +110,21 @@ static struct test_case test_cases[] = {
 						BTPAN_STATE_DISCONNECTED),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("PAN Disconnect - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
+		ACTION_SUCCESS(pan_connect_action, NULL),
+		CALLBACK_STATE(CB_PAN_CONNECTION_STATE,
+						BTPAN_STATE_CONNECTED),
+		ACTION_SUCCESS(pan_disconnect_action, NULL),
+		CALLBACK_STATE(CB_PAN_CONNECTION_STATE,
+						BTPAN_STATE_DISCONNECTED),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_pan_tests(void)
-- 
1.9.1

