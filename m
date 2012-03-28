Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded zero initialization
Date: Wed, 28 Mar 2012 14:56:34 +0300
Message-Id: <1332935794-15319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove zero initialization since channel is allocated with kzalloc
in l2cap_chan_create.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 53e563f..4e73b41 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -999,7 +999,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		}
 
 		chan->imtu = L2CAP_DEFAULT_MTU;
-		chan->omtu = 0;
+
 		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
 			chan->mode = L2CAP_MODE_ERTM;
 			set_bit(CONF_STATE2_DEVICE, &chan->conf_state);
@@ -1011,7 +1011,6 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 		chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
-		chan->flags = 0;
 		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 	}
 
-- 
1.7.9.1

