Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Encryption Key Size fixes & improvements
Date: Thu, 11 Jun 2015 13:52:25 +0300
Message-Id: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches:

 - adds greater control of the LE Encryption Key Size through debugfs
 - adds reading of the encryption key size for BR/EDR connections and
   uses the result appropriately for generating LTKs with SMP over
   BR/EDR

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Add debugfs support for max LE encryption key size
      Bluetooth: Add debugfs support for min LE encryption key size
      Bluetooth: Move SC-only check outside of BT_CONFIG branch
      Bluetooth: Read encryption key size for BR/EDR connections
      Bluetooth: Use actual encryption key size for SMP over BR/EDR

 include/net/bluetooth/hci.h |  10 ++++
 net/bluetooth/hci_event.c   | 111 ++++++++++++++++++++++++++++++++++++-----
 net/bluetooth/smp.c         | 114 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 217 insertions(+), 18 deletions(-)


