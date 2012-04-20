Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 00/23] RFC Bluetooth A2MP implementation
Date: Fri, 20 Apr 2012 14:09:28 +0300
Message-Id: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Basic A2MP implementation, callback interface to HCI and several usages of the interface.

Changes:
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

Andrei Emeltchenko (23):
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
  Bluetooth: physical link HCI interface to AMP
  Bluetooth: Define AMP controller statuses
  Bluetooth: General HCI callback implementation
  Bluetooth: Process HCI callbacks in a workqueue
  Bluetooth: AMP: Use HCI callback for Read AMP Info
  Bluetooth: AMP: Read Local Assoc support

 include/net/bluetooth/a2mp.h     |  129 +++++++++
 include/net/bluetooth/amp.h      |   21 ++
 include/net/bluetooth/hci.h      |   51 ++++
 include/net/bluetooth/hci_core.h |   44 +++
 include/net/bluetooth/l2cap.h    |    6 +
 net/bluetooth/Makefile           |    3 +-
 net/bluetooth/a2mp.c             |  559 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/amp.c              |  108 ++++++++
 net/bluetooth/hci_conn.c         |   15 +
 net/bluetooth/hci_core.c         |  168 ++++++++++++
 net/bluetooth/hci_event.c        |   57 +++-
 net/bluetooth/l2cap_core.c       |   34 ++-
 12 files changed, 1184 insertions(+), 11 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 net/bluetooth/a2mp.c
 create mode 100644 net/bluetooth/amp.c

-- 
1.7.9.5

