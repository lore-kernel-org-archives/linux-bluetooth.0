Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 4/7] Bluetooth: Add Kconfig option for L2CAP Extended Features
Date: Wed, 14 Apr 2010 16:41:49 -0300
Message-Id: <1271274112-7806-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1271274112-7806-4-git-send-email-padovan@profusion.mobi>
References: <1271274112-7806-1-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-2-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-3-git-send-email-padovan@profusion.mobi>
 <1271274112-7806-4-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP Extended Features are still unstable and under development,
so we are adding them under the EXPERIMENTAL flag to get more feedback
on them. L2CAP Extended Features includes the Enhanced Retransmission
and Streaming Modes, Frame Check Sequence (FCS), and Segmentation and
Reassemby (SAR).

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/Kconfig |   13 +++++++++++++
 net/bluetooth/l2cap.c |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index ed37168..ee3b304 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -43,6 +43,19 @@ config BT_L2CAP
 	  Say Y here to compile L2CAP support into the kernel or say M to
 	  compile it as module (l2cap).
 
+config BT_L2CAP_EXT_FEATURES
+	bool "L2CAP Extended Features support (EXPERIMENTAL)"
+	depends on BT_L2CAP && EXPERIMENTAL
+	help
+	  This option enables the L2CAP Extended Features support. These
+	  new features include the Enhanced Retransmission and Streaming
+	  Modes, the Frame Check Sequence (FCS), and Segmentation and
+	  Reassembly (SAR) for L2CAP packets. They are a required for the
+	  new Alternate MAC/PHY and the Bluetooth Medical Profile.
+
+	  You should say N unless you know what you are doing. Note that
+	  this is in an experimental state yet.
+
 config BT_SCO
 	tristate "SCO links support"
 	depends on BT
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b653039..63248aa 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -55,7 +55,11 @@
 
 #define VERSION "2.14"
 
+#ifdef CONFIG_BT_L2CAP_EXT_FEATURES
+static int enable_ertm = 1;
+#else
 static int enable_ertm = 0;
+#endif
 static int max_transmit = L2CAP_DEFAULT_MAX_TX;
 static int tx_window = L2CAP_DEFAULT_TX_WINDOW;
 
-- 
1.6.4.4
