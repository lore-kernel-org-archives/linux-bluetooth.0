Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 00/11] Ext scan/connect and PHY Configuration
Date: Mon,  5 Mar 2018 16:57:58 +0530
Message-Id: <1520249289-3111-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The patch set implements extended scanning and conection and use it
based on the controller support.

This also implements PHY configuration mgmt commands and events
to set defualt PHY and PHYs to be used for scan and connect.

One downside of this approch is user cannot force kernel to use
legacy comands if controller is 5.0.

v1: Fixed data types of phy variables in Set PHY configuration and
Get PHY configuration commands

Jaganath Kanakkassery (11):
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

 include/net/bluetooth/hci.h      | 110 ++++++++++++
 include/net/bluetooth/hci_core.h |  15 ++
 include/net/bluetooth/mgmt.h     |  31 ++++
 net/bluetooth/hci_conn.c         | 103 +++++++++--
 net/bluetooth/hci_core.c         |  17 ++
 net/bluetooth/hci_event.c        | 371 ++++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_request.c      | 156 +++++++++++-----
 net/bluetooth/hci_sock.c         |   1 +
 net/bluetooth/mgmt.c             | 231 ++++++++++++++++++++++++
 9 files changed, 914 insertions(+), 121 deletions(-)

-- 
2.7.4

