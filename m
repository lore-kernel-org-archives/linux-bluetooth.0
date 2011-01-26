Return-Path: <cyrus@holtmann.org>
From: pavan.savoy@gmail.com
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Cc: Pavan Savoy <pavan_savoy@sify.com>
Subject: [PATCH] plugins: hciops: remove scan disable on poweroff
Date: Wed, 26 Jan 2011 16:51:55 +0530
Message-Id: <1296040915-5519-1-git-send-email-pavan_savoy@sify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Pavan Savoy <pavan_savoy@sify.com>

remove sending of the scan disable command when the
device is being powered off.

Signed-off-by: Pavan Savoy <pavan_savoy@sify.com>
---
 plugins/hciops.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 719ef01..59a15a0 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -335,14 +335,9 @@ static int hciops_set_pairable(int index, gboolean pairable)
 static int hciops_power_off(int index)
 {
 	struct dev_info *dev = &devs[index];
-	uint8_t mode = SCAN_DISABLED;
 
 	DBG("hci%d", index);
 
-	if (hci_send_cmd(dev->sk, OGF_HOST_CTL,
-					OCF_WRITE_SCAN_ENABLE, 1, &mode) < 0)
-		return -errno;
-
 	if (ioctl(dev->sk, HCIDEVDOWN, index) < 0 && errno != EALREADY)
 		return -errno;
 
-- 
1.7.0.4

