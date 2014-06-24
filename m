Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] queue: Add queue_foreach_if
Date: Tue, 24 Jun 2014 11:27:32 +0300
Message-Id: <1403598452-4391-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function allows to search for a second level queue inside first level
queue. In the current implementation since head is hidden this is not
possible.
---
 src/shared/queue.c | 33 +++++++++++++++++++++++++++++++++
 src/shared/queue.h |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 4013293..454b328 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -224,6 +224,39 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 	queue_unref(queue);
 }
 
+void *queue_foreach_if(struct queue *queue, queue_foreach_if_func_t function,
+							void *user_data)
+{
+	struct queue_entry *entry;
+
+	if (!queue || !function)
+		return NULL;
+
+	entry = queue->head;
+	if (!entry)
+		return NULL;
+
+	queue_ref(queue);
+	while (entry && queue->ref_count > 1) {
+		struct queue_entry *tmp = entry;
+		void *ret;
+
+		entry = tmp->next;
+
+		ret = function(tmp->data, user_data);
+		if (ret) {
+			queue_unref(queue);
+			return ret;
+		}
+
+		if (!queue_find_entry(queue, entry))
+			break;
+	}
+	queue_unref(queue);
+
+	return NULL;
+}
+
 static bool direct_match(const void *a, const void *b)
 {
 	return a == b;
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 709590b..bf5bf8f 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -37,9 +37,12 @@ void *queue_peek_head(struct queue *queue);
 void *queue_peek_tail(struct queue *queue);
 
 typedef void (*queue_foreach_func_t)(void *data, void *user_data);
+typedef void *(*queue_foreach_if_func_t)(void *data, void *user_data);
 
 void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 							void *user_data);
+void *queue_foreach_if(struct queue *queue, queue_foreach_if_func_t function,
+							void *user_data);
 
 typedef bool (*queue_match_func_t)(const void *a, const void *b);
 
-- 
1.8.3.2

