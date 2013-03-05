Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 00/11] Bluetooth: Add asynchronous request support
Date: Tue,  5 Mar 2013 20:37:40 +0200
Message-Id: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a v3 of the patch set with Marcel's feedback taken into account.

Johan

----------------------------------------------------------------
Johan Hedberg (11):
      Bluetooth: Rename hci_request to hci_req_sync
      Bluetooth: Fix __hci_request() handling of empty requests
      Bluetooth: Split HCI init sequence into three stages
      Bluetooth: Add initial skeleton for asynchronous HCI requests
      Bluetooth: Refactor HCI command skb creation
      Bluetooth: Introduce new hci_req_add function
      Bluetooth: Fix stand-alone HCI command handling
      Bluetooth: Add request cmd_complete and cmd_status functions
      Bluetooth: Use async requests internally in hci_req_sync
      Bluetooth: Remove unused hdev->init_last_cmd
      Bluetooth: Remove empty HCI event handlers

 include/net/bluetooth/bluetooth.h |   10 +
 include/net/bluetooth/hci_core.h  |   15 +-
 net/bluetooth/hci_core.c          |  668 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c         |  504 +---------------------------
 net/bluetooth/hci_sock.c          |    5 +
 5 files changed, 603 insertions(+), 599 deletions(-)

