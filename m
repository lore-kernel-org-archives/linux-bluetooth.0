Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: maxin.john@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Andy Duan <fugang.duan@nxp.com>,
        "Maxin B. John" <maxin.john@intel.com>
Subject: [PATCH] hciattach: bcm43xx: fix the delay timer for firmware download
Date: Thu, 20 Jul 2017 16:14:59 +0300
Message-Id: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andy Duan <fugang.duan@nxp.com>

>From the log in .bcm43xx_load_firmware():
        /* Wait 50ms to let the firmware placed in download mode */
        nanosleep(&tm_mode, NULL);

But timespec tm_mode is real is 50us. Correct the delayed timer count.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Maxin B. John <maxin.john@intel.com>
---
 tools/hciattach_bcm43xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index 81f38cb..ac1b3c1 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -228,8 +228,8 @@ static int bcm43xx_set_speed(int fd, struct termios *ti, uint32_t speed)
 static int bcm43xx_load_firmware(int fd, const char *fw)
 {
 	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x2e, 0xfc, 0x00 };
-	struct timespec tm_mode = { 0, 50000 };
-	struct timespec tm_ready = { 0, 2000000 };
+	struct timespec tm_mode = { 0, 50000000 };
+	struct timespec tm_ready = { 0, 200000000 };
 	unsigned char resp[CC_MIN_SIZE];
 	unsigned char tx_buf[1024];
 	int len, fd_fw, n;
-- 
2.4.0

