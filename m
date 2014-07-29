Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/queue: Fix not allowing to remove NULL entries
Date: Tue, 29 Jul 2014 17:29:29 +0300
Message-Id: <1406644169-31298-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

queue_remove should not check the data pointer since both queue_push_head
and queue_push_tail don't check it is possible to have NULL pointers in
the queue therefore queue_remove shall be able to remove them.
---
 src/shared/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 3bdc1ec..3ca3ca6 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -238,7 +238,7 @@ bool queue_remove(struct queue *queue, void *data)
 {
 	struct queue_entry *entry, *prev;
 
-	if (!queue || !data)
+	if (!queue)
 		return false;
 
 	for (entry = queue->head, prev = NULL; entry;
-- 
1.9.3

