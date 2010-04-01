Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 28/34] Bluetooth: Add module parameter for txWindow size on L2CAP
Date: Thu,  1 Apr 2010 17:23:46 -0300
Message-Id: <1270153432-6477-29-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-28-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-26-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-27-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-28-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Very useful for testing purposes.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
[jprvita@profusion.mobi: improved parameter description]
Signed-off-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 8a6d073..32824b9 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -57,6 +57,7 @@
 
 static int enable_ertm = 0;
 static int max_transmit = L2CAP_DEFAULT_MAX_TX;
+static int tx_window = L2CAP_DEFAULT_TX_WINDOW;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -791,7 +792,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = 0;
 		pi->mode = L2CAP_MODE_BASIC;
 		pi->fcs  = L2CAP_FCS_CRC16;
-		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		pi->tx_win = tx_window;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
@@ -4301,6 +4302,9 @@ MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");
 module_param(max_transmit, uint, 0644);
 MODULE_PARM_DESC(max_transmit, "Max transmit value (default = 3)");
 
+module_param(tx_window, uint, 0644);
+MODULE_PARM_DESC(tx_window, "Transmission window size value (default = 63)");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth L2CAP ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.6.4.4
