Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/queue: Add reference counting to entries
Date: Fri, 28 Nov 2014 16:10:11 +0200
Message-Id: <1417183811-29397-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes queue_foreach much more efficient when tracking if the next
entry was remove by the callback.
---
 src/shared/queue.c | 73 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 9efb665..e592458 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -29,6 +29,7 @@
 #include "src/shared/queue.h"
 
 struct queue_entry {
+	int ref_count;
 	void *data;
 	struct queue_entry *next;
 };
@@ -83,6 +84,37 @@ void queue_destroy(struct queue *queue, queue_destroy_func_t destroy)
 	queue_unref(queue);
 }
 
+static struct queue_entry *queue_entry_ref(struct queue_entry *entry)
+{
+	if (!entry)
+		return NULL;
+
+	__sync_fetch_and_add(&entry->ref_count, 1);
+
+	return entry;
+}
+
+static void queue_entry_unref(struct queue_entry *entry)
+{
+	if (__sync_sub_and_fetch(&entry->ref_count, 1))
+		return;
+
+	free(entry);
+}
+
+static struct queue_entry *queue_entry_new(void *data)
+{
+	struct queue_entry *entry;
+
+	entry = new0(struct queue_entry, 1);
+	if (!entry)
+		return NULL;
+
+	entry->data = data;
+
+	return queue_entry_ref(entry);
+}
+
 bool queue_push_tail(struct queue *queue, void *data)
 {
 	struct queue_entry *entry;
@@ -90,13 +122,10 @@ bool queue_push_tail(struct queue *queue, void *data)
 	if (!queue)
 		return false;
 
-	entry = new0(struct queue_entry, 1);
+	entry = queue_entry_new(data);
 	if (!entry)
 		return false;
 
-	entry->data = data;
-	entry->next = NULL;
-
 	if (queue->tail)
 		queue->tail->next = entry;
 
@@ -117,11 +146,10 @@ bool queue_push_head(struct queue *queue, void *data)
 	if (!queue)
 		return false;
 
-	entry = new0(struct queue_entry, 1);
+	entry = queue_entry_new(data);
 	if (!entry)
 		return false;
 
-	entry->data = data;
 	entry->next = queue->head;
 
 	queue->head = entry;
@@ -153,11 +181,10 @@ bool queue_push_after(struct queue *queue, void *entry, void *data)
 	if (!qentry)
 		return false;
 
-	new_entry = new0(struct queue_entry, 1);
+	new_entry = queue_entry_new(data);
 	if (!new_entry)
 		return false;
 
-	new_entry->data = data;
 	new_entry->next = qentry->next;
 
 	if (!qentry->next)
@@ -187,7 +214,7 @@ void *queue_pop_head(struct queue *queue)
 
 	data = entry->data;
 
-	free(entry);
+	queue_entry_unref(entry);
 	queue->entries--;
 
 	return data;
@@ -209,17 +236,6 @@ void *queue_peek_tail(struct queue *queue)
 	return queue->tail->data;
 }
 
-static bool queue_find_entry(struct queue *queue, const void *data)
-{
-	struct queue_entry *entry;
-
-	for (entry = queue->head; entry; entry = entry->next)
-		if (entry == data)
-			return true;
-
-	return false;
-}
-
 void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 							void *user_data)
 {
@@ -235,12 +251,19 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 	queue_ref(queue);
 	while (entry && queue->ref_count > 1) {
 		struct queue_entry *tmp = entry;
+		int ref;
 
-		entry = tmp->next;
+		entry = queue_entry_ref(tmp->next);
 
 		function(tmp->data, user_data);
 
-		if (!queue_find_entry(queue, entry))
+		if (!entry)
+			break;
+
+		ref = entry->ref_count;
+		queue_entry_unref(entry);
+
+		if (ref < 2)
 			break;
 	}
 	queue_unref(queue);
@@ -289,7 +312,7 @@ bool queue_remove(struct queue *queue, void *data)
 		if (!entry->next)
 			queue->tail = prev;
 
-		free(entry);
+		queue_entry_unref(entry);
 		queue->entries--;
 
 		return true;
@@ -322,7 +345,7 @@ void *queue_remove_if(struct queue *queue, queue_match_func_t function,
 
 			data = entry->data;
 
-			free(entry);
+			queue_entry_unref(entry);
 			queue->entries--;
 
 			return data;
@@ -374,7 +397,7 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 			if (destroy)
 				destroy(tmp->data);
 
-			free(tmp);
+			queue_entry_unref(tmp);
 			count++;
 		}
 	}
-- 
1.9.3

