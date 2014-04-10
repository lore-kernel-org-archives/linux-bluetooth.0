Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/gatt: Simplify removing device from list
Date: Thu, 10 Apr 2014 20:40:36 +0200
Message-Id: <1397155238-8578-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4a720cc..857ffe0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1194,7 +1194,7 @@ reply:
 
 	/* If this is last client do more cleaning */
 	connection_cleanup(dev);
-	dev = queue_remove_if(conn_list, match_dev_by_bdaddr, &dev->bdaddr);
+	queue_remove(conn_list, dev);
 	put_device_on_disc_list(dev);
 }
 
-- 
1.8.3.1

