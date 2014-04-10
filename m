Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/gatt: Remove double variable check
Date: Thu, 10 Apr 2014 20:40:38 +0200
Message-Id: <1397155238-8578-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b246137..d9dff4f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -580,13 +580,12 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 
 	/* Put primary service to our local list */
 	s->primary = primary;
-	if (s->primary)
+	if (s->primary) {
 		memcpy(&s->prim, data, sizeof(s->prim));
-	else
+	} else {
 		memcpy(&s->incl, data, sizeof(s->incl));
-
-	if (!s->primary)
 		return s;
+	}
 
 	/* For primary service allocate queue for included services */
 	s->included = queue_new();
-- 
1.8.3.1

