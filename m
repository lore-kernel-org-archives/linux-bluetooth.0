Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 0/7] Extended advertising with PHY support
Date: Thu,  8 Mar 2018 17:09:27 +0530
Message-Id: <1520509176-17569-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements extended advertising. Currently
only one set will be enabled. PHY support is also added in
the mgmt command.

What pending is to implement enabling of multiple adv set
at a time and rotation of instances if no of adv set supported
is less than no of instances.

Jaganath Kanakkassery (7):
  Bluetooth: Read no of adv sets during init
  Bluetooth: Impmlement extended adv enable
  Bluetooth: Use Set ext adv/scan rsp data if controller supports
  Bluetooth: Implement disable and removal of adv instance
  Bluetooth: Use ext adv for directed adv
  Bluetooth: Implement Set ADV set random address
  Bluetooth: Implement secondary advertising on different PHYs

 include/net/bluetooth/hci.h      |  85 ++++++++
 include/net/bluetooth/hci_core.h |   5 +
 include/net/bluetooth/mgmt.h     |   6 +
 net/bluetooth/hci_conn.c         |  90 ++++++---
 net/bluetooth/hci_core.c         |   6 +
 net/bluetooth/hci_event.c        | 106 ++++++++++
 net/bluetooth/hci_request.c      | 406 +++++++++++++++++++++++++++++++++++----
 net/bluetooth/hci_request.h      |   8 +
 net/bluetooth/mgmt.c             |  39 +++-
 9 files changed, 684 insertions(+), 67 deletions(-)

-- 
2.7.4

