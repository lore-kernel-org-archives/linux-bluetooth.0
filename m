Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 2/3] unit/test-queue: add test for early termination
Date: Fri, 12 Dec 2014 10:44:23 -0800
Message-Id: <1418409864-26119-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
References: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds tests to check that early termination within queue_foreach is
working correctly.
---
 unit/test-queue.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 668b87f..ad6fc76 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -141,6 +141,7 @@ static void test_foreach_remove_backward(void)
 	struct queue *queue;
 
 	queue = queue_new();
+
 	g_assert(queue != NULL);
 
 	queue_push_tail(queue, UINT_TO_PTR(1));
@@ -150,6 +151,32 @@ static void test_foreach_remove_backward(void)
 	queue_destroy(queue, NULL);
 }
 
+static bool foreach_remove_one(void *data, void *user_data)
+{
+	struct queue *queue = user_data;
+
+	queue_remove(queue, data);
+
+	return false;
+}
+
+static void test_foreach_early_term(void)
+{
+	struct queue *queue;
+
+	queue = queue_new();
+
+	g_assert(queue != NULL);
+
+	queue_push_tail(queue, UINT_TO_PTR(1));
+	queue_push_tail(queue, UINT_TO_PTR(2));
+
+	queue_foreach(queue, foreach_remove_one, queue);
+
+	g_assert_cmpint(queue_length(queue), ==, 1);
+	g_assert(queue_peek_head(queue) == UINT_TO_PTR(2));
+}
+
 static struct queue *static_queue;
 
 static void destroy_remove(void *user_data)
@@ -232,6 +259,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
 	g_test_add_func("/queue/foreach_remove_backward",
 						test_foreach_remove_backward);
+	g_test_add_func("/queue/foreach_early_term", test_foreach_early_term);
 	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
 	g_test_add_func("/queue/push_after", test_push_after);
 
-- 
2.2.0.rc0.207.ga3a616c

