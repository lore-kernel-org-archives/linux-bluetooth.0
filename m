Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] Bluetooth: Remove max_tx and tx_window modules paramenter from L2CAP
Date: Mon, 10 May 2010 14:39:40 -0300
Message-Id: <1273513181-28258-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 673a368..a1b826f 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -60,8 +60,6 @@ static int enable_ertm = 1;
 #else
 static int enable_ertm = 0;
 #endif
-static int max_transmit = L2CAP_DEFAULT_MAX_TX;
-static int tx_window = L2CAP_DEFAULT_TX_WINDOW;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -808,9 +806,9 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			pi->mode = L2CAP_MODE_ERTM;
 		else
 			pi->mode = L2CAP_MODE_BASIC;
-		pi->max_tx = max_transmit;
+		pi->max_tx = L2CAP_DEFAULT_MAX_TX;
 		pi->fcs  = L2CAP_FCS_CRC16;
-		pi->tx_win = tx_window;
+		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
@@ -4677,12 +4675,6 @@ module_exit(l2cap_exit);
 module_param(enable_ertm, bool, 0644);
 MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");
 
-module_param(max_transmit, uint, 0644);
-MODULE_PARM_DESC(max_transmit, "Max transmit value (default = 3)");
-
-module_param(tx_window, uint, 0644);
-MODULE_PARM_DESC(tx_window, "Transmission window size value (default = 63)");
-
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth L2CAP ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.7.1
