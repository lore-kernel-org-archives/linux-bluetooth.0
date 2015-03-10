Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/tester: Add tester_test_abort
Date: Tue, 10 Mar 2015 15:31:35 +0200
Message-Id: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This can be used to abort tests and mark them as not run.
---
 src/shared/tester.c | 47 ++++++++++++++++++++++++++---------------------
 src/shared/tester.h |  1 +
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index ffcc2ea..acd3df7 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -495,7 +495,7 @@ void tester_setup_failed(void)
 	test->post_teardown_func(test->test_data);
 }
 
-void tester_test_passed(void)
+static void test_result(enum test_result result)
 {
 	struct test_case *test;
 
@@ -512,33 +512,38 @@ void tester_test_passed(void)
 		test->timeout_id = 0;
 	}
 
-	test->result = TEST_RESULT_PASSED;
-	print_progress(test->name, COLOR_GREEN, "test passed");
+	test->result = result;
+	switch (result) {
+	case TEST_RESULT_PASSED:
+		print_progress(test->name, COLOR_GREEN, "test passed");
+		break;
+	case TEST_RESULT_FAILED:
+		print_progress(test->name, COLOR_RED, "test failed");
+		break;
+	case TEST_RESULT_NOT_RUN:
+		print_progress(test->name, COLOR_YELLOW, "test not run");
+		break;
+	case TEST_RESULT_TIMED_OUT:
+		print_progress(test->name, COLOR_RED, "test timed out");
+		break;
+	}
 
 	g_idle_add(teardown_callback, test);
 }
 
-void tester_test_failed(void)
+void tester_test_passed(void)
 {
-	struct test_case *test;
-
-	if (!test_current)
-		return;
-
-	test = test_current->data;
-
-	if (test->stage != TEST_STAGE_RUN)
-		return;
-
-	if (test->timeout_id > 0) {
-		g_source_remove(test->timeout_id);
-		test->timeout_id = 0;
-	}
+	test_result(TEST_RESULT_PASSED);
+}
 
-	test->result = TEST_RESULT_FAILED;
-	print_progress(test->name, COLOR_RED, "test failed");
+void tester_test_failed(void)
+{
+	test_result(TEST_RESULT_FAILED);
+}
 
-	g_idle_add(teardown_callback, test);
+void tester_test_abort(void)
+{
+	test_result(TEST_RESULT_NOT_RUN);
 }
 
 void tester_teardown_complete(void)
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 0231f19..83ef5de 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -63,6 +63,7 @@ void tester_setup_failed(void);
 
 void tester_test_passed(void);
 void tester_test_failed(void);
+void tester_test_abort(void);
 
 void tester_teardown_complete(void);
 void tester_teardown_failed(void);
-- 
2.1.0

