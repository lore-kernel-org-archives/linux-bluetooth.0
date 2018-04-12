Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 00/18] Extended Adv, Scan, Connection and PHY support
Date: Thu, 12 Apr 2018 16:49:29 +0530
Message-Id: <1523531987-17140-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements new mgmt API for Get, Set PHY Configuration and setting
of PHY in Advertising. Also implemented extended advertising,
scanning and connection.

Jaganath Kanakkassery (18):
  Bluetooth: Introduce helpers for LE set scan start and complete
  Bluetooth: Use extended scanning if controller supports
  Bluetooth: Process extended ADV report event
  Bluetooth: Introduce helpers for le conn status and complete
  Bluetooth: Use extended LE Connection if supported
  Bluetooth: Define PHY flags in hdev and set 1M as default
  Bluetooth: Implement Get PHY Configuration mgmt command
  Bluetooth: Implement Set PHY Confguration command
  Bluetooth: Set Scan PHYs based on selected PHYs by user
  Bluetooth: Handle extended ADV PDU types
  Bluetooth: Use selected PHYs in extended connect
  Bluetooth: Read no of adv sets during init
  Bluetooth: Impmlement extended adv enable
  Bluetooth: Use Set ext adv/scan rsp data if controller supports
  Bluetooth: Implement disable and removal of adv instance
  Bluetooth: Use ext adv for directed adv
  Bluetooth: Implement Set ADV set random address
  Bluetooth: Implement secondary advertising on different PHYs

 include/net/bluetooth/hci.h      | 195 +++++++++++++
 include/net/bluetooth/hci_core.h |  19 ++
 include/net/bluetooth/mgmt.h     |  37 +++
 net/bluetooth/hci_conn.c         | 191 ++++++++++---
 net/bluetooth/hci_core.c         |  29 +-
 net/bluetooth/hci_event.c        | 478 ++++++++++++++++++++++++++++----
 net/bluetooth/hci_request.c      | 579 +++++++++++++++++++++++++++++++++------
 net/bluetooth/hci_request.h      |   8 +
 net/bluetooth/hci_sock.c         |   1 +
 net/bluetooth/mgmt.c             | 278 ++++++++++++++++++-
 10 files changed, 1622 insertions(+), 193 deletions(-)

-- 
2.7.4

