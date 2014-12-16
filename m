Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 1/5] shared/queue: Add queue_get_entries
Date: Mon, 15 Dec 2014 17:03:32 -0800
Message-Id: <1418691816-40271-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
References: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Function which is useful for iterating through entries with complex
search parameters and terminating the searches early.
---
 src/shared/queue.c | 14 ++++++++------
 src/shared/queue.h |  8 ++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index a5155e7..ccf2f07 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -28,12 +28,6 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 
-struct queue_entry {
-	int ref_count;
-	void *data;
-	struct queue_entry *next;
-};
-
 struct queue {
 	int ref_count;
 	struct queue_entry *head;
@@ -401,6 +395,14 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 	return count;
 }
 
+const struct queue_entry *queue_get_entries(struct queue *queue)
+{
+	if (!queue)
+		return NULL;
+
+	return queue->head;
+}
+
 unsigned int queue_length(struct queue *queue)
 {
 	if (!queue)
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 602b0ce..0d5a9a5 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -27,6 +27,12 @@ typedef void (*queue_destroy_func_t)(void *data);
 
 struct queue;
 
+struct queue_entry {
+	int ref_count;
+	void *data;
+	struct queue_entry *next;
+};
+
 struct queue *queue_new(void);
 void queue_destroy(struct queue *queue, queue_destroy_func_t destroy);
 
@@ -53,5 +59,7 @@ void *queue_remove_if(struct queue *queue, queue_match_func_t function,
 unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 				void *user_data, queue_destroy_func_t destroy);
 
+const struct queue_entry *queue_get_entries(struct queue *queue);
+
 unsigned int queue_length(struct queue *queue);
 bool queue_isempty(struct queue *queue);
-- 
2.2.0.rc0.207.ga3a616c

