Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 00/16] Bluetooth: Change socket lock to l2cap_chan lock
Date: Thu,  9 Feb 2012 16:17:21 +0200
Message-Id: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those small patches which dealing with locks need to be applied at once,
if needed they can be merged together. Please voice opinion about the split.

Changes:
	* RFCv3: Split the big patch to several small (I believe logical) chunks,
	remove unneded locks from cleanup_listen, use the same arguments for
	locked/unlocked socket error functions.
	* RFCv2: Convert l2cap channel list back to mutex from RCU list.

This is DRAFT RFC introducing l2cap channel lock. Please make suggestion how to
make it better.

Andrei Emeltchenko (16):
  Bluetooth: trivial: Fix long line
  Bluetooth: Revert to mutexes from RCU list
  Bluetooth: Do not use sk lock in get_chan functions
  Bluetooth: Add l2cap_chan_lock
  Bluetooth: Add locked and unlocked state_change
  Bluetooth: Add socket error function
  Bluetooth: Add unlocked __l2cap_chan_add function
  Bluetooth: Use chan lock in timers
  Bluetooth: Use chan lock in L2CAP sig commands
  Bluetooth: Use chan lock in chan delete functions
  Bluetooth: Use chan lock in L2CAP conn start
  Bluetooth: Use chan lock in receiving data
  Bluetooth: Change locking logic for conn/chan ready
  Bluetooth: Change locking logic in security_cfm
  Bluetooth: Use l2cap chan lock in socket connect
  Bluetooth: Remove socket lock check

 include/net/bluetooth/l2cap.h |   11 ++
 net/bluetooth/l2cap_core.c    |  388 +++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |   23 ++-
 3 files changed, 268 insertions(+), 154 deletions(-)

-- 
1.7.8.3

