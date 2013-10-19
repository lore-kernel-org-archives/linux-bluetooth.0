Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/9] Bluetooth: Add LE support for mgmt_set_discoverable
Date: Sat, 19 Oct 2013 23:38:14 +0300
Message-Id: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In addition to a couple if fixes in the existing mgmt code (first 5
patches), this patch set adds support for hooking up the
set_discoverable command to LE, in particular the advertising flags.

Johan

----------------------------------------------------------------
Johan Hedberg (9):
      Bluetooth: Check for flag instead of features in update_scan_rsp_data()
      Bluetooth: Check for flag instead of features in update_adv_data()
      Bluetooth: Add missing check for BREDR_ENABLED flag in update_class()
      Bluetooth: Refactor set_connectable settings update to separate function
      Bluetooth: Fix updating settings when there are no HCI commands to send
      Bluetooth: Move mgmt_pending_find to avoid forward declarations
      Bluetooth: Fix sending write_scan_enable when BR/EDR is disabled
      Bluetooth: Move HCI_LIMITED_DISCOVERABLE changes to a general place
      Bluetooth: Update Set Discoverable to support LE

 net/bluetooth/mgmt.c | 147 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 100 insertions(+), 47 deletions(-)

