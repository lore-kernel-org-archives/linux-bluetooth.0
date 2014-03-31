Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Simplify find_device helper
Date: Mon, 31 Mar 2014 11:26:45 +0200
Message-Id: <1396258005-30573-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We don't need to use dev pointer in second search attempt.
---
 android/gatt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e361506..1bddbcf 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -805,11 +805,7 @@ static struct gatt_device *find_device(bdaddr_t *addr)
 	if (dev)
 		return dev;
 
-	dev = queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
-	if (dev)
-		return dev;
-
-	return NULL;
+	return queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
 }
 
 static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
-- 
1.8.3.1

