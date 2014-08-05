Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 7/8] android/tester: Add PAN Enable PANU test case
Date: Tue,  5 Aug 2014 14:19:13 +0300
Message-Id: <1407237554-5079-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index 74ced79..96d1ba9 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -121,6 +121,16 @@ static void pan_enable_nap_action(void)
 	schedule_action_verification(step);
 }
 
+static void pan_enable_panu_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_pan->enable(BTPAN_ROLE_PANU);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("PAN Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -204,6 +214,9 @@ static struct test_case test_cases[] = {
 		CALLBACK_PAN_CTRL_STATE(CB_PAN_CONTROL_STATE, BT_STATUS_SUCCESS,
 					BTPAN_STATE_ENABLED, BTPAN_ROLE_PANNAP),
 	),
+	TEST_CASE_BREDRLE("PAN Enable PANU - Success",
+		ACTION(BT_STATUS_UNSUPPORTED, pan_enable_panu_action, NULL),
+	),
 };
 
 struct queue *get_pan_tests(void)
-- 
1.9.1

