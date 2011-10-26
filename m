Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Initialize tx_win_max for fixed channel
Date: Wed, 26 Oct 2011 10:44:39 +0300
Message-Id: <1319615079-11734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

tx_win_max is initialized during L2CAP configuration phase. For fixed
channel (like A2MP) we want to have it initialized during channel setup.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9eb3320..7c953f5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -964,6 +964,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->fcs  = pchan->fcs;
 		chan->max_tx = pchan->max_tx;
 		chan->tx_win = pchan->tx_win;
+		chan->tx_win_max = pchan->tx_win_max;
 		chan->sec_level = pchan->sec_level;
 		chan->flags = pchan->flags;
 		chan->amp_pref = pchan->amp_pref;
@@ -993,6 +994,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->max_tx = L2CAP_DEFAULT_MAX_TX;
 		chan->fcs  = L2CAP_FCS_CRC16;
 		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
 		chan->flags = 0;
 		chan->amp_pref = BT_AMP_POLICY_REQUIRE_BR_EDR;
-- 
1.7.4.1

