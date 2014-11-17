Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] unit/test-queue: Add /queue/destroy_remove test
Date: Mon, 17 Nov 2014 16:40:57 +0200
Message-Id: <1416235257-12804-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1416235257-12804-1-git-send-email-luiz.dentz@gmail.com>
References: <1416235257-12804-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests queue_remove from queue_destroy callback.
---
 unit/test-queue.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 5cbe529..9fe15ba 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -99,6 +99,25 @@ static void test_foreach_remove_all(void)
 	queue_destroy(queue, NULL);
 }
 
+static struct queue *static_queue;
+
+static void destroy_remove(void *user_data)
+{
+	queue_remove(static_queue, user_data);
+}
+
+static void test_destroy_remove(void)
+{
+	static_queue = queue_new();
+
+	g_assert(static_queue != NULL);
+
+	queue_push_tail(static_queue, UINT_TO_PTR(1));
+	queue_push_tail(static_queue, UINT_TO_PTR(2));
+
+	queue_destroy(static_queue, destroy_remove);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -106,6 +125,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/queue/basic", test_basic);
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
+	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
 
 	return g_test_run();
 }
-- 
1.9.3

