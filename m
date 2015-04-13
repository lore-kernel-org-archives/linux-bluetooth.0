Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@intel.com,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] tools: Fix bcm43xx download mode delay
Date: Mon, 13 Apr 2015 22:57:19 +0200
Message-Id: <1428958639-4126-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The unit of time is nanoseconds, and we want a 50ms delay.
---
 tools/hciattach_bcm43xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index 81f38cb..c8ef831 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -228,7 +228,7 @@ static int bcm43xx_set_speed(int fd, struct termios *ti, uint32_t speed)
 static int bcm43xx_load_firmware(int fd, const char *fw)
 {
 	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x2e, 0xfc, 0x00 };
-	struct timespec tm_mode = { 0, 50000 };
+	struct timespec tm_mode = { 0, 50000000 };
 	struct timespec tm_ready = { 0, 2000000 };
 	unsigned char resp[CC_MIN_SIZE];
 	unsigned char tx_buf[1024];
-- 
1.9.1

