Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/3] Avoiding lockdep warnings in 6lowpan
Date: Tue, 28 Oct 2014 17:16:46 +0200
Message-Id: <1414509409-11970-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v3:
- typo in patch 2 commit message (s/ieee802162/ieee802154/)


v2:
- rebased on top of latest upstream
- fixed indentation error in patch 1


v1:
patch 1 changes all rwlocks to RCU as suggested by Peter Hurley.
This should help the performance.

The patch 2 is ported from ieee802154 as suggested by Alex Aring.
This will help avoid lockdep warnings in certain transmit scenarios.

The patch 3 changes normal spin locks to spin_lock_bh() variant when
queueing outgoing packets in hci_queue_acl(). This is needed as packets
coming from 6lowpan link are sent from softirq. Thanks again to
Peter Hurley pointing this out.


Cheers,
Jukka


Jukka Rissanen (3):
  Bluetooth: 6lowpan: Converting rwlocks to use RCU
  Bluetooth: 6lowpan: Fix lockdep splats
  Bluetooth: Wrong style spin lock used

 net/bluetooth/6lowpan.c  | 241 ++++++++++++++++++++++++++++-------------------
 net/bluetooth/hci_core.c |   4 +-
 2 files changed, 148 insertions(+), 97 deletions(-)

-- 
1.8.3.1

