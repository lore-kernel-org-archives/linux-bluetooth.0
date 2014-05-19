Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 08/11] shared: Fix queue_find to accept const ptr as match data
Date: Tue, 20 May 2014 01:44:40 +0200
Message-Id: <1400543083-28811-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes queue_find definition to have const pointer as data to
be matched against. Match function already does have const pointers as
arguments. Also parameter name is updated to be 'match_data' since this
actually is not user_data, just data to be matched against.
---
 src/shared/queue.c | 4 ++--
 src/shared/queue.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 8a69729..ea4ff96 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -188,7 +188,7 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 }
 
 void *queue_find(struct queue *queue, queue_match_func_t function,
-							void *user_data)
+							const void *match_data)
 {
 	struct queue_entry *entry;
 
@@ -196,7 +196,7 @@ void *queue_find(struct queue *queue, queue_match_func_t function,
 		return NULL;
 
 	for (entry = queue->head; entry; entry = entry->next)
-		if (function(entry->data, user_data))
+		if (function(entry->data, match_data))
 			return entry->data;
 
 	return NULL;
diff --git a/src/shared/queue.h b/src/shared/queue.h
index 8201ff8..709590b 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -44,7 +44,7 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 typedef bool (*queue_match_func_t)(const void *a, const void *b);
 
 void *queue_find(struct queue *queue, queue_match_func_t function,
-							void *user_data);
+							const void *match_data);
 
 bool queue_remove(struct queue *queue, void *data);
 void *queue_remove_if(struct queue *queue, queue_match_func_t function,
-- 
1.9.3

