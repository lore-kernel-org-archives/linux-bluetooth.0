Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 00/20] Bluetooth: Create AMP physical link
Date: Tue, 24 Jul 2012 16:21:41 +0300
Message-Id: <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set of patches enhances A2MP protocol and creates physical
link between AMP controllers. This is further iteration towards
Bluetooth High Speed.

Changes:
	* v2: Fix typos and bugs, add functionality: now physical connection
	might be established.
	* v1: Fix typos, change debug prints, refactor code for better
	splitting functionality.

Andrei Emeltchenko (19):
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
  Bluetooth: AMP: Create Physical Link
  Bluetooth: AMP: Write remote AMP Assoc
  Bluetooth: A2MP: Add fallback to normal l2cap init sequence
  Bluetooth: AMP: Process Chan Selected event
  Bluetooth: AMP: Process physical link complete event
  Bluetooth: AMP: Send Create Chan Req

Dmitry Kasatkin (1):
  Bluetooth: Add function to derive AMP key using hmac

 include/net/bluetooth/a2mp.h     |   10 ++
 include/net/bluetooth/amp.h      |   25 +++
 include/net/bluetooth/hci.h      |    3 +
 include/net/bluetooth/hci_core.h |   46 ++++++
 include/net/bluetooth/l2cap.h    |    1 +
 include/net/bluetooth/pal.h      |   57 +++++++
 net/bluetooth/Kconfig            |    1 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |  294 ++++++++++++++++++++++++++++++++---
 net/bluetooth/amp.c              |  308 ++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  144 +++++++++++++++++
 net/bluetooth/hci_event.c        |  120 +++++++++++++-
 net/bluetooth/l2cap_core.c       |   64 +++++++-
 net/bluetooth/pal.c              |  318 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 1364 insertions(+), 29 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 include/net/bluetooth/pal.h
 create mode 100644 net/bluetooth/amp.c
 create mode 100644 net/bluetooth/pal.c

-- 
1.7.9.5

