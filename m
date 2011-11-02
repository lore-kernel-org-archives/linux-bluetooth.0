Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 00/20] RFC A2MP implementation
Date: Wed,  2 Nov 2011 16:02:28 +0200
Message-Id: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

RFC meant to indicate our current development status.

Code based on Code Aurora (git://codeaurora.org/kernel/msm.git) and Atheros
(search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3)
implementations (mostly Code Aurora). Main difference to the original code is
- code rebase against recent bluetooth-next
- rewritten way to send A2MP msgs
- handling fixed channel modifications
- I was trying to separate AMP vs A2MP name usage. AMP is used for
"Alternate MAC PHY" controller, A2MP for "AMP Manager Protocol".
- fixes related to PTS beta A2MP tests

Andrei Emeltchenko (20):
  Bluetooth: A2MP: create A2MP socket
  Bluetooth: A2MP: sk_data_ready for a2mp socket
  Bluetooth: A2MP: sk_state_change for a2mp socket
  Bluetooth: A2MP: build and send msg helpers
  Bluetooth: A2MP: AMP Manager basic functions
  Bluetooth: A2MP: Remove AMP manager in state_change
  Bluetooth: A2MP: AMP manager initialization
  Bluetooth: A2MP: Definitions for A2MP commands
  Bluetooth: A2MP: process A2MP messages
  Bluetooth: A2MP: processing A2MP command reject
  Bluetooth: A2MP: helper functions to count HCI devs
  Bluetooth: A2MP: process A2MP Discover Request
  Bluetooth: A2MP: process A2MP Change Notify
  Bluetooth: A2MP: process A2MP Get Info Request
  Bluetooth: A2MP: process A2MP Get AMP Assoc Request
  Bluetooth: A2MP: process A2MP Create Physlink Request
  Bluetooth: A2MP: process A2MP Disc Physlink Request
  Bluetooth: A2MP: process A2MP Command Responses
  Bluetooth: A2MP: handling fixed channel
  Bluetooth: A2MP: manage incoming connection

 include/net/bluetooth/a2mp.h     |  135 ++++++++
 include/net/bluetooth/hci_core.h |   14 +
 include/net/bluetooth/l2cap.h    |    5 +
 net/bluetooth/a2mp.c             |  630 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       |   81 ++++--
 5 files changed, 845 insertions(+), 20 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h
 create mode 100644 net/bluetooth/a2mp.c

-- 
1.7.4.1

