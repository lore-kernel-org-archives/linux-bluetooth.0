Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 0/3] Trivial patches set
Date: Mon,  6 Feb 2012 15:03:58 +0200
Message-Id: <1328533441-29539-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those trivial patches are acked already and might be applied separetely
from the main "locking" patch set.

Andrei Emeltchenko (3):
  Bluetooth: Change chan_ready param from sk to chan
  Bluetooth: Clean up l2cap_chan_add
  Bluetooth: Remove unneeded sk variable

 net/bluetooth/l2cap_core.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

-- 
1.7.8.3

