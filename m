Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 00/30] RFC Bluetooth A2MP implementation
Date: Thu, 15 Mar 2012 14:29:51 +0200
Message-Id: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* RFCv4: redesign code to use l2cap channel lock instead of socket lock
	and general modifications. Basic implementation of HCI callback interface.
	* RFCv3: redesign code to use l2cap functions instead of kernel sockets
	L2CAP functions modified to work with channels without sk.
	* RFCv2: rebased against "workqueue" patches.
	* RFCv1: added refcnt to amp_mgr, fixed sleeping in atomic

Some code based of reference implementations below.

References: Code Aurora (git://codeaurora.org/kernel/msm.git) and Atheros
(search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3)
implementations.

Andrei Emeltchenko (30):
  Bluetooth: Make ertm_init available
  Bluetooth: Add send function to chan ops
  Bluetooth: Make l2cap_chan_add available
  Bluetooth: Add set_err to state_change callback
  Bluetooth: Lock sk only if exist
  Bluetooth: Timers fixes
  Bluetooth: A2MP: Create A2MP channel
  Bluetooth: A2MP: AMP Manager basic functions
  Bluetooth: A2MP: Add channel close callback
  Bluetooth: Add state_change for A2MP channel
  Bluetooth: A2MP: Build and Send msg helpers
  Bluetooth: A2MP: skb allocation callback
  Bluetooth: A2MP: Definitions for A2MP commands
  Bluetooth: A2MP: Define A2MP status codes
  Bluetooth: A2MP: Process A2MP messages
  Bluetooth: A2MP: Process A2MP Command Reject
  Bluetooth: A2MP: Helper functions to count HCI devs
  Bluetooth: A2MP: Process A2MP Discover Request
  Bluetooth: A2MP: Process A2MP Change Notify
  Bluetooth: A2MP: Process A2MP Get Info Request
  Bluetooth: A2MP: Process A2MP Get AMP Assoc Request
  Bluetooth: A2MP: Process A2MP Create Physlink Request
  Bluetooth: A2MP: Process A2MP Disc Physlink Request
  Bluetooth: A2MP: Process A2MP Command Responses
  Bluetooth: A2MP: Handling fixed channels
  Bluetooth: A2MP: Manage incoming connections
  Bluetooth: physical link HCI interface to AMP
  Bluetooth: Define AMP controller statuses
  Bluetooth: General HCI callback implementation
  Bluetooth: Process HCI callbacks in a workqueue

 include/net/bluetooth/a2mp.h     |  125 +++++++++
 include/net/bluetooth/hci.h      |   35 +++
 include/net/bluetooth/hci_core.h |   36 +++
 include/net/bluetooth/l2cap.h    |   38 ++-
 net/bluetooth/a2mp.c             |  533 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |   15 +
 net/bluetooth/hci_core.c         |  168 ++++++++++++
 net/bluetooth/l2cap_core.c       |   92 ++++---
 net/bluetooth/l2cap_sock.c       |    8 +-
 9 files changed, 997 insertions(+), 53 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 net/bluetooth/a2mp.c

-- 
1.7.9.1

