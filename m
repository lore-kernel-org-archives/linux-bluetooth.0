Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 3/4] Bluetooth: Add module parameter for txWindow size on L2CAP
Date: Mon, 15 Mar 2010 21:26:28 -0300
Message-Id: <1268699189-2910-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1268699189-2910-2-git-send-email-gustavo@padovan.org>
References: <1268699189-2910-1-git-send-email-gustavo@padovan.org>
 <1268699189-2910-2-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Very useful for testing purposes.

Signed-off-by: Gustavo F. Padovan <gustavo@padovan.org>
---
 net/bluetooth/l2cap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 85ec8b2..6f3dc6e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -55,6 +55,7 @@
 
 static int enable_ertm = 0;
 static int max_transmit = L2CAP_DEFAULT_MAX_TX;
+static int tx_window = L2CAP_DEFAULT_TX_WINDOW;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -789,7 +790,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = 0;
 		pi->mode = L2CAP_MODE_BASIC;
 		pi->fcs  = L2CAP_FCS_CRC16;
-		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		pi->tx_win = tx_window;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
@@ -4231,6 +4232,9 @@ MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");
 module_param(max_transmit, uint, 0644);
 MODULE_PARM_DESC(max_transmit, "Max transmit value (default = 3)");
 
+module_param(tx_window, uint, 0644);
+MODULE_PARM_DESC(tx_window, "Transmission window value (default = 63)");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth L2CAP ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.6.4.4
