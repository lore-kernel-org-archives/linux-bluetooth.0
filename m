Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu@prevas.dk>
To: <linux-bluetooth@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu@prevas.dk>
Subject: [PATCH BlueZ] hciattach: add fixed delay between brf actions for texas devices
Date: Thu, 7 Apr 2016 08:47:25 +0200
Message-ID: <1460011645-28754-1-git-send-email-mnhu@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a small delay between doing brf action to avoid stalling the device
and thus failing initialization.

This is tested with wl1835 on a custom mx28 board running mainline
linux-4.4

Without the delay, hciattach fails like this:

~ # ./hciattach ttyAPP1 texas 3000000 flow
Found a Texas Instruments' chip!
Firmware file : /lib/firmware/ti-connectivity/TIInit_11.8.32.bts
Sending script to serial device
Loaded BTS script version 1
texas: changing baud rate to 3000000, flow control to 1
Initialization timed out.
CCCCCCCCCCCCCCCCCCWRCWRCCWRCSCCCWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRW
RWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWR
WRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRW
RWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRCWRCWRCWRCWRCCCCCCWRCWRCCCCCCCCCCWRWRW
RWRWRWRWRWRCCCCCCCCCCCCCCCCCWRCCCCCCWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRW
RWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWR
WRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRW
RWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRWRCCCCCWRWRW
RWRWRCCCCCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRCWRC
WRCWRCCCWRCCCCCCCCCCCCCCCCCCCCCCCCCCW

Signed-off-by: Martin Hundebøll <mnhu@prevas.dk>
---
 tools/hciattach_ti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 828dd61..1935781 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -345,6 +345,9 @@ static int brf_do_action(uint16_t brf_type, uint8_t *brf_action, long brf_size,
 		break;
 	}
 
+	/* sleep here to avoid overwhelming the device leading to a timeout */
+	usleep(1000);
+
 	return ret;
 }
 
-- 
2.8.0

