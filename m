Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] shared/queue: Fix queue_foreach not detecting queue has changed
Date: Thu, 22 May 2014 13:34:02 +0300
Message-Id: <1400754843-4759-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com>
References: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes queue_foreach crashing if callback calls queue_remove_all.
---
 src/shared/queue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index c9c0812..b589055 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -187,6 +187,11 @@ void *queue_peek_tail(struct queue *queue)
 	return queue->tail->data;
 }
 
+static bool direct_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
 void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 							void *user_data)
 {
@@ -206,6 +211,9 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 		entry = tmp->next;
 
 		function(tmp->data, user_data);
+
+		if (!queue_find(queue, direct_match, entry))
+			break;
 	}
 	queue_unref(queue);
 }
-- 
1.9.0

