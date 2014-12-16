Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 2/5] shared/queue: clarify queue_match_func_t arguments
Date: Mon, 15 Dec 2014 17:03:33 -0800
Message-Id: <1418691816-40271-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
References: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The queue_match_func_t just looking at the API, it's easy to assume that
both arguments come from internal, while one is provided by the user.
---
 src/shared/queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/queue.h b/src/shared/queue.h
index 0d5a9a5..3bc8d2e 100644
--- a/src/shared/queue.h
+++ b/src/shared/queue.h
@@ -48,7 +48,7 @@ typedef void (*queue_foreach_func_t)(void *data, void *user_data);
 void queue_foreach(struct queue *queue, queue_foreach_func_t function,
 							void *user_data);
 
-typedef bool (*queue_match_func_t)(const void *a, const void *b);
+typedef bool (*queue_match_func_t)(const void *data, const void *match_data);
 
 void *queue_find(struct queue *queue, queue_match_func_t function,
 							const void *match_data);
-- 
2.2.0.rc0.207.ga3a616c

