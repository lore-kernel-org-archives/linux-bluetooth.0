Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 00/21] RFC Bluetooth A2MP implementation
Date: Thu, 10 Nov 2011 16:54:07 +0200
Message-Id: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* RFCv1 added refcnt to amp_mgr, fixed sleeping in atomic

Code based on Code Aurora (git://codeaurora.org/kernel/msm.git) and Atheros
(search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3)
implementations (mostly Code Aurora). Main difference to the original code is
- code rebase against recent bluetooth-next
- rewritten way to send A2MP msgs
- handling fixed channel modifications
- I was trying to separate AMP vs A2MP name usage. AMP is used for
"Alternate MAC PHY" controller, A2MP for "AMP Manager Protocol".
- fixes related to PTS beta A2MP tests

Andrei Emeltchenko (21):
  Bluetooth: A2MP: Create A2MP socket
  Bluetooth: A2MP: Add sk_data_ready for A2MP socket
  Bluetooth: A2MP: Add sk_state_change for A2MP socket
  Bluetooth: A2MP: Build and Send msg helpers
  Bluetooth: A2MP: AMP Manager basic functions
  Bluetooth: A2MP: Remove AMP manager in state_change
  Bluetooth: A2MP: AMP manager initialization
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
  Bluetooth: A2MP: Handling fixed channel
  Bluetooth: A2MP: Manage incoming connections

 include/net/bluetooth/a2mp.h     |  139 ++++++++
 include/net/bluetooth/hci.h      |    2 +
 include/net/bluetooth/hci_core.h |   14 +
 include/net/bluetooth/l2cap.h    |    5 +
 net/bluetooth/a2mp.c             |  664 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       |   87 ++++--
 6 files changed, 886 insertions(+), 25 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 net/bluetooth/a2mp.c

-- 
1.7.4.1

