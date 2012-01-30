Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 0/5] Bluetooth: Change socket lock to l2cap_chan lock
Date: Mon, 30 Jan 2012 17:09:01 +0200
Message-Id: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is DRAFT RFC introducing l2cap channel lock. Please make suggestion how to
make it better.

Beside changing socket locks to l2cap_chan lock channel list lock is reverted.
It is now used to protect RCU updaters or RCU lists which might sleep and not
protected by rcu_read_lock.

Andrei Emeltchenko (5):
  Bluetooth: Use locks in RCU updater code
  Bluetooth: Add l2cap_chan_lock
  Bluetooth: Helper functions for locking change
  Bluetooth: Remove unneeded sk variable
  Bluetooth: Change sk lock to l2cap_chan lock

 include/net/bluetooth/l2cap.h |   11 ++
 net/bluetooth/l2cap_core.c    |  267 ++++++++++++++++++++++++++---------------
 net/bluetooth/l2cap_sock.c    |   13 ++-
 3 files changed, 193 insertions(+), 98 deletions(-)

-- 
1.7.4.1

