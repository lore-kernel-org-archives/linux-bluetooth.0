Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 6/8] android/tester: Add PAN Enable NAP test case
Date: Tue,  5 Aug 2014 14:19:12 +0300
Message-Id: <1407237554-5079-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index abf4b34..74ced79 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -111,6 +111,16 @@ static void pan_get_local_role_action(void)
 	schedule_action_verification(step);
 }
 
+static void pan_enable_nap_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_pan->enable(BTPAN_ROLE_PANNAP);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("PAN Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -189,6 +199,11 @@ static struct test_case test_cases[] = {
 					BTPAN_ROLE_PANU, BTPAN_ROLE_PANNAP),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("PAN Enable NAP - Success",
+		ACTION_SUCCESS(pan_enable_nap_action, NULL),
+		CALLBACK_PAN_CTRL_STATE(CB_PAN_CONTROL_STATE, BT_STATUS_SUCCESS,
+					BTPAN_STATE_ENABLED, BTPAN_ROLE_PANNAP),
+	),
 };
 
 struct queue *get_pan_tests(void)
-- 
1.9.1

