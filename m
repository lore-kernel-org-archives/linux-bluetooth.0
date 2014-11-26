Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 3/5] unit/test-queue: Add /queue/insert_after test
Date: Tue, 25 Nov 2014 21:26:47 -0800
Message-Id: <1416979609-3056-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1416979609-3056-1-git-send-email-armansito@chromium.org>
References: <1416979609-3056-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tests the queue_insert_after function.
---
 unit/test-queue.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 9fe15ba..e5f9178 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -118,6 +118,46 @@ static void test_destroy_remove(void)
 	queue_destroy(static_queue, destroy_remove);
 }
 
+static void test_insert_after(void)
+{
+	struct queue *queue;
+	unsigned int len, i;
+
+	queue = queue_new();
+	g_assert(queue != NULL);
+
+	/*
+	 * Pre-populate queue. Initial elements are:
+	 *   [ NULL, 2, 5 ]
+	 */
+	g_assert(queue_push_tail(queue, NULL));
+	g_assert(queue_push_tail(queue, UINT_TO_PTR(2)));
+	g_assert(queue_push_tail(queue, UINT_TO_PTR(5)));
+	g_assert(queue_length(queue) == 3);
+
+	/* Invalid insertion */
+	g_assert(!queue_insert_after(queue, UINT_TO_PTR(6), UINT_TO_PTR(1)));
+
+	/* Valid insertions */
+	g_assert(queue_insert_after(queue, NULL, UINT_TO_PTR(1)));
+	g_assert(queue_insert_after(queue, UINT_TO_PTR(2), UINT_TO_PTR(3)));
+	g_assert(queue_insert_after(queue, UINT_TO_PTR(3), UINT_TO_PTR(4)));
+	g_assert(queue_insert_after(queue, UINT_TO_PTR(5), UINT_TO_PTR(6)));
+
+	g_assert(queue_peek_head(queue) == NULL);
+	g_assert(queue_peek_tail(queue) == UINT_TO_PTR(6));
+
+	/*
+	 * Queue should contain 7 elements:
+	 *   [ NULL, 1, 2, 3, 4, 5, 6 ]
+	 */
+	len = queue_length(queue);
+	g_assert(len == 7);
+
+	for (i = 0; i < 7; i++)
+		g_assert(queue_pop_head(queue) == UINT_TO_PTR(i));
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -126,6 +166,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
 	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
+	g_test_add_func("/queue/insert_after", test_insert_after);
 
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

