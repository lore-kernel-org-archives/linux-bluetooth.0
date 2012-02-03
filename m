Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 00/10] Bluetooth: Change socket lock to l2cap_chan lock
Date: Fri,  3 Feb 2012 16:36:19 +0200
Message-Id: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* RFCv2: Convert l2cap channel list back to mutex from RCU list.

This is DRAFT RFC introducing l2cap channel lock. Please make suggestion how to
make it better.

Andrei Emeltchenko (10):
  Bluetooth: Change chan_ready param from sk to chan
  Bluetooth: Clean up l2cap_chan_add
  Bluetooth: Remove unneeded sk variable
  Bluetooth: Revert to mutexes from RCU list
  Bluetooth: Add l2cap_chan_lock
  Bluetooth: Add locked and unlocked state_change
  Bluetooth: Add socket error function
  Bluetooth: Change socket lock to chan lock
  Bluetooth: Use l2cap chan lock in socket connect
  Bluetooth: Remove socket lock check

 include/net/bluetooth/l2cap.h |   11 ++
 net/bluetooth/l2cap_core.c    |  379 +++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |   23 ++-
 3 files changed, 258 insertions(+), 155 deletions(-)

-- 
1.7.8.3

