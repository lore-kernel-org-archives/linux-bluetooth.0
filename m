Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/8] Bluetooth: SMP fixes/improvements
Date: Fri,  5 Sep 2014 22:19:47 +0300
Message-Id: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This v4 adds has the following changes to previous revisions:

* Add KEY_DIST_MASK define to avoid hard-coded 0x07 values
* Update the last patch to use defines instead of helper functions
* Update the last patch to use a "drop:" label to simplify the
if-statment used for dropping data.

Johan

----------------------------------------------------------------
Johan Hedberg (8):
      Bluetooth: Remove unnecessary checks after canceling SMP security timer
      Bluetooth: Don't take any action in smp_resume_cb if not encrypted
      Bluetooth: Move identity address update behind a workqueue
      Bluetooth: Remove unnecessary deferred work for SMP key distribution
      Bluetooth: Fix locking of the SMP context
      Bluetooth: Add define for key distribution mask
      Bluetooth: Fix calling smp_distribute_keys() when still waiting for keys
      Bluetooth: Add strict checks for allowed SMP PDUs

 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/l2cap.h    |   3 +-
 net/bluetooth/l2cap_core.c       |  10 +-
 net/bluetooth/smp.c              | 225 +++++++++++++++++++++--------------
 net/bluetooth/smp.h              |   2 +
 5 files changed, 147 insertions(+), 94 deletions(-)

