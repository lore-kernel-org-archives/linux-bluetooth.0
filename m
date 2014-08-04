Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] unit/test-queue: Add /queue/foreach_vargs
Date: Mon,  4 Aug 2014 16:48:52 +0300
Message-Id: <1407160132-19567-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407160132-19567-1-git-send-email-luiz.dentz@gmail.com>
References: <1407160132-19567-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-queue.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/unit/test-queue.c b/unit/test-queue.c
index 5cbe529..445568e 100644
--- a/unit/test-queue.c
+++ b/unit/test-queue.c
@@ -99,6 +99,36 @@ static void test_foreach_remove_all(void)
 	queue_destroy(queue, NULL);
 }
 
+static void foreach_vargs(void *data, va_list *ap)
+{
+	struct queue *queue;
+	unsigned int i;
+	char *s;
+
+	queue = va_arg(ap, struct queue *);
+	g_assert(queue != NULL);
+
+	i = va_arg(ap, unsigned int);
+	g_assert_cmpint(i, ==, 1);
+
+	s = va_arg(ap, char *);
+	g_assert_cmpstr(s, ==, "2");
+}
+
+static void test_foreach_vargs(void)
+{
+	struct queue *queue;
+
+	queue = queue_new();
+	g_assert(queue != NULL);
+
+	queue_push_tail(queue, UINT_TO_PTR(1));
+	queue_push_tail(queue, UINT_TO_PTR(2));
+
+	queue_foreach_vargs(queue, foreach_vargs, queue, 1, "2");
+	queue_destroy(queue, NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -106,6 +136,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/queue/basic", test_basic);
 	g_test_add_func("/queue/foreach_destroy", test_foreach_destroy);
 	g_test_add_func("/queue/foreach_remove_all", test_foreach_remove_all);
+	g_test_add_func("/queue/foreach_vargs", test_foreach_vargs);
 
 	return g_test_run();
 }
-- 
1.9.3

