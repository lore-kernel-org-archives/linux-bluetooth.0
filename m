Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/tester: Fix teardown multiple times
Date: Tue, 10 Mar 2015 15:31:36 +0200
Message-Id: <1425994298-2883-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
References: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

tester_test* can be called multiple times which cause teardown callback
to be called multiple times as well leading to to crashes or strange
behavior.
---
 src/shared/tester.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index acd3df7..d05bf08 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -90,6 +90,7 @@ struct test_case {
 	gdouble end_time;
 	unsigned int timeout;
 	unsigned int timeout_id;
+	unsigned int teardown_id;
 	tester_destroy_func_t destroy;
 	void *user_data;
 };
@@ -113,6 +114,9 @@ static void test_destroy(gpointer data)
 	if (test->timeout_id > 0)
 		g_source_remove(test->timeout_id);
 
+	if (test->teardown_id > 0)
+		g_source_remove(test->teardown_id);
+
 	if (test->destroy)
 		test->destroy(test->user_data);
 
@@ -328,6 +332,7 @@ static gboolean teardown_callback(gpointer user_data)
 {
 	struct test_case *test = user_data;
 
+	test->teardown_id = 0;
 	test->stage = TEST_STAGE_TEARDOWN;
 
 	print_progress(test->name, COLOR_MAGENTA, "teardown");
@@ -528,7 +533,10 @@ static void test_result(enum test_result result)
 		break;
 	}
 
-	g_idle_add(teardown_callback, test);
+	if (test->teardown_id > 0)
+		return;
+
+	test->teardown_id = g_idle_add(teardown_callback, test);
 }
 
 void tester_test_passed(void)
-- 
2.1.0

