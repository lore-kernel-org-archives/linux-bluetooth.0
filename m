Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/tester: Add HDP App Unregister test case
Date: Wed,  6 Aug 2014 16:41:50 +0300
Message-Id: <1407332510-3831-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407332510-3831-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407332510-3831-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hdp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 1f5fee2..9193609 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -162,6 +162,16 @@ static void hdp_register_source_stream_app_action(void)
 	free(reg);
 }
 
+static void hdp_unregister_app_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_hdp->unregister_application(1);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HDP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -186,6 +196,14 @@ static struct test_case test_cases[] = {
 		CALLBACK_HDP_APP_REG_STATE(CB_HDP_APP_REG_STATE, 1,
 					BTHL_APP_REG_STATE_REG_SUCCESS),
 	),
+	TEST_CASE_BREDRLE("HDP Unegister Application",
+		ACTION_SUCCESS(hdp_register_source_stream_app_action, NULL),
+		CALLBACK_HDP_APP_REG_STATE(CB_HDP_APP_REG_STATE, 1,
+					BTHL_APP_REG_STATE_REG_SUCCESS),
+		ACTION_SUCCESS(hdp_unregister_app_action, NULL),
+		CALLBACK_HDP_APP_REG_STATE(CB_HDP_APP_REG_STATE, 1,
+					BTHL_APP_REG_STATE_DEREG_SUCCESS),
+	),
 };
 
 struct queue *get_hdp_tests(void)
-- 
1.9.1

