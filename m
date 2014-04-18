Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/6] android/gatt: Remove redundant code
Date: Fri, 18 Apr 2014 02:40:19 +0200
Message-Id: <1397781624-23817-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cache_all_srvc_chars is called only with empty queue so it's redundant
to handle this condition again inside function.
---
 android/gatt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e339789..59bcd23 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1739,10 +1739,6 @@ static void cache_all_srvc_chars(GSList *characteristics, struct queue *q)
 	uint16_t inst_id = 0;
 	bt_uuid_t uuid;
 
-	/* Refresh characteristics cache if already exist */
-	if (!queue_isempty(q))
-		queue_remove_all(q, NULL, NULL, destroy_characteristic);
-
 	for (; characteristics; characteristics = characteristics->next) {
 		struct characteristic *ch;
 
-- 
1.9.2

