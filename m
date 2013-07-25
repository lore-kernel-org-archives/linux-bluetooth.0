Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Fix make distcheck
Date: Thu, 25 Jul 2013 14:25:46 -0400
Message-Id: <1374776746-14457-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix this error:

make[1]: *** No rule to make target `profiles/audio/audio.conf', needed
by `distdir'.  Stop.
make: *** [test_build] Error 2
---
 Makefile.am |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index cec85b0..b844532 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -173,8 +173,7 @@ man_MANS = src/bluetoothd.8
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
-			profiles/input/input.conf profiles/proximity/proximity.conf \
-			profiles/audio/audio.conf
+			profiles/input/input.conf profiles/proximity/proximity.conf
 
 test_scripts =
 
-- 
1.7.9.5

