Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/4] Bluetooth: Add synchronous HCI command helpers
Date: Thu,  4 Apr 2013 10:59:03 +0300
Message-Id: <1365062347-860-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's my two previous patch sets combined into one with the comments
received so far taken into account.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Track received events in hdev
      Bluetooth: Add __hci_cmd_sync() helper function
      Bluetooth: Add support for custom event terminated commands
      Bluetooth: Add __hci_cmd_sync_ev function

 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/hci_core.h  |    8 +++
 net/bluetooth/hci_core.c          |  121 ++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c         |   23 ++++++-
 4 files changed, 151 insertions(+), 2 deletions(-)

