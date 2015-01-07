Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] shared/queue: Fix NULL data handling in queue_remove_all
Date: Wed,  7 Jan 2015 17:26:03 +0100
Message-Id: <1420647963-5469-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1420647963-5469-1-git-send-email-szymon.janc@tieto.com>
References: <1420647963-5469-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

queue_remove_if returns data so we must check entries count to detect
if entry was removed (with NULL data) or not found.
---
 src/shared/queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index d94b34d..3507ed1 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -362,9 +362,10 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
 	if (function) {
 		while (entry) {
 			void *data;
+			unsigned int entries = queue->entries;
 
 			data = queue_remove_if(queue, function, user_data);
-			if (!data)
+			if (entries == queue->entries)
 				break;
 
 			if (destroy)
-- 
1.9.1

