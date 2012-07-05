Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Fix "make distcheck"
Date: Thu,  5 Jul 2012 14:12:42 -0300
Message-Id: <1341508362-31995-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

audio/bluetooth.conf was removed and test/sap-client was renamed.
---
 Makefile.am    |    3 ---
 Makefile.tools |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 05da00c..7423687 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -358,9 +358,6 @@ audio_libgstbluetooth_la_CFLAGS = -fvisibility=hidden -fno-strict-aliasing \
 endif
 endif
 
-EXTRA_DIST += audio/bluetooth.conf
-
-
 include Makefile.tools
 
 if DATAFILES
diff --git a/Makefile.tools b/Makefile.tools
index 1626a4b..3cb105c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -211,7 +211,7 @@ else
 EXTRA_DIST += test/rctest.1 test/hciemu.1 test/bdaddr.8
 endif
 
-EXTRA_DIST += test/sap-client test/hsplay test/hsmicro \
+EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
 		test/dbusdef.py test/monitor-bluetooth test/list-devices \
 		test/test-discovery test/test-manager test/test-adapter \
 		test/test-device test/test-service test/test-serial \
-- 
1.7.9.5

