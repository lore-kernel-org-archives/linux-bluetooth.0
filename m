Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 00/16] Bluetooth: Add HCI transaction framework
Date: Wed, 27 Feb 2013 09:57:08 +0200
Message-Id: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a revised set with the left-over init_last_cmd patch inserted
where it belongs in the set.

The other changes are based on an (off-list) review from Gustavo
Padovan, resulting in removing unnecessary _irqsave versions of spinlock
functions (for the skb queue), adding a hci_ prefix to some static
hci_core.c functions as well as really removing the HCI_PENDING_CLASS
flag (and not just its users).

Johan

----------------------------------------------------------------
Johan Hedberg (16):
      Bluetooth: Fix __hci_request() handling of empty requests
      Bluetooth: Split HCI init sequence into three stages
      Bluetooth: Add initial skeleton for HCI transaction framework
      Bluetooth: Refactor HCI command skb creation
      Bluetooth: Introduce new hci_transaction_cmd function
      Bluetooth: Introduce a hci_transaction_from_skb function
      Bluetooth: Add transaction cmd_complete and cmd_status functions
      Bluetooth: Convert hci_request to use HCI transaction framework
      Bluetooth: Remove unused hdev->init_last_cmd
      Bluetooth: Move power on HCI command updates to their own function
      Bluetooth: Update mgmt powered HCI commands to use transactions
      Bluetooth: Wait for HCI command completion with mgmt_set_powered
      Bluetooth: Fix busy condition testing for EIR and class updates
      Bluetooth: Fix UUID/class mgmt command response synchronization
      Bluetooth: Remove useless HCI_PENDING_CLASS flag
      Bluetooth: Remove empty HCI event handlers

 include/net/bluetooth/bluetooth.h |   11 +
 include/net/bluetooth/hci.h       |    1 -
 include/net/bluetooth/hci_core.h  |   20 +-
 net/bluetooth/hci_core.c          |  649 ++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_event.c         |  507 +----------------------------
 net/bluetooth/hci_sock.c          |    3 +-
 net/bluetooth/mgmt.c              |  326 +++++++++++++------
 7 files changed, 826 insertions(+), 691 deletions(-)

