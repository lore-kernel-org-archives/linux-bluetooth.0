Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/11] Bluetooth: Add asynchronous request support
Date: Mon,  4 Mar 2013 12:08:57 +0200
Message-Id: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is essentially what was previously called "transactions" in my
previous patch sets, but now simply reusing the existing term that we
have for grouped HCI commands: requests. The old hci_request API as been
renamed to hci_req_sync() to avoid confusion.

The reason for the name change is that hci_transaction is a bit
uncomfortably long name (compared to hci_req) and the same goes for the
"transaction" variables that were used for it (compered to simply "req").

To keep this patch set reasonably small I've left out a lot of patches
which add more and more users of the new API. This patch set contains
the bare minimum conversion, including the internal usage of the async
request framework for the synchronous (hci_req_sync) functionality.

Johan

----------------------------------------------------------------
Johan Hedberg (11):
      Bluetooth: Rename hci_request to hci_req_sync
      Bluetooth: Fix __hci_req_sync() handling of empty requests
      Bluetooth: Split HCI init sequence into three stages
      Bluetooth: Add initial skeleton for asynchronous HCI requests
      Bluetooth: Refactor HCI command skb creation
      Bluetooth: Introduce new hci_req_cmd function
      Bluetooth: Introduce a hci_req_from_skb function
      Bluetooth: Add request cmd_complete and cmd_status functions
      Bluetooth: Use async requests internally in hci_req_sync
      Bluetooth: Remove unused hdev->init_last_cmd
      Bluetooth: Remove empty HCI event handlers

 include/net/bluetooth/bluetooth.h |   11 +
 include/net/bluetooth/hci_core.h  |   16 +-
 net/bluetooth/hci_core.c          |  669 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c         |  504 +---------------------------
 net/bluetooth/hci_sock.c          |    3 +-
 5 files changed, 601 insertions(+), 602 deletions(-)

