Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/12] unit/test-queue: Add /queue/foreach_remove test
Date: Mon,  8 Dec 2014 18:05:06 +0200
Message-Id: <1418054716-24231-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
References: <1418054716-24231-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests queue_remove from queue_foreach callback.
---
 unit/test-queue.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index f72f2e6..6261612 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -78,6 +78,27 @@ static void test_foreach_destroy(void)
 	queue_foreach(queue, foreach_destroy, queue);
 }
 
+static void foreach_remove(void *data, void *user_data)
+{
+	struct queue *queue = user_data;
+
+	g_assert(queue_remove(queue, data));
+}
+
+static void test_foreach_remove(void)
+{
+	struct queue *queue;
+
+	queue = queue_new();
+	g_assert(queue != NULL);
+
+	queue_push_tail(queue, UINT_TO_PTR(1));
+	queue_push_tail(queue, UINT_TO_PTR(2));
+
+	queue_foreach(queue, foreach_remove, queue);
+	queue_destroy(queue, NULL);
+}
+
 static void foreach_remove_all(void *data, void *user_data)
 {
 	struct queue *queue = user_data;
@@ -177,6 +198,7 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/queue/basic", test_basic);
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
+	g_test_add_func("/queue/foreach_remove", test_foreach_remove);
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
 	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
 	g_test_add_func("/queue/push_after", test_push_after);
-- 
1.9.3

