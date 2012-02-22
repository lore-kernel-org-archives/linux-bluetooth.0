Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/3] Bluetooth: Change socket lock to l2cap_chan lock
Date: Wed, 22 Feb 2012 12:43:06 +0200
Message-Id: <1329907389-31173-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
protocols above L2CAP without creating sockets.

Changes:
	* PATCHv2: Rebase remaining parts against latest tree and merge all
	patches dealing with converting sk lock to chan lock together following
	recommendation from Ulisses and Gustavo.
	* PATCHv1: Added extra line (per Gustavo comment)
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

Andrei Emeltchenko (3):
  Bluetooth: Add unlocked __l2cap_chan_add function
  Bluetooth: Change sk lock to chan lock in L2CAP core
  Bluetooth: Remove socket lock check

 net/bluetooth/l2cap_core.c |  173 +++++++++++++++++++++++++++-----------------
 net/bluetooth/l2cap_sock.c |   28 +++++--
 2 files changed, 125 insertions(+), 76 deletions(-)

-- 
1.7.9

