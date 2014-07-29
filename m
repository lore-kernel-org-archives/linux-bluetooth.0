Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 8/8] android/tester-ng: Add PAN Enable None test case
Date: Tue, 29 Jul 2014 15:01:32 +0300
Message-Id: <1406635292-30691-9-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-pan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index 1acc460..c3a8cea 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -131,6 +131,16 @@ static void pan_enable_nap_action(void)
 	schedule_action_verification(step);
 }
 
+static void pan_enable_none_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_pan->enable(BTPAN_ROLE_NONE);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("PAN Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -185,6 +195,9 @@ static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("PAN Enable NAP - Success",
 		ACTION_SUCCESS(pan_enable_nap_action, NULL),
 	),
+	TEST_CASE_BREDRLE("PAN Enable NONE - Success",
+		ACTION_SUCCESS(pan_enable_none_action, NULL),
+	),
 };
 
 struct queue *get_pan_tests(void)
-- 
1.9.1

