Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: Initialize tx_win_max for fixed channel
Date: Wed,  2 Nov 2011 09:57:10 +0200
Message-Id: <1320220630-13551-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

tx_win_max is initialized during L2CAP configuration phase. For fixed
channels (e.g. A2MP) we want to have it initialized when channel is
created.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 646aefc..9ed6501 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -943,6 +943,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->fcs  = pchan->fcs;
 		chan->max_tx = pchan->max_tx;
 		chan->tx_win = pchan->tx_win;
+		chan->tx_win_max = pchan->tx_win_max;
 		chan->sec_level = pchan->sec_level;
 		chan->flags = pchan->flags;
 	} else {
@@ -971,6 +972,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->max_tx = L2CAP_DEFAULT_MAX_TX;
 		chan->fcs  = L2CAP_FCS_CRC16;
 		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
 		chan->flags = 0;
 		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-- 
1.7.4.1

