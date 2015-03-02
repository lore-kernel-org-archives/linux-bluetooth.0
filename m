Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/7] Bluetooth: Refactoring of generic mgmt API
Date: Mon,  2 Mar 2015 22:13:46 +0200
Message-Id: <1425327233-4427-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v2: Fix typo in commit message of patch 5/7

from original cover letter:

This set of patches tries to do some initial work towards being able to
have multiple different HCI channels with mgmt-like semantics. For now
we only have HCI_CHANNEL_CONTROL, but the idea is to have 6lowpan use
the same styled interface in the future.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Add mgmt HCI channel registration API
      Bluetooth: Convert mgmt to use HCI chan registration API
      Bluetooth: Move all mgmt command quirks to handler table
      Bluetooth: Rename cmd_status() to mgmt_cmd_status()
      Bluetooth: Rename cmd_complete() to mgmt_cmd_complete()
      Bluetooth: Rename pending_cmd to mgmt_pending_cmd
      Bluetooth: Add mgmt_send_event() helper to send to any HCI channel

 include/net/bluetooth/bluetooth.h |    3 +
 include/net/bluetooth/hci_core.h  |   25 +-
 net/bluetooth/af_bluetooth.c      |    9 +
 net/bluetooth/hci_sock.c          |   94 ++-
 net/bluetooth/mgmt.c              | 1288 +++++++++++++++++++-----------------
 5 files changed, 781 insertions(+), 638 deletions(-)


