Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Bluetooth: White list support for BR/EDR
Date: Wed,  9 Jul 2014 11:18:31 +0300
Message-Id: <1404893918-6908-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set extends the Add/Remove Device commands with the
possibility of passing BR/EDR addresses to them. For now only action
0x01 ("connect") is supported. It has the behavior of enabling page scan
even if the adapter is not set as connectable and will accept
connections from devices which are in the white list.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Unify helpers for bdaddr_list manipulations
      Bluetooth: Introduce a whitelist for BR/EDR devices
      Bluetooth: Update page scan when necessary for Add/Remove Device
      Bluetooth: Fix incorrectly setting HCI_CONNECTABLE
      Bluetooth: Refactor connection request handling
      Bluetooth: Enable page scan also if there are white list entries
      Bluetooth: Add white list lookup for incoming connection requests

 include/net/bluetooth/hci_core.h |  16 ++---
 net/bluetooth/hci_core.c         | 114 ++++++++++++-------------------
 net/bluetooth/hci_event.c        | 133 +++++++++++++++++++++----------------
 net/bluetooth/hci_sock.c         |   4 +-
 net/bluetooth/l2cap_core.c       |   7 +-
 net/bluetooth/mgmt.c             |  94 ++++++++++++++++++++++++--
 6 files changed, 217 insertions(+), 151 deletions(-)


