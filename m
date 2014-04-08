Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hidhost: Don't disconnect channels after sending virtual unplug
Date: Tue,  8 Apr 2014 12:01:10 +0200
Message-Id: <1396951270-7118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is up to receipient to acknowledge this command by disconnecting
L2CAP.

This was affecting TC_HOS_HCR_BV_03_I qualification test case.
---
 android/hidhost.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 81e7eb8..5ea7c5a 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -887,14 +887,10 @@ static void bt_hid_virtual_unplug(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	/* Wait either channels to HUP */
-	if (dev->intr_io)
-		g_io_channel_shutdown(dev->intr_io, TRUE, NULL);
-
-	if (dev->ctrl_io)
-		g_io_channel_shutdown(dev->ctrl_io, TRUE, NULL);
-
-	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
+	/* Remote device shall disconnect to ack this command
+	 * TODO add disconnect guard timer or leave this to upper layer?
+	 * TODO remove bonding or leave this to upper layer?
+	 */
 
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.9.1

