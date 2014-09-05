Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Bluetooth: SMP fixes/improvements
Date: Fri,  5 Sep 2014 13:50:59 +0300
Message-Id: <1409914266-21624-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches includes various cleanups and fixes to SMP. The two
major changes are:

* Fix SMP context locking
* Be strict about allowed SMP PDUs and default to dropping unexpected data

The commit messages themselves contain a lenghtier description and
justification of design choices.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Remove unnecessary checks after canceling SMP security timer
      Bluetooth: Don't take any action in smp_resume_cb if not encrypted
      Bluetooth: Move identity address update behind a workqueue
      Bluetooth: Remove unnecessary deferred work for SMP key distribution
      Bluetooth: Fix locking of the SMP context
      Bluetooth: Fix calling smp_distribute_keys() when still waiting for keys
      Bluetooth: Add strict checks for allowed SMP PDUs

 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/l2cap.h    |   3 +-
 net/bluetooth/l2cap_core.c       |  10 +-
 net/bluetooth/smp.c              | 231 ++++++++++++++++++++++-------------
 net/bluetooth/smp.h              |   2 +
 5 files changed, 157 insertions(+), 90 deletions(-)

