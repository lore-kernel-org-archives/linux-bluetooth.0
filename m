Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] unit/test-queue: Add /queue/foreach_remove_backward test
Date: Mon,  8 Dec 2014 18:05:07 +0200
Message-Id: <1418054716-24231-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
References: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests queue_remove from queue_foreach callback in backward order.
---
 unit/test-queue.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 6261612..cb85605 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -120,6 +120,28 @@ static void test_foreach_remove_all(void)
 	queue_destroy(queue, NULL);
 }
 
+static void foreach_remove_backward(void *data, void *user_data)
+{
+	struct queue *queue = user_data;
+
+	queue_remove(queue, UINT_TO_PTR(2));
+	queue_remove(queue, UINT_TO_PTR(1));
+}
+
+static void test_foreach_remove_backward(void)
+{
+	struct queue *queue;
+
+	queue = queue_new();
+	g_assert(queue != NULL);
+
+	queue_push_tail(queue, UINT_TO_PTR(1));
+	queue_push_tail(queue, UINT_TO_PTR(2));
+
+	queue_foreach(queue, foreach_remove_backward, queue);
+	queue_destroy(queue, NULL);
+}
+
 static struct queue *static_queue;
 
 static void destroy_remove(void *user_data)
@@ -200,6 +222,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
 	g_test_add_func("/queue/foreach_remove", test_foreach_remove);
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
+	g_test_add_func("/queue/foreach_remove_backward",
+						test_foreach_remove_backward);
 	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
 	g_test_add_func("/queue/push_after", test_push_after);
 
-- 
1.9.3

