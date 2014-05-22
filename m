Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] unit/test-queue: Add /queue/foreach_remove_all test
Date: Thu, 22 May 2014 15:03:00 +0300
Message-Id: <1400760182-16836-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400760182-16836-1-git-send-email-luiz.dentz@gmail.com>
References: <1400760182-16836-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests queue_remove_all from queue_foreach callback.
---
 unit/test-queue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 55273e3..af7dfd3 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -78,12 +78,33 @@ static void test_foreach_destroy(void)
 	queue_foreach(queue, foreach_destroy, queue);
 }
 
+static void foreach_remove_all(void *data, void *user_data)
+{
+	struct queue *queue = user_data;
+
+	queue_remove_all(queue, NULL, NULL, NULL);
+}
+
+static void test_foreach_remove_all(void)
+{
+	struct queue *queue;
+
+	queue = queue_new();
+	g_assert(queue != NULL);
+
+	queue_push_tail(queue, UINT_TO_PTR(1));
+	queue_push_tail(queue, UINT_TO_PTR(2));
+
+	queue_foreach(queue, foreach_remove_all, queue);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
 	g_test_add_func("/queue/basic", test_basic);
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
+	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
 
 	return g_test_run();
 }
-- 
1.9.0

