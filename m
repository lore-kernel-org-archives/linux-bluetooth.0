Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] queue: Fix unreachable code
Date: Thu, 19 Jun 2014 16:55:30 +0300
Message-Id: <1403186136-30041-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

I assume passing function == NULL means using direct_match() so make it
reachable.
---
 src/shared/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/queue.c b/src/shared/queue.c
index 8bbb7df..4013293 100644
--- a/src/shared/queue.c
+++ b/src/shared/queue.c
@@ -234,7 +234,7 @@ void *queue_find(struct queue *queue, queue_match_func_t function,
 {
 	struct queue_entry *entry;
 
-	if (!queue || !function)
+	if (!queue)
 		return NULL;
 
 	if (!function)
-- 
1.8.3.2

