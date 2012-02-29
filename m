Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix Kconfig help description
Date: Wed, 29 Feb 2012 16:38:13 -0300
Message-Id: <1330544293-17831-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SMP is not a kernel module, it is part of Bluetooth Core (as already
described in lines above).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 9ec85eb..3537d38 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -29,7 +29,6 @@ menuconfig BT
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
 	     CMTP Module (CAPI Message Transport Protocol)
 	     HIDP Module (Human Interface Device Protocol)
-	     SMP Module (Security Manager Protocol)
 
 	  Say Y here to compile Bluetooth support into the kernel or say M to
 	  compile it as module (bluetooth).
-- 
1.7.9.2

