Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Further refactoring of mgmt API
Date: Tue, 17 Mar 2015 13:48:45 +0200
Message-Id: <1426592930-5842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set refactors mgmt command handling further into a new
mgmt_util.c file containing helper functions. After this set the old
mgmt.c file should only contain purely HCI_CHANNEL_CONTROL related
information and we could start introducing new HCI channels using mgmt
semantics.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Add helper to get HCI channel of a socket
      Bluetooth: Add channel parameter to mgmt_pending_find() API
      Bluetooth: Add generic mgmt helper API
      Bluetooth: Add hdev_init callback for HCI channels
      Bluetooth: Move generic mgmt command dispatcher to hci_sock.c

 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci_core.h  |   4 +-
 net/bluetooth/Makefile            |   2 +-
 net/bluetooth/hci_sock.c          | 121 +++++++++++-
 net/bluetooth/mgmt.c              | 393 +++++--------------------------------
 net/bluetooth/mgmt_util.c         | 210 ++++++++++++++++++++
 net/bluetooth/mgmt_util.h         |  53 +++++
 7 files changed, 438 insertions(+), 346 deletions(-)
 create mode 100644 net/bluetooth/mgmt_util.c
 create mode 100644 net/bluetooth/mgmt_util.h


