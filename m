Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 2/3] unit/test-queue: add test for early termination
Date: Thu, 11 Dec 2014 11:53:36 -0800
Message-Id: <1418327617-26951-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418327617-26951-1-git-send-email-jamuraa@chromium.org>
References: <1418327617-26951-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds tests to check that early termination within queue_foreach is
working correctly.
---
 unit/test-queue.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 7ae3358..8a6910d 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -101,6 +101,32 @@ static void test_foreach_remove_all(void)
 	queue_destroy(queue, NULL);
 }
 
+static bool foreach_remove_one(void *data, void *user_data)
+{
+	struct queue *queue = user_data;
+
+	queue_remove(queue, data);
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
+
 static struct queue *static_queue;
 
 static void destroy_remove(void *user_data)
@@ -180,6 +206,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/queue/basic", test_basic);
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
+	g_test_add_func("/queue/foreach_early_term", test_foreach_early_term);
 	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
 	g_test_add_func("/queue/push_after", test_push_after);
 
-- 
2.2.0.rc0.207.ga3a616c

