Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/queue: Fix queue_foreach not detecting queue has been destroyed
Date: Thu, 22 May 2014 13:34:00 +0300
Message-Id: <1400754843-4759-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com>
References: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes queue_foreach crashing if it callback call queue_destroy.
---
 src/shared/queue.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index ea4ff96..c9c0812 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -34,11 +34,30 @@ struct queue_entry {
 };
 
 struct queue {
+	int ref_count;
 	struct queue_entry *head;
 	struct queue_entry *tail;
 	unsigned int entries;
 };
 
+static struct queue *queue_ref(struct queue *queue)
+{
+	if (!queue)
+		return NULL;
+
+	__sync_fetch_and_add(&queue->ref_count, 1);
+
+	return queue;
+}
+
+static void queue_unref(struct queue *queue)
+{
+	if (__sync_sub_and_fetch(&queue->ref_count, 1))
+		return;
+
+	free(queue);
+}
+
 struct queue *queue_new(void)
 {
 	struct queue *queue;
@@ -51,7 +70,7 @@ struct queue *queue_new(void)
 	queue->tail = NULL;
 	queue->entries = 0;
 
-	return queue;
+	return queue_ref(queue);
 }
 
 void queue_destroy(struct queue *queue, queue_destroy_func_t destroy)
@@ -74,7 +93,7 @@ void queue_destroy(struct queue *queue, queue_destroy_func_t destroy)
 		free(tmp);
 	}
 
-	free(queue);
+	queue_unref(queue);
 }
 
 bool queue_push_tail(struct queue *queue, void *data)
@@ -177,14 +196,18 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 		return;
 
 	entry = queue->head;
+	if (!entry)
+		return;
 
-	while (entry) {
+	queue_ref(queue);
+	while (entry && queue->ref_count > 1) {
 		struct queue_entry *tmp = entry;
 
 		entry = tmp->next;
 
 		function(tmp->data, user_data);
 	}
+	queue_unref(queue);
 }
 
 void *queue_find(struct queue *queue, queue_match_func_t function,
-- 
1.9.0

