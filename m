Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/queue: Make queue_destroy safe
Date: Mon, 17 Nov 2014 16:40:56 +0200
Message-Id: <1416235257-12804-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1416235257-12804-1-git-send-email-luiz.dentz@gmail.com>
References: <1416235257-12804-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes queue_destroy and queue_remove_all safe even if destroy
callback end up calling queue_remove.
---
 src/shared/queue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 6bfe995..0bf0bd3 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -329,6 +329,10 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 
 		queue->entries -= count;
 	} else {
+		queue->head = NULL;
+		queue->tail = NULL;
+		queue->entries = 0;
+
 		while (entry) {
 			struct queue_entry *tmp = entry;
 
@@ -340,10 +344,6 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 			free(tmp);
 			count++;
 		}
-
-		queue->head = NULL;
-		queue->tail = NULL;
-		queue->entries = 0;
 	}
 
 	return count;
-- 
1.9.3

