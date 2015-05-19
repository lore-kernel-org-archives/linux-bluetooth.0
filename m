Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/5] unit/test-queue: Use tester framework
Date: Tue, 19 May 2015 20:31:02 +0530
Message-id: <1432047664-23655-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
References: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-queue.c | 55 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 12319b0..d912a64 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -29,8 +29,9 @@
 
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/tester.h"
 
-static void test_basic(void)
+static void test_basic(const void *data)
 {
 	struct queue *queue;
 	unsigned int n, i;
@@ -56,6 +57,7 @@ static void test_basic(void)
 	}
 
 	queue_destroy(queue, NULL);
+	tester_test_passed();
 }
 
 static void foreach_destroy(void *data, void *user_data)
@@ -65,7 +67,7 @@ static void foreach_destroy(void *data, void *user_data)
 	queue_destroy(queue, NULL);
 }
 
-static void test_foreach_destroy(void)
+static void test_foreach_destroy(const void *data)
 {
 	struct queue *queue;
 
@@ -76,6 +78,7 @@ static void test_foreach_destroy(void)
 	queue_push_tail(queue, UINT_TO_PTR(2));
 
 	queue_foreach(queue, foreach_destroy, queue);
+	tester_test_passed();
 }
 
 static void foreach_remove(void *data, void *user_data)
@@ -85,7 +88,7 @@ static void foreach_remove(void *data, void *user_data)
 	g_assert(queue_remove(queue, data));
 }
 
-static void test_foreach_remove(void)
+static void test_foreach_remove(const void *data)
 {
 	struct queue *queue;
 
@@ -97,6 +100,7 @@ static void test_foreach_remove(void)
 
 	queue_foreach(queue, foreach_remove, queue);
 	queue_destroy(queue, NULL);
+	tester_test_passed();
 }
 
 static void foreach_remove_all(void *data, void *user_data)
@@ -106,7 +110,7 @@ static void foreach_remove_all(void *data, void *user_data)
 	queue_remove_all(queue, NULL, NULL, NULL);
 }
 
-static void test_foreach_remove_all(void)
+static void test_foreach_remove_all(const void *data)
 {
 	struct queue *queue;
 
@@ -118,6 +122,7 @@ static void test_foreach_remove_all(void)
 
 	queue_foreach(queue, foreach_remove_all, queue);
 	queue_destroy(queue, NULL);
+	tester_test_passed();
 }
 
 static void foreach_remove_backward(void *data, void *user_data)
@@ -128,7 +133,7 @@ static void foreach_remove_backward(void *data, void *user_data)
 	queue_remove(queue, UINT_TO_PTR(1));
 }
 
-static void test_foreach_remove_backward(void)
+static void test_foreach_remove_backward(const void *data)
 {
 	struct queue *queue;
 
@@ -140,6 +145,7 @@ static void test_foreach_remove_backward(void)
 
 	queue_foreach(queue, foreach_remove_backward, queue);
 	queue_destroy(queue, NULL);
+	tester_test_passed();
 }
 
 static struct queue *static_queue;
@@ -149,7 +155,7 @@ static void destroy_remove(void *user_data)
 	queue_remove(static_queue, user_data);
 }
 
-static void test_destroy_remove(void)
+static void test_destroy_remove(const void *data)
 {
 	static_queue = queue_new();
 
@@ -159,9 +165,10 @@ static void test_destroy_remove(void)
 	queue_push_tail(static_queue, UINT_TO_PTR(2));
 
 	queue_destroy(static_queue, destroy_remove);
+	tester_test_passed();
 }
 
-static void test_push_after(void)
+static void test_push_after(const void *data)
 {
 	struct queue *queue;
 	unsigned int len, i;
@@ -212,6 +219,7 @@ static void test_push_after(void)
 	g_assert(queue_pop_head(queue) == UINT_TO_PTR(1));
 
 	queue_destroy(queue, NULL);
+	tester_test_passed();
 }
 
 static bool match_int(const void *a, const void *b)
@@ -227,7 +235,7 @@ static bool match_ptr(const void *a, const void *b)
 	return a == b;
 }
 
-static void test_remove_all(void)
+static void test_remove_all(const void *data)
 {
 	struct queue *queue;
 
@@ -248,21 +256,26 @@ static void test_remove_all(void)
 	g_assert(queue_isempty(queue));
 
 	queue_destroy(queue, NULL);
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
-
-	g_test_add_func("/queue/basic", test_basic);
-	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
-	g_test_add_func("/queue/foreach_remove", test_foreach_remove);
-	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
-	g_test_add_func("/queue/foreach_remove_backward",
-						test_foreach_remove_backward);
-	g_test_add_func("/queue/destroy_remove", test_destroy_remove);
-	g_test_add_func("/queue/push_after", test_push_after);
-	g_test_add_func("/queue/remove_all", test_remove_all);
-
-	return g_test_run();
+	tester_init(&argc, &argv);
+
+	tester_add("/queue/basic", NULL, NULL, test_basic, NULL);
+	tester_add("/queue/foreach_destroy", NULL, NULL,
+						test_foreach_destroy, NULL);
+	tester_add("/queue/foreach_remove",  NULL, NULL,
+						test_foreach_remove, NULL);
+	tester_add("/queue/foreach_remove_all",  NULL, NULL,
+						test_foreach_remove_all, NULL);
+	tester_add("/queue/foreach_remove_backward", NULL, NULL,
+					test_foreach_remove_backward, NULL);
+	tester_add("/queue/destroy_remove",  NULL, NULL,
+						test_destroy_remove, NULL);
+	tester_add("/queue/push_after",  NULL, NULL, test_push_after, NULL);
+	tester_add("/queue/remove_all",  NULL, NULL, test_remove_all, NULL);
+
+	return tester_run();
 }
-- 
1.9.1

