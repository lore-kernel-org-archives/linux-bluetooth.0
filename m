Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/15] Bluetooth: Add HCI transaction framework
Date: Fri, 22 Feb 2013 16:48:17 +0200
Message-Id: <1361544512-4056-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a v2 of the whole set since I had messed up patches 09 and 10 a
little bit. There's on extra patch in the set since I ended up splitting
the old patch 09 into two (09 and 10 in this set) for slightly better
readability.

Johan

----------------------------------------------------------------
Johan Hedberg (15):
      Bluetooth: Fix __hci_request() handling of empty requests
      Bluetooth: Split HCI init sequence into three stages
      Bluetooth: Add initial skeleton for HCI transaction framework
      Bluetooth: Refactor HCI command skb creation
      Bluetooth: Introduce new hci_transaction_cmd function
      Bluetooth: Introduce a hci_transaction_from_skb function
      Bluetooth: Add transaction cmd_complete and cmd_status functions
      Bluetooth: Convert hci_request to use HCI transaction framework
      Bluetooth: Move power on HCI command updates to their own function
      Bluetooth: Update mgmt powered HCI commands to use transactions
      Bluetooth: Wait for HCI command completion with mgmt_set_powered
      Bluetooth: Fix busy condition testing for EIR and class updates
      Bluetooth: Fix UUID/class mgmt command response synchronization
      Bluetooth: Remove useless HCI_PENDING_CLASS flag
      Bluetooth: Remove empty HCI event handlers

 include/net/bluetooth/bluetooth.h |   11 +
 include/net/bluetooth/hci_core.h  |   20 +-
 net/bluetooth/hci_core.c          |  647 ++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_event.c         |  507 +----------------------------
 net/bluetooth/hci_sock.c          |    3 +-
 net/bluetooth/mgmt.c              |  326 ++++++++++++-------
 6 files changed, 830 insertions(+), 684 deletions(-)

