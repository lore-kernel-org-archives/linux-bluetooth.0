Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: Various SMP cleanups & fixes
Date: Mon, 16 Jun 2014 11:00:27 +0300
Message-Id: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of cleanups and fixes for the SMP code I've come accross
while working with it.

Johan

----------------------------------------------------------------
Johan Hedberg (6):
      Bluetooth: Fix missing NULL check for smp_chan_create() return value
      Bluetooth: Remove unnecessary SMP STK define
      Bluetooth: Remove HCI prefix from SMP LTK defines
      Bluetooth: Remove unused LTK authentication defines
      Bluetooth: Convert SMP flags into an enum
      Bluetooth: Add flexible buffer byte order swapping function

 include/net/bluetooth/hci.h |  9 ---------
 net/bluetooth/hci_core.c    |  2 +-
 net/bluetooth/hci_event.c   |  3 ++-
 net/bluetooth/mgmt.c        |  6 +++---
 net/bluetooth/smp.c         | 41 +++++++++++++++++++----------------------
 net/bluetooth/smp.h         |  7 +++++++
 6 files changed, 32 insertions(+), 36 deletions(-)


