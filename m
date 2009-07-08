Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Add chipset id for brf6350.
Date: Wed,  8 Jul 2009 16:51:35 -0700
Message-Id: <1247097095-17136-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciattach_tialt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 72633ad..dcd3de4 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -245,7 +245,7 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 			"brf6100",
 			"brf6150",
 			"brf6300",
-			"unknown",
+			"brf6350",
 			"unknown",
 			"wl1271"
 		};
-- 
1.6.3.1

