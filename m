Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 00/34] RFC Bluetooth A2MP implementation
Date: Thu, 19 Jan 2012 11:19:49 +0200
Message-Id: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* RFCv3 redesign code to use l2cap functions instead of kernel sockets
	L2CAP functions modified to work with channels without sk.
	* RFCv2 rebased against "workqueue" patches.
	* RFCv1 added refcnt to amp_mgr, fixed sleeping in atomic

Some code based of reference implementations below.

References: Code Aurora (git://codeaurora.org/kernel/msm.git) and Atheros
(search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3)
implementations (mostly Code Aurora).

Andrei Emeltchenko (34):
  Bluetooth: trivial: space correction
  Bluetooth: trivial: clean up of l2cap_chan_connect
  Bluetooth: Make ertm_init available
  Bluetooth: Make l2cap_ertm_data_rcv available
  Bluetooth: Allocate skb depending on sk
  Bluetooth: Check sk before assigning sk_err
  Bluetooth: Add send function to chan ops
  Bluetooth: Make l2cap_chan_add available
  Bluetooth: A2MP: Create A2MP channel
  Bluetooth: A2MP: AMP Manager basic functions
  Bluetooth: A2MP: Add channel close callback
  Bluetooth: Add state_change for A2MP channel
  Bluetooth: A2MP: Build and Send msg helpers
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
  Bluetooth: Clean up l2cap_chan_add
  Bluetooth: A2MP: Handling fixed channels
  Bluetooth: A2MP: Manage incoming connections
  Bluetooth: physical link HCI interface to AMP
  Bluetooth: Define AMP controller statuses
  Bluetooth: General HCI callback implementation
  Bluetooth: Process HCI callbacks in a workqueue
  Bluetooth: AMP: Use HCI callback for Read AMP Info
  Bluetooth: AMP: Read Local Assoc support

 include/net/bluetooth/a2mp.h     |  127 +++++++++
 include/net/bluetooth/hci.h      |   50 ++++
 include/net/bluetooth/hci_core.h |   41 +++
 include/net/bluetooth/l2cap.h    |   10 +
 net/bluetooth/Makefile           |    4 +-
 net/bluetooth/a2mp.c             |  527 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/amp.c              |   91 +++++++
 net/bluetooth/hci_core.c         |  144 +++++++++++
 net/bluetooth/hci_event.c        |   58 ++++-
 net/bluetooth/l2cap_core.c       |   99 ++++++--
 10 files changed, 1121 insertions(+), 30 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 net/bluetooth/a2mp.c
 create mode 100644 net/bluetooth/amp.c

-- 
1.7.4.1

