Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/17] Bluetooth A2MP implementation
Date: Fri, 18 May 2012 17:25:33 +0300
Message-Id: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Basic A2MP implementation.

Changes:
	* PATCHv1: Rebasing against latest tree and minor fixes.
	* RFCv7: Taking comments from review in linux-bluetooth.
	* RFCv6: Remove some unneded check for sk since they are in different path
	(A2MP decoded as a data channel wrt L2CAP signalling channel). Style fixes.
	* RFCv5: Fix memory leaks, sparse warnings and taking comments from upstream.
	* RFCv4: redesign code to use l2cap channel lock instead of socket lock
	and general modifications. Basic implementation of HCI callback interface.
	* RFCv3: redesign code to use l2cap functions instead of kernel sockets
	L2CAP functions modified to work with channels without sk.
	* RFCv2: rebased against "workqueue" patches.
	* RFCv1: added refcnt to amp_mgr, fixed sleeping in atomic

Initially code was based of reference implementations below:

References: Code Aurora (git://codeaurora.org/kernel/msm.git) and Atheros
(search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3)
implementations.

Andrei Emeltchenko (17):
  Bluetooth: A2MP: Create A2MP channel
  Bluetooth: A2MP: AMP Manager basic functions
  Bluetooth: A2MP: Build and Send msg helpers
  Bluetooth: A2MP: Add chan callbacks
  Bluetooth: A2MP: Definitions for A2MP commands
  Bluetooth: A2MP: Define A2MP status codes
  Bluetooth: A2MP: Process A2MP messages
  Bluetooth: A2MP: Process A2MP Command Reject
  Bluetooth: A2MP: Process A2MP Discover Request
  Bluetooth: A2MP: Process A2MP Change Notify
  Bluetooth: A2MP: Process A2MP Get Info Request
  Bluetooth: A2MP: Process A2MP Get AMP Assoc Request
  Bluetooth: A2MP: Process A2MP Create Physlink Request
  Bluetooth: A2MP: Process A2MP Disc Physlink Request
  Bluetooth: A2MP: Process A2MP Command Responses
  Bluetooth: A2MP: Handling fixed channels
  Bluetooth: A2MP: Manage incoming connections

 include/net/bluetooth/a2mp.h     |  127 +++++++++
 include/net/bluetooth/hci_core.h |   14 +
 include/net/bluetooth/l2cap.h    |    6 +
 net/bluetooth/Makefile           |    3 +-
 net/bluetooth/a2mp.c             |  558 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |   15 +
 net/bluetooth/l2cap_core.c       |   43 ++-
 7 files changed, 757 insertions(+), 9 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 net/bluetooth/a2mp.c

-- 
1.7.9.5

