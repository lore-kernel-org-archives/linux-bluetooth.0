Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Change discoverable mode only if connectable
Date: Tue, 26 Nov 2013 13:00:26 +0100
Message-Id: <1385467227-11832-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to sending set_discoverable command if new settings
are not connectable as clearing connectable also clear discoverable.
Sending set_discoverable when not connectable result in 'rejected'
mgmt response.
---
 android/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index aa684bd..ffca084 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1907,7 +1907,7 @@ static uint8_t set_scan_mode(void *buf, uint16_t len)
 			return HAL_STATUS_FAILED;
 	}
 
-	if (cur_disc != disc) {
+	if (cur_disc != disc && conn) {
 		if (!set_discoverable(disc ? 0x01 : 0x00, 0))
 			return HAL_STATUS_FAILED;
 	}
-- 
1.8.3.2

