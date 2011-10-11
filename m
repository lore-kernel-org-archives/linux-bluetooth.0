Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/4] Convert logical variable to flags
Date: Tue, 11 Oct 2011 14:04:30 +0300
Message-Id: <1318331074-32054-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* PATCHv3: following cumulative change applied:
@@ -944,14 +944,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
                chan->max_tx = pchan->max_tx;
                chan->tx_win = pchan->tx_win;
                chan->sec_level = pchan->sec_level;
-               if (test_bit(FLAG_ROLE_SWITCH, &pchan->flags))
-                       set_bit(FLAG_ROLE_SWITCH, &chan->flags);
-               if (test_bit(FLAG_FORCE_RELIABLE, &pchan->flags))
-                       set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
-               if (test_bit(FLAG_FLUSHABLE, &pchan->flags))
-                       set_bit(FLAG_FLUSHABLE, &chan->flags);
-               if (test_bit(FLAG_FORCE_ACTIVE, &pchan->flags))
-                       set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+               chan->flags = pchan->flags;
        } else {
 
                switch (sk->sk_type) {
@@ -979,9 +972,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
                chan->fcs  = L2CAP_FCS_CRC16;
                chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
                chan->sec_level = BT_SECURITY_LOW;
-               clear_bit(FLAG_ROLE_SWITCH, &chan->flags);
-               clear_bit(FLAG_FORCE_RELIABLE, &chan->flags);
-               clear_bit(FLAG_FLUSHABLE, &chan->flags);
+               chan->flags = 0;
                set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
        }

Andrei Emeltchenko (4):
  Bluetooth: convert flushable variable to flag in l2cap chan
  Bluetooth: convert force_reliable variable to flag in l2cap chan
  Bluetooth: convert force_active variable to flag in l2cap chan
  Bluetooth: convert role_switch variable to flag in l2cap chan

 include/net/bluetooth/l2cap.h |   13 ++++++++---
 net/bluetooth/l2cap_core.c    |   13 ++++++-----
 net/bluetooth/l2cap_sock.c    |   43 ++++++++++++++++++++++++----------------
 3 files changed, 42 insertions(+), 27 deletions(-)

-- 
1.7.4.1

