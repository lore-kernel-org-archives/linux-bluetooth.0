Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/14] Bluetooth: Add HCI transaction framework
Date: Fri, 22 Feb 2013 15:12:25 +0200
Message-Id: <1361538759-13558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is in practice the 4th iteration of the transaction patch set but
since almost no patch matches what was in the earlier iterations I
decided to just leave out the v4 identifier.

The main change compared to the previous patch sets is that the
transaction state is tracked as part of the actual skbs (using the skb
control buffer) instead of some higher-level struct. This means that
hdev->build_transaction, hdev->current_transaction and even the
transaction lock can go away.

There is still a struct hci_transaction, but its purpose is the same as
the old hdev->build_transaction and it's expected to be a stack variable
instead of something dynamically allocated.

The main issue by moving the transaction flow completely into
hdev->cmd_q is that we can no longer easily modify a transaction while
it is already executing. The only transaction that was needing this this
was the init request, and the solution taken was to rewrite the init
request without these on-the-fly conditionals and do it in three
separate stages instead, each with its own __hci_request call. The first
two patches of this set deal with this rework.

While I was fixing the mgmt code for the set_powered HCI command
synchronization bug I also discovered another similar issue with
add_uuid, remove_uuid and set_dev_class. By taking advantage of a
transaction this issue is fixed by patch 12/14.

Johan

----------------------------------------------------------------
Johan Hedberg (14):
      Bluetooth: Fix __hci_request() handling of empty requests
      Bluetooth: Split HCI init sequence into three stages
      Bluetooth: Add initial skeleton for HCI transaction framework
      Bluetooth: Refactor HCI command skb creation
      Bluetooth: Introduce new hci_transaction_cmd function
      Bluetooth: Introduce a hci_transaction_from_skb function
      Bluetooth: Add transaction cmd_complete and cmd_status functions
      Bluetooth: Convert hci_request to use HCI transaction framework
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

