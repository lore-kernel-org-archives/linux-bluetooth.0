Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/tester: Change handling of tester_setup_failed event
Date: Tue,  2 Sep 2014 11:34:43 +0200
Message-Id: <1409650483-24403-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If tester_setup_failed() was called, execute post_teardown() to clean
data created in pre_setup phase. In some cases android-tester
couldn't start daemon, and setup failed, but hciemu created in
pre_setup was not removed.
---
 src/shared/tester.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 95b4682..fb645a0 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -447,9 +447,9 @@ void tester_pre_setup_failed(void)
 	if (test->stage != TEST_STAGE_PRE_SETUP)
 		return;
 
-	test->stage = TEST_STAGE_SETUP;
+	print_progress(test->name, COLOR_RED, "pre setup failed");
 
-	tester_setup_failed();
+	g_idle_add(done_callback, test);
 }
 
 void tester_setup_complete(void)
@@ -481,14 +481,17 @@ void tester_setup_failed(void)
 	if (test->stage != TEST_STAGE_SETUP)
 		return;
 
+	test->stage = TEST_STAGE_POST_TEARDOWN;
+
 	if (test->timeout_id > 0) {
 		g_source_remove(test->timeout_id);
 		test->timeout_id = 0;
 	}
 
 	print_progress(test->name, COLOR_RED, "setup failed");
+	print_progress(test->name, COLOR_MAGENTA, "teardown");
 
-	g_idle_add(done_callback, test);
+	test->post_teardown_func(test->test_data);
 }
 
 void tester_test_passed(void)
-- 
1.9.0

