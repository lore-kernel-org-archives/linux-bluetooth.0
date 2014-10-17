Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] android/gatt: Fix return status if cannot alloc memory
Date: Fri, 17 Oct 2014 15:38:12 +0200
Message-Id: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NOMEM HAL status should be returned in case if it's not possible to
alloc memory for notifiaction data.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index ea20941..c26d45a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3759,7 +3759,7 @@ static void handle_client_register_for_notification(const void *buf,
 
 	notification = new0(struct notification_data, 1);
 	if (!notification) {
-		status = HAL_STATUS_FAILED;
+		status = HAL_STATUS_NOMEM;
 		goto failed;
 	}
 
-- 
1.9.3

