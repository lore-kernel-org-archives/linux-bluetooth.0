Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/gatt: Send notify mtu change for BR/EDR success conn
Date: Wed, 29 Apr 2015 11:15:52 +0200
Message-Id: <1430298953-31018-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes sending mtu change notification for BR/EDR gatt
connections. For unsuccessful connection, notify mtu change shouldn't be
sent. This avoid sending bogus mtu values as notify mtu change.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 656abfc..04f89af 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1652,7 +1652,7 @@ reply:
 									&data);
 
 	/* For BR/EDR notify about MTU since it is not negotiable*/
-	if (cid != ATT_CID)
+	if (cid != ATT_CID && status == GATT_SUCCESS)
 		queue_foreach(app_connections, notify_mtu_change, dev);
 
 	device_unref(dev);
-- 
2.1.0

