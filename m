Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/8] android/tester: Add function to set default ssp handler
Date: Tue,  2 Sep 2014 14:04:25 +0200
Message-Id: <1409659471-25171-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In most test cases pairing can be performed but is not part of test
case, and shouldn't have impact on test case result. This helper set
defult handler, which will always accept SSP requests.
---
 android/tester-a2dp.c |  3 +++
 android/tester-main.c | 21 +++++++++++++++++++++
 android/tester-main.h |  1 +
 android/tester-pan.c  |  3 +++
 4 files changed, 28 insertions(+)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 3d006bc..6d4043b 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -186,6 +186,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
 	TEST_CASE_BREDRLE("A2DP Connect - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -202,6 +203,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
 	TEST_CASE_BREDRLE("A2DP Disconnect - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -221,6 +223,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
 	TEST_CASE_BREDRLE("A2DP Resume - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
diff --git a/android/tester-main.c b/android/tester-main.c
index a001059..60ccac7 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1972,6 +1972,27 @@ void bt_remove_bond_action(void)
 	schedule_action_verification(step);
 }
 
+static void default_ssp_req_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *name,
+				uint32_t cod, bt_ssp_variant_t pairing_variant,
+				uint32_t pass_key)
+{
+	struct test_data *t_data = tester_get_data();
+
+	t_data->if_bluetooth->ssp_reply(remote_bd_addr, pairing_variant, true,
+								pass_key);
+}
+
+void set_default_ssp_request_handler(void)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	bt_callbacks.ssp_request_cb = default_ssp_req_cb;
+
+	step->action_status = BT_STATUS_SUCCESS;
+
+	schedule_action_verification(step);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
diff --git a/android/tester-main.h b/android/tester-main.h
index 171dbee..f7e3c90 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -451,3 +451,4 @@ void bt_pin_reply_accept_action(void);
 void bt_ssp_reply_accept_action(void);
 void bt_cancel_bond_action(void);
 void bt_remove_bond_action(void);
+void set_default_ssp_request_handler(void);
diff --git a/android/tester-pan.c b/android/tester-pan.c
index c293022..8d41d34 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -147,6 +147,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
 	TEST_CASE_BREDRLE("PAN Connect - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -171,6 +172,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
 	TEST_CASE_BREDRLE("PAN Disconnect - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
@@ -196,6 +198,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
 	TEST_CASE_BREDRLE("PAN GetLocalRole - Success",
+		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
 		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
-- 
1.9.0

