Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 2/5] shared: Add function to insert element after entry
Date: Wed, 26 Nov 2014 15:03:09 -0800
Message-Id: <1417042992-10142-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1417042992-10142-1-git-send-email-armansito@chromium.org>
References: <1417042992-10142-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds queue_insert_after, which inserts the given "data"
after the first occurence of element "entry" in a queue.
---
 src/shared/queue.c | 35 +++++++++++++++++++++++++++++++++++
 src/shared/queue.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 5329a80..9efb665 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -134,6 +134,41 @@ bool queue_push_head(struct queue *queue, void *data)
 	return true;
 }
 
+bool queue_push_after(struct queue *queue, void *entry, void *data)
+{
+	struct queue_entry *qentry, *tmp, *new_entry;
+
+	qentry = NULL;
+
+	if (!queue)
+		return false;
+
+	for (tmp = queue->head; tmp; tmp = tmp->next) {
+		if (tmp->data == entry) {
+			qentry = tmp;
+			break;
+		}
+	}
+
+	if (!qentry)
+		return false;
+
+	new_entry = new0(struct queue_entry, 1);
+	if (!new_entry)
+		return false;
+
+	new_entry->data = data;
+	new_entry->next = qentry->next;
+
+	if (!qentry->next)
+		queue->tail = new_entry;
+
+	qentry->next = new_entry;
+	queue->entries++;
+
+	return true;
+}
+
 void *queue_pop_head(struct queue *queue)
 {
 	struct queue_entry *entry;
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 709590b..602b0ce 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -32,6 +32,7 @@ void queue_destroy(struct queue *queue, queue_destroy_func_t destroy);
 
 bool queue_push_tail(struct queue *queue, void *data);
 bool queue_push_head(struct queue *queue, void *data);
+bool queue_push_after(struct queue *queue, void *entry, void *data);
 void *queue_pop_head(struct queue *queue);
 void *queue_peek_head(struct queue *queue);
 void *queue_peek_tail(struct queue *queue);
-- 
2.2.0.rc0.207.ga3a616c

