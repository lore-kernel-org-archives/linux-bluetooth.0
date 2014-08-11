Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/9] Bluetooth: SMP fixes & cleanups
Date: Mon, 11 Aug 2014 22:06:35 +0300
Message-Id: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a v2 of all my earlier three patch sets combined. The main change
is renaming l2cap_conn_drop to l2cap_conn_shutdown in order to not be
confused with the slightly different semantics of hci_conn_drop.

Johan

----------------------------------------------------------------
Johan Hedberg (9):
      Bluetooth: Use L2CAP resume callback to call smp_distribute_keys
      Bluetooth: Add public l2cap_conn_shutdown() API to request disconnection
      Bluetooth: Call l2cap_conn_shutdown() when SMP recv callback fails
      Bluetooth: Fix double free of SMP data skb
      Bluetooth: Add SMP-internal timeout callback
      Bluetooth: Remove unused l2cap_conn->security_timer
      Bluetooth: Move canceling security_timer into smp_chan_destroy()
      Bluetooth: Always call smp_distribute_keys() from a workqueue
      Bluetooth: Make smp_chan_destroy() private to smp.c

 include/net/bluetooth/l2cap.h |   5 +-
 net/bluetooth/l2cap_core.c    |  35 +--
 net/bluetooth/smp.c           | 541 +++++++++++++++++++++-----------------
 net/bluetooth/smp.h           |   3 -
 4 files changed, 330 insertions(+), 254 deletions(-)


