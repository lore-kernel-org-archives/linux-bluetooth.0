Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Baruch Siach <baruch@tkos.co.il>
To: linux-bluetooth@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] hciattach: bcm43xx: delay reset after firmware download
Date: Sun, 29 Jan 2017 15:45:08 +0200
Message-Id: <c23b80351e1a4046f1c0087d2243ed4dc16c0d37.1485697508.git.baruch@tkos.co.il>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The BCM43438 chip on the Raspberry Pi 3 board needs a delay after firmware
download for the setup to complete successfully.

Based on Yocto patch from Phil Elwell.
---
 tools/hciattach_bcm43xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index 81f38cbbcf92..1140379d5cc4 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -380,6 +380,7 @@ int bcm43xx_init(int fd, int def_speed, int speed, struct termios *ti,
 			return -1;
 		}
 
+		sleep(1);
 		if (bcm43xx_reset(fd))
 			return -1;
 	}
-- 
2.11.0

