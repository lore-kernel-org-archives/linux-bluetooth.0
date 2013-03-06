Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: HCI command synchronisation fixes
Date: Wed,  6 Mar 2013 09:16:26 +0200
Message-Id: <1362554191-21753-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches fixes HCI command synchronization for powered, UUID
and Class of Device related mgmt commands. It fixes these issues by
using asynchronous transactions to wait for the completion of the
associated HCI commands and only then responds to user space with a mgmt
command complete event.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Move power on HCI command updates to their own function
      Bluetooth: Update mgmt powered HCI commands to use async requests
      Bluetooth: Wait for HCI command completion with mgmt_set_powered
      Bluetooth: Fix UUID/class mgmt command response synchronization
      Bluetooth: Remove useless HCI_PENDING_CLASS flag

 include/net/bluetooth/hci.h |    1 -
 net/bluetooth/hci_event.c   |    3 +-
 net/bluetooth/mgmt.c        |  288 ++++++++++++++++++++++++++++---------------
 3 files changed, 190 insertions(+), 102 deletions(-)


