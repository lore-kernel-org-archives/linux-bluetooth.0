Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Further SMP fixes & cleanups
Date: Mon, 11 Aug 2014 15:40:14 +0300
Message-Id: <1407760819-25734-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set should be applied only after my "[PATCH 0/3] Some more
SMP fixes" patch set and the "[PATCH] Bluetooth: Fix double free of SMP
data skb" fix. It contains further cleanup of l2cap_core.c, removing
SMP-specific things from there (this time the security_timer).

The important fix (to my initial l2cap_chan conversion) in this set is
to call smp_distribute_keys() through a separate workqueue. Without this
there will inevitably be a deadlock in l2cap_chan_lock() when trying to
update the identity address for all channels.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Add SMP-internal timeout callback
      Bluetooth: Remove unused l2cap_conn->security_timer
      Bluetooth: Move canceling security_timer into smp_chan_destroy()
      Bluetooth: Always call smp_distribute_keys() from a workqueue
      Bluetooth: Make smp_chan_destroy() private to smp.c

 include/net/bluetooth/l2cap.h |   1 -
 net/bluetooth/l2cap_core.c    |  18 +----
 net/bluetooth/smp.c           | 166 ++++++++++++++++++++++++--------------
 net/bluetooth/smp.h           |   2 -
 4 files changed, 106 insertions(+), 81 deletions(-)

