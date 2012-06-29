Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 00/19] Bluetooth: Create AMP physical link
Date: Fri, 29 Jun 2012 17:46:33 +0300
Message-Id: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set of patches enhances A2MP protocol and creates physical
link between AMP controllers. This is further iteration towards
Bluetooth High Speed.

Andrei Emeltchenko (18):
  Bluetooth: Define AMP controller statuses
  Bluetooth: Do not shadow hdr variable
  Bluetooth: Fix processing A2MP chan in security_cfm
  Bluetooth: General HCI callback implementation
  Bluetooth: Process HCI callbacks in a workqueue
  Bluetooth: Add callback clear to ops->teardown
  Bluetooth: AMP: Use HCI callback for Read AMP Info
  Bluetooth: AMP: Use HCI callback to Read Loc AMP Assoc
  Bluetooth: A2MP: Process Discover Response
  Bluetooth: AMP: Physical link struct definitions
  Bluetooth: AMP: Remote AMP ctrl definitions
  Bluetooth: AMP: Use phylink in create/disc phylink req
  Bluetooth: A2MP: Process A2MP Getinfo Rsp
  Bluetooth: A2MP: Process A2MP Get AMP Assoc Rsp
  Bluetooth: Choose connection based on capabilities
  Bluetooth: AMP: Add AMP key calculation
  Bluetooth: AMP: Create phy link after A2MP Assoc rsp
  Bluetooth: A2MP: Add fallback to normal l2cap init sequence

Dmitry Kasatkin (1):
  Bluetooth: Add function to derive AMP key using hmac

 include/net/bluetooth/a2mp.h     |    9 ++
 include/net/bluetooth/amp.h      |   25 +++
 include/net/bluetooth/hci.h      |   11 ++
 include/net/bluetooth/hci_core.h |   35 ++++
 include/net/bluetooth/l2cap.h    |    1 +
 include/net/bluetooth/pal.h      |   57 +++++++
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |  310 ++++++++++++++++++++++++++++++++---
 net/bluetooth/amp.c              |  214 +++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  144 +++++++++++++++++
 net/bluetooth/hci_event.c        |   58 ++++++-
 net/bluetooth/l2cap_core.c       |   41 ++++-
 net/bluetooth/pal.c              |  328 ++++++++++++++++++++++++++++++++++++++
 13 files changed, 1203 insertions(+), 32 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 include/net/bluetooth/pal.h
 create mode 100644 net/bluetooth/amp.c
 create mode 100644 net/bluetooth/pal.c

-- 
1.7.9.5

