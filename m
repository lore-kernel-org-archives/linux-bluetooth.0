Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared/att: Remove not needed NULL assignments
Date: Tue, 16 Dec 2014 15:59:05 +0100
Message-Id: <1418741945-6012-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to NULL memebers in bt_att_unref casue att if freed
at the end of function.
---
 src/shared/att.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 956fa8c..08bf2b2 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -860,17 +860,12 @@ void bt_att_unref(struct bt_att *att)
 		destroy_att_send_op(att->pending_ind);
 
 	io_destroy(att->io);
-	att->io = NULL;
 
 	queue_destroy(att->req_queue, NULL);
 	queue_destroy(att->ind_queue, NULL);
 	queue_destroy(att->write_queue, NULL);
 	queue_destroy(att->notify_list, NULL);
 	queue_destroy(att->disconn_list, NULL);
-	att->req_queue = NULL;
-	att->ind_queue = NULL;
-	att->write_queue = NULL;
-	att->notify_list = NULL;
 
 	if (att->timeout_destroy)
 		att->timeout_destroy(att->timeout_data);
@@ -879,7 +874,6 @@ void bt_att_unref(struct bt_att *att)
 		att->debug_destroy(att->debug_data);
 
 	free(att->buf);
-	att->buf = NULL;
 
 	free(att);
 }
-- 
1.9.1

