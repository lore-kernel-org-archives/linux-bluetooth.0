Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] shared/queue: Make queue_find default do direct match for NULL callback
Date: Thu, 22 May 2014 13:34:03 +0300
Message-Id: <1400754843-4759-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com>
References: <1400754843-4759-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/queue.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index b589055..36da5fe 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -212,7 +212,7 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 
 		function(tmp->data, user_data);
 
-		if (!queue_find(queue, direct_match, entry))
+		if (!queue_find(queue, NULL, entry))
 			break;
 	}
 	queue_unref(queue);
@@ -226,6 +226,9 @@ void *queue_find(struct queue *queue, queue_match_func_t function,
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

