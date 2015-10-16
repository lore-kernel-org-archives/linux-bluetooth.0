Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: Fixes for 4.3-rc series
Date: Fri, 16 Oct 2015 10:07:48 +0300
Message-Id: <1444979274-21622-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's the combined set of patches that should be considered for
bluetooth.git.

Johan

----------------------------------------------------------------
Jakub Pawlowski (2):
      Bluetooth: Fix double scan updates
      Bluetooth: Fix initializing conn_params in scan phase

Johan Hedberg (4):
      Bluetooth: Fix reference counting for LE-scan based connections
      Bluetooth: Fix LE reconnection logic
      Bluetooth: Fix remove_device behavior for explicit connects
      Bluetooth: Fix conn_params list update in hci_connect_le_scan_cleanup

 net/bluetooth/hci_conn.c  | 99 +++++++++++++++++++++++++++++++++-------------
 net/bluetooth/hci_core.c  |  7 ----
 net/bluetooth/hci_event.c | 11 ++++--
 net/bluetooth/mgmt.c      | 24 +++++++++--
 4 files changed, 99 insertions(+), 42 deletions(-)

