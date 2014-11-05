Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/gatt: Initialize includes queue
Date: Wed,  5 Nov 2014 14:01:49 +0100
Message-Id: <1415192511-7651-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initialize included queue even if service is Secondary Service.
---
 android/gatt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b3dd6d3..87a7a12 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -318,8 +318,7 @@ static void destroy_service(void *data)
 	 * So we need to free service memory only once but we need to destroy
 	 * two queues
 	 */
-	if (srvc->primary)
-		queue_destroy(srvc->included, NULL);
+	queue_destroy(srvc->included, NULL);
 
 	free(srvc);
 }
@@ -1092,12 +1091,10 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 
 	/* Put primary service to our local list */
 	s->primary = primary;
-	if (s->primary) {
+	if (s->primary)
 		memcpy(&s->prim, data, sizeof(s->prim));
-	} else {
+	else
 		memcpy(&s->incl, data, sizeof(s->incl));
-		return s;
-	}
 
 	/* For primary service allocate queue for included services */
 	s->included = queue_new();
-- 
1.9.3

