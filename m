Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Bluetooth: Scanning & advertising co-existence fixes
Date: Tue,  8 Jul 2014 15:07:46 +0300
Message-Id: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches tries to improve the current behavior of LE scanning
and advertising so that both features can be used nicely together to the
extent that current LE hardware supports them.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Add flag to track the real advertising state
      Bluetooth: Remove unnecessary mgmt_advertising function
      Bluetooth: Use real advertising state to random address update decision
      Bluetooth: Simplify usage of the enable_advertising function
      Bluetooth: Use the correct flag to decide to disable advertising
      Bluetooth: Stop advertising always before initiating a connection
      Bluetooth: Fix advertising and active scanning co-existence

 include/net/bluetooth/hci.h      |  4 +-
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 29 +++++++++--
 net/bluetooth/hci_core.c         |  2 +-
 net/bluetooth/hci_event.c        | 16 ++++--
 net/bluetooth/mgmt.c             | 98 ++++++++++++++++---------------------
 6 files changed, 83 insertions(+), 67 deletions(-)


