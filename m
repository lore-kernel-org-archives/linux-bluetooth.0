Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/10] android/bluetooth: Remove not needed notification_sk checks
Date: Thu, 28 Nov 2013 15:15:29 +0100
Message-Id: <1385648130-12808-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
References: <1385648130-12808-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is now checked inside ipc_send_notif helper.
---
 android/bluetooth.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 68e26fa..fdafb81 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1185,9 +1185,7 @@ static void remove_uuid_complete(uint8_t status, uint16_t length,
 
 	mgmt_dev_class_changed_event(adapter.index, length, param, NULL);
 
-	/* send notification only if bluetooth service is registered */
-	if (notification_sk >= 0)
-		get_uuids();
+	get_uuids();
 }
 
 static void remove_uuid(uint16_t uuid)
@@ -1213,9 +1211,7 @@ static void add_uuid_complete(uint8_t status, uint16_t length,
 
 	mgmt_dev_class_changed_event(adapter.index, length, param, NULL);
 
-	/* send notification only if bluetooth service is registered */
-	if (notification_sk >= 0)
-		get_uuids();
+	get_uuids();
 }
 
 static void add_uuid(uint8_t svc_hint, uint16_t uuid)
-- 
1.8.3.2

