Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/5] Implement BTLE Network Management interface API
Date: Fri,  4 Mar 2016 13:40:39 +0200
Message-Id: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

	Hi,

This patch set implements kernel support for RFC v3 of the Management
Interface Network API. The current implementation reuses existing
Bluetooth 6LowPAN functionality except for the debugfs interface parts
that are replace by the Management API.

The debugfs implementation for enabling and disabling incoming connection
support is still used, here it is anticipated that it will be replaced
by device whitelisting using the Add Device command in the future.

Please review,

       Patrik


Patrik Flykt (5):
  bluetooth: Merge Bluetooth 6lowpan functionality to bluetooth module
  bluetooth: Implement Get Networks Management API command
  l2cap: Pass hci_dev to l2cap_chan_connect()
  bluetooth: Implement Add Network Management API command
  bluetooth: Implement Remove Network Management API command

 include/net/bluetooth/l2cap.h |   4 +-
 include/net/bluetooth/mgmt.h  |  40 ++++
 net/bluetooth/6lowpan.c       | 495 ++++++++++++++++++++++++++++--------------
 net/bluetooth/Kconfig         |   2 +-
 net/bluetooth/Makefile        |   4 +-
 net/bluetooth/af_bluetooth.c  |  11 +
 net/bluetooth/l2cap_core.c    |   6 +-
 net/bluetooth/l2cap_sock.c    |   5 +-
 net/bluetooth/mgmt.c          |   9 +
 9 files changed, 397 insertions(+), 179 deletions(-)

-- 
2.1.4

