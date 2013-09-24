Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Bluetooth: Cleanups and LE advertising support
Date: Tue, 24 Sep 2013 17:02:35 +0300
Message-Id: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set is a combination of cleanups that I had in my tree
(patches 1-3) a fix for set_powered (patch 4) and a new mgmt setting to
allow enabling LE advertising (patches 5-8). What's still open is
whether we want to rename the internal HCI_LE_PERIPHERAL flag to match
the "advertising" name used for the mgmt setting, however that can be
done as an independent patch on top of this set if necessary.

I've tested this through my own additions to user space btmgmt and
mgmt-tester tools. Once the general API is acked I'll push those
additions to bluez.git.

Johan

----------------------------------------------------------------
Johan Hedberg (8):
      Bluetooth: Add clarifying comment to bt_sock_wait_state()
      Bluetooth: Clean up socket locking in l2cap_sock_recvmsg
      Bluetooth: Test for HCI_SETUP and HCI_USER_CHANNEL in mgmt_valid_hdev()
      Bluetooth: Fix busy return for mgmt_set_powered in some cases
      Bluetooth: Move mgmt response convenience functions to a better location
      Bluetooth: Use async request for LE enable/disable
      Bluetooth: Add new mgmt setting for LE advertising
      Bluetooth: Add new mgmt_set_advertising command

 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/mgmt.h     |   3 +
 net/bluetooth/af_bluetooth.c     |   1 +
 net/bluetooth/hci_core.c         |   4 +-
 net/bluetooth/hci_event.c        |  11 --
 net/bluetooth/l2cap_sock.c       |   5 +-
 net/bluetooth/mgmt.c             | 276 ++++++++++++++++++++++++++------------
 7 files changed, 199 insertions(+), 102 deletions(-)

