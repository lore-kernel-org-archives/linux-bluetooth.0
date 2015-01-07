Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] shared/queue: Fix queue_remove_all entires count
Date: Wed,  7 Jan 2015 16:50:10 +0100
Message-Id: <1420645810-20081-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1420645810-20081-1-git-send-email-szymon.janc@tieto.com>
References: <1420645810-20081-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

queue_remove_if already updates entries count. This was resulting in
entires being decremented twice resulting in integer overlfow.
---
 src/shared/queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index ccf2f07..d94b34d 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -372,8 +372,6 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 
 			count++;
 		}
-
-		queue->entries -= count;
 	} else {
 		queue->head = NULL;
 		queue->tail = NULL;
-- 
1.9.1

