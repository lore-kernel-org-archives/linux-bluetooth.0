Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] android/gatt: Remove useless variable cast
Date: Fri,  4 Apr 2014 09:31:59 +0200
Message-Id: <1396596720-13779-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396596720-13779-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396596720-13779-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes useless uint8_t array to bdaddr_t cast.
android2bdaddr function expects const void *buf as first parametr.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 68e2112..473929d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2233,7 +2233,7 @@ static void handle_client_register_for_notification(const void *buf,
 		goto failed;
 	}
 
-	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &addr);
+	android2bdaddr(&cmd->bdaddr, &addr);
 
 	dev = queue_find(conn_list, match_dev_by_bdaddr, &addr);
 	if (!dev) {
-- 
1.9.1

