Return-Path: <cyrus@holtmann.org>
From: roylee17@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Tzu-Jung Lee <roylee17@gmail.com>
Subject: [PATCH 2/3] tools: Use specified uart speed to load firmware for bcm43xx
Date: Mon,  8 Sep 2014 14:21:59 -0700
Message-Id: <1410211320-16111-2-git-send-email-roylee@paypal.com>
In-Reply-To: <1410211320-16111-1-git-send-email-roylee@paypal.com>
References: <1410211320-16111-1-git-send-email-roylee@paypal.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tzu-Jung Lee <roylee17@gmail.com>

---
 tools/hciattach_bcm43xx.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index cb4bfb9..630220e 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -359,9 +359,27 @@ int bcm43xx_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 	if (bcm43xx_locate_patch(FIRMWARE_DIR, chip_name, fw_path)) {
 		fprintf(stderr, "Patch not found, continue anyway\n");
 	} else {
+		/* Speed up firmware loading */
+		if (speed > 3000000 && bcm43xx_set_clock(fd, BCM43XX_CLOCK_48))
+			return -1;
+
+		if (bcm43xx_set_speed(fd, speed))
+			return -1;
+
+		if (set_speed(fd, ti, speed))
+			return -1;
+
 		if (bcm43xx_load_firmware(fd, fw_path))
 			return -1;
 
+		/*
+		 * The controller reset the uart speed to 115200 after
+		 * firmware loading, so we have to reset the terminal
+		 * correspondingly
+		 */
+		if (set_speed(fd, ti, 115200))
+			return -1;
+
 		if (bcm43xx_reset(fd))
 			return -1;
 	}
@@ -375,5 +393,9 @@ int bcm43xx_init(int fd, int speed, struct termios *ti, const char *bdaddr)
 	if (bcm43xx_set_speed(fd, speed))
 		return -1;
 
+	if (set_speed(fd, ti, speed))
+		return -1;
+
+
 	return 0;
 }
-- 
2.0.4

