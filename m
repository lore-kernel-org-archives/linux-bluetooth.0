Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 5/6] android/gatt: Remove device from white list on device destroy
Date: Wed,  3 Sep 2014 08:58:06 +0200
Message-Id: <1409727487-19074-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409727487-19074-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 0182c5d..b086c0f 100644
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

