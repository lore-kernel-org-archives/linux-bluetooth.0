Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 00/14] Bluetooth: Change socket lock to l2cap_chan lock
Date: Mon, 20 Feb 2012 16:21:11 +0200
Message-Id: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
protocol above L2CAP without creating sockets.

Changes:
	* RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged together
	following recommendations from review.
	* RFCv5: Fixed locking bug in l2cap_data_channel, added locks in 
	l2cap_sock_shutdown function, fixed several styles issues.
	* RFCv4: Better split patches so they looks more clear and obvious,
	taking coments about naming change and delete unused vars. See diff change
	from the previous version below:
	* RFCv3: Split the big patch to several small (I believe logical) chunks,
	remove unneded locks from cleanup_listen, use the same arguments for
	locked/unlocked socket error functions.
	* RFCv2: Convert l2cap channel list back to mutex from RCU list.

Andrei Emeltchenko (14):
  Bluetooth: trivial: Fix long line
  Bluetooth: Revert to mutexes from RCU list
  Bluetooth: Add l2cap_chan_lock
  Bluetooth: Add locked and unlocked state_change
  Bluetooth: Add socket error function
  Bluetooth: Add unlocked __l2cap_chan_add function
  Bluetooth: Use chan lock in timers
  Bluetooth: Use chan lock in L2CAP sig commands
  Bluetooth: Use chan lock in L2CAP conn start
  Bluetooth: Use chan lock in receiving data
  Bluetooth: Change locking logic for conn/chan ready
  Bluetooth: Change locking logic in security_cfm
  Bluetooth: Use l2cap chan lock in socket connect
  Bluetooth: Remove socket lock check

 include/net/bluetooth/l2cap.h |   11 ++
 net/bluetooth/l2cap_core.c    |  391 +++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |   34 +++-
 3 files changed, 280 insertions(+), 156 deletions(-)

-- 
1.7.9

