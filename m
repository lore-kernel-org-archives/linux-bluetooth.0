Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Allow Bluez to select flushable or non-flushable ACL packets
Date: Mon, 13 Dec 2010 16:38:24 +0200
Message-Id: <1292251105-31130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Slight modification of original patch from Nick Pelly <npelly@google.com>

Changes: rebasing, simplifying logic, using SOL_BLUETOOTH instead of SOL_L2CAP.

No changes done for RFCOMM sockets since no use case exist so far but can be
added later

Andrei Emeltchenko (1):
  Bluetooth: Use non-flushable pb flag by default for ACL data on
    capable chipsets.

 include/net/bluetooth/bluetooth.h |    5 +++++
 include/net/bluetooth/hci.h       |    2 ++
 include/net/bluetooth/hci_core.h  |    1 +
 include/net/bluetooth/l2cap.h     |    2 ++
 net/bluetooth/hci_core.c          |    6 ++++--
 net/bluetooth/l2cap.c             |   33 +++++++++++++++++++++++++++++++--
 6 files changed, 45 insertions(+), 4 deletions(-)

