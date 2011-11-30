Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 0/3] AMP HCI interface from A2MP
Date: Wed, 30 Nov 2011 15:54:29 +0200
Message-Id: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The code adds AMP HCI commands from A2MP protocol. HCI events are handled
similar way as mgmt interface. amp_pending is a kind of copy of mgmt_pending.

Andrei Emeltchenko (3):
  Bluetooth: AMP: HCI infrastructure
  Bluetooth: AMP: Initialize and free amp_pending
  Bluetooth: AMP: Read Local AMP Info

 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/a2mp.c             |    4 +
 net/bluetooth/amp.c              |  141 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |    7 ++
 net/bluetooth/hci_event.c        |    4 +
 5 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 net/bluetooth/amp.c

-- 
1.7.4.1

