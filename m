Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android: Fix not unregistering last profile
Date: Thu, 17 Apr 2014 08:44:23 +0200
Message-Id: <1397717063-1442-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index e229a6d..99ab376 100644
--- a/android/main.c
+++ b/android/main.c
@@ -377,7 +377,7 @@ static void cleanup_services(void)
 
 	DBG("");
 
-	for (i = HAL_SERVICE_ID_BLUETOOTH; i < HAL_SERVICE_ID_MAX; i++) {
+	for (i = HAL_SERVICE_ID_BLUETOOTH; i < HAL_SERVICE_ID_MAX + 1; i++) {
 		if (!services[i])
 			continue;
 
-- 
1.9.1

