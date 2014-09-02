Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 15/16] android/gatt: Remove device from white list on device destroy
Date: Tue,  2 Sep 2014 12:10:00 +0200
Message-Id: <1409652601-28689-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 8da6120..48bb936 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -722,6 +722,8 @@ static void destroy_device(void *data)
 	queue_destroy(dev->pending_requests, destroy_pending_request);
 	queue_destroy(dev->autoconnect_apps, NULL);
 
+	bt_auto_connect_remove(&dev->bdaddr);
+
 	free(dev);
 }
 
-- 
1.8.4

