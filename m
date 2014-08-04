Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] shared/queue: Add queue_foreach_vargs
Date: Mon,  4 Aug 2014 16:48:51 +0300
Message-Id: <1407160132-19567-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds queue_foreach_vargs which contrary to queue_foreach can take
a variable number of parameters which is very convenient considering
there is no way to direct access the elements of the queue.
---
 src/shared/queue.c | 29 +++++++++++++++++++++++++++++
 src/shared/queue.h |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 3ca3ca6..3093afe 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -211,6 +211,35 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 	queue_unref(queue);
 }
 
+void queue_foreach_vargs(struct queue *queue,
+				queue_foreach_func_vargs_t function, ...)
+{
+	struct queue_entry *entry;
+
+	if (!queue || !function)
+		return;
+
+	entry = queue->head;
+	if (!entry)
+		return;
+
+	queue_ref(queue);
+	while (entry && queue->ref_count > 1) {
+		struct queue_entry *tmp = entry;
+		va_list ap;
+
+		entry = tmp->next;
+
+		va_start(ap, function);
+		function(tmp->data, &ap);
+		va_end(ap);
+
+		if (!queue_find_entry(queue, entry))
+			break;
+	}
+	queue_unref(queue);
+}
+
 static bool direct_match(const void *a, const void *b)
 {
 	return a == b;
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 709590b..e773aa5 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -22,6 +22,7 @@
  */
 
 #include <stdbool.h>
+#include <stdarg.h>
 
 typedef void (*queue_destroy_func_t)(void *data);
 
@@ -41,6 +42,11 @@ typedef void (*queue_foreach_func_t)(void *data, void *user_data);
 void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 							void *user_data);
 
+typedef void (*queue_foreach_func_vargs_t)(void *data, va_list *ap);
+
+void queue_foreach_vargs(struct queue *queue,
+				queue_foreach_func_vargs_t function, ...);
+
 typedef bool (*queue_match_func_t)(const void *a, const void *b);
 
 void *queue_find(struct queue *queue, queue_match_func_t function,
-- 
1.9.3

