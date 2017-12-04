Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Jaganath Kanakkassery" <jaganathx.kanakkassery@intel.com>
Subject: [RFC 0/9] Extended Adv
Date: Mon,  4 Dec 2017 13:37:44 +0530
Message-Id: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Jaganath Kanakkassery" <jaganathx.kanakkassery@intel.com>

Testing is in progress. Sending RFC patches for initail feedback

Jaganath Kanakkassery (9):
  Bluetooth: Read no of adv sets during init
  Bluetooth: Impmlement extended adv enable
  Bluetooth: Use Set ext adv/scan rsp data if controller supports
  Bluetooth: Implement disable and removal of adv instance
  Bluetooth: Process Adv-Set Terminate event
  Bluetooth: Use ext adv for directed adv
  Bluetooth: Implement Set ADV set random address
  Bluetooth: Handle incoming connection to an adv set
  Bluetooth: Implement secondary advertising on different PHYs

 include/net/bluetooth/hci.h      | 100 +++++-
 include/net/bluetooth/hci_core.h |  18 +-
 include/net/bluetooth/mgmt.h     |   6 +
 net/bluetooth/hci_conn.c         |  90 ++++--
 net/bluetooth/hci_core.c         |  25 +-
 net/bluetooth/hci_event.c        | 280 ++++++++++++++++-
 net/bluetooth/hci_request.c      | 661 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_request.h      |  11 +
 net/bluetooth/mgmt.c             | 155 ++++++---
 9 files changed, 1212 insertions(+), 134 deletions(-)

-- 
2.7.4

