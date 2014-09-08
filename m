Return-Path: <cyrus@holtmann.org>
From: roylee17@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Tzu-Jung Lee <roylee17@gmail.com>
Subject: [PATCH 3/3] tools: Fix download mode delay for bcm43xx
Date: Mon,  8 Sep 2014 14:22:00 -0700
Message-Id: <1410211320-16111-3-git-send-email-roylee@paypal.com>
In-Reply-To: <1410211320-16111-1-git-send-email-roylee@paypal.com>
References: <1410211320-16111-1-git-send-email-roylee@paypal.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tzu-Jung Lee <roylee17@gmail.com>

---
 tools/hciattach_bcm43xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index 630220e..53dbce5 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -220,7 +220,7 @@ static int bcm43xx_set_clock(int fd, unsigned char clock)
 static int bcm43xx_load_firmware(int fd, const char *fw)
 {
 	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x2e, 0xfc, 0x00 };
-	struct timespec tm_mode = { 0, 50000 };
+	struct timespec tm_mode = { 0, 50000000 };
 	struct timespec tm_ready = { 0, 2000000 };
 	unsigned char resp[CC_MIN_SIZE];
 	unsigned char tx_buf[1024];
-- 
2.0.4

