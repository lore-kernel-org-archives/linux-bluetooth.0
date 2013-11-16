Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android: Fix sending invalid remote device property event
Date: Sat, 16 Nov 2013 15:09:45 +0100
Message-Id: <1384610986-17990-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
References: <1384610986-17990-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remote device property event has variable length, pass whole event
length to ipc_send, not only header.
---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4439cc6..6a7ba9d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -605,7 +605,7 @@ static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
 	memcpy(&ev->props[0].val, name, strlen(name));
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_REMOTE_DEVICE_PROPS, sizeof(ev), ev, -1);
+			HAL_EV_REMOTE_DEVICE_PROPS, ev_len, ev, -1);
 
 	g_free(ev);
 }
-- 
1.8.4.2

