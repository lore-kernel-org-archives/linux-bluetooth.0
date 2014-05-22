Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] shared/queue: Make queue_find default do direct match for NULL callback
Date: Thu, 22 May 2014 15:03:02 +0300
Message-Id: <1400760182-16836-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400760182-16836-1-git-send-email-luiz.dentz@gmail.com>
References: <1400760182-16836-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/queue.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 20f51b8..8bbb7df 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -224,6 +224,11 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 	queue_unref(queue);
 }
 
+static bool direct_match(const void *a, const void *b)
+{
+	return a == b;
+}
+
 void *queue_find(struct queue *queue, queue_match_func_t function,
 							const void *match_data)
 {
@@ -232,6 +237,9 @@ void *queue_find(struct queue *queue, queue_match_func_t function,
 	if (!queue || !function)
 		return NULL;
 
+	if (!function)
+		function = direct_match;
+
 	for (entry = queue->head; entry; entry = entry->next)
 		if (function(entry->data, match_data))
 			return entry->data;
-- 
1.9.0

