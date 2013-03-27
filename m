Return-Path: <cyrus@holtmann.org>
From: yegorslists@googlemail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] hciattach: fix firmware path
Date: Wed, 27 Mar 2013 15:49:09 +0100
Message-Id: <1364395749-20156-1-git-send-email-yegorslists@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Yegor Yefremov <yegorslists@googlemail.com>

Change firmware path to /lib/firmware/ti-connectivity/ to be
conform with linux-firmware folder structure. All wl1xxx firmware
resides in ti-connectivity. See linux-firmware repository
https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
for reference.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 tools/hciattach_ti.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index b57c6b7..8322b45 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -55,7 +55,7 @@
 
 #define TI_MANUFACTURER_ID	13
 
-#define FIRMWARE_DIRECTORY	"/lib/firmware/"
+#define FIRMWARE_DIRECTORY	"/lib/firmware/ti-connectivity/"
 
 #define ACTION_SEND_COMMAND	1
 #define ACTION_WAIT_EVENT	2
-- 
1.7.7
