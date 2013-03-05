Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/11] Bluetooth: Add asynchronous request support
Date: Tue,  5 Mar 2013 10:28:59 +0200
Message-Id: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a v2 of the patch set with previous feedback taken into account.

One notable thing is with the request complete callback where I decided
after all to ommit the last_opcode parameter. The reason for this is
that it is indeed only used for logging in subsequent patches which is a
bit redundant with the logs already existing in the other functions
leading to the complete callback, and the same info is also available
with tools like btmon. Furthermore, if some future piece of code really
does end up needing this info it can always be dug out from
hdev->sent_cmd.

Johan

----------------------------------------------------------------
Johan Hedberg (11):
      Bluetooth: Rename hci_request to hci_req_sync
      Bluetooth: Fix __hci_request() handling of empty requests
      Bluetooth: Split HCI init sequence into three stages
      Bluetooth: Add initial skeleton for asynchronous HCI requests
      Bluetooth: Refactor HCI command skb creation
      Bluetooth: Introduce new hci_req_add function
      Bluetooth: Introduce a hci_req_from_skb function
      Bluetooth: Add request cmd_complete and cmd_status functions
      Bluetooth: Use async requests internally in hci_req_sync
      Bluetooth: Remove unused hdev->init_last_cmd
      Bluetooth: Remove empty HCI event handlers

 include/net/bluetooth/bluetooth.h |   10 +
 include/net/bluetooth/hci_core.h  |   16 +-
 net/bluetooth/hci_core.c          |  673 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c         |  504 +--------------------------
 net/bluetooth/hci_sock.c          |    3 +-
 5 files changed, 603 insertions(+), 603 deletions(-)


