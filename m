Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Fix issues with LE connection code
Date: Fri, 16 Oct 2015 08:41:38 +0300
Message-Id: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches require Jakub's patch "Bluetooth: fix double scan updates"
to be applied first. All of the fixes are for regressions in the 4.3-rc
series so they should preferably be routed through bluetooth.git instead
of bluetooth-next.git.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Fix reference counting for LE-scan based connections
      Bluetooth: Fix LE reconnection logic
      Bluetooth: Fix remove_device behavior for explicit connects
      Bluetooth: Fix conn_params list update in hci_connect_le_scan_cleanup

 net/bluetooth/hci_conn.c  | 80 ++++++++++++++++++++++++++++++++-------------
 net/bluetooth/hci_core.c  |  7 ----
 net/bluetooth/hci_event.c |  4 +--
 net/bluetooth/mgmt.c      | 12 +++++--
 4 files changed, 69 insertions(+), 34 deletions(-)

