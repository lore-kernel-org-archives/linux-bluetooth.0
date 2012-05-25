Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 00/12] Another step in l2cap_core/sock separation
Date: Fri, 25 May 2012 09:30:52 -0300
Message-Id: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This is just a rebase on top of lastest bluetooth-next tree, as the
__constant_cpu_to_le patch from Andrei broke this patch series.

Gustavo Padovan (12):
  Bluetooth: Remove extra l2cap_state_change(BT_CONNECTED)
  Bluetooth: Move clean up code and set of SOCK_ZAPPED to l2cap_sock.c
  Bluetooth: Add l2cap_chan->ops->ready()
  Bluetooth: Use l2cap_chan_ready() in LE path
  Bluetooth: Use chan->state instead of sk->sk_state
  Bluetooth: Move check for backlog size to l2cap_sock.c
  Bluetooth: Create DEFER_SETUP flag in conf_state
  Bluetooth: Add chan->ops->defer()
  Bluetooth: check for already existent channel before create new one
  Bluetooth: Move bt_accept_enqueue() call to l2cap_sock.c
  Bluetooth: Remove parent socket usage from l2cap_core.c
  Bluetooth: Used void * as parameter in alloc_skb()

 include/net/bluetooth/l2cap.h |    8 ++-
 net/bluetooth/l2cap_core.c    |  152 ++++++++++-------------------------------
 net/bluetooth/l2cap_sock.c    |  129 ++++++++++++++++++++++++++++++++--
 3 files changed, 164 insertions(+), 125 deletions(-)

-- 
1.7.10.1

