Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 02/11] Bluetooth: Remove L2CAP Extended Features from Kconfig
Date: Mon, 31 May 2010 16:05:18 -0300
Message-Id: <1275332727-16263-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275332727-16263-1-git-send-email-padovan@profusion.mobi>
References: <1275332727-16263-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 84fb0a6334af0ccad3544f6972c055d90fbb9fbe
One can use other mechanisms to enable L2CAP Extended Features.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/Kconfig |   13 -------------
 net/bluetooth/l2cap.c |    4 ----
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index ee3b304..ed37168 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -43,19 +43,6 @@ config BT_L2CAP
 	  Say Y here to compile L2CAP support into the kernel or say M to
 	  compile it as module (l2cap).
 
-config BT_L2CAP_EXT_FEATURES
-	bool "L2CAP Extended Features support (EXPERIMENTAL)"
-	depends on BT_L2CAP && EXPERIMENTAL
-	help
-	  This option enables the L2CAP Extended Features support. These
-	  new features include the Enhanced Retransmission and Streaming
-	  Modes, the Frame Check Sequence (FCS), and Segmentation and
-	  Reassembly (SAR) for L2CAP packets. They are a required for the
-	  new Alternate MAC/PHY and the Bluetooth Medical Profile.
-
-	  You should say N unless you know what you are doing. Note that
-	  this is in an experimental state yet.
-
 config BT_SCO
 	tristate "SCO links support"
 	depends on BT
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 5c636b3..e036419 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -55,11 +55,7 @@
 
 #define VERSION "2.14"
 
-#ifdef CONFIG_BT_L2CAP_EXT_FEATURES
-static int enable_ertm = 1;
-#else
 static int enable_ertm = 0;
-#endif
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
-- 
1.6.4.4
