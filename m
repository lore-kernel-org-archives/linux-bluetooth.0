Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: SMP and some other fixes
Date: Wed, 10 Sep 2014 17:37:40 -0700
Message-Id: <1410395866-24301-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The first five patches from this set are various fixes to SMP. The sixth
one is a fix for properly notifying BR/EDR fixed channels, including on
setups when there are no registered connection-oriented BR/EDR channels.

Johan

----------------------------------------------------------------
Johan Hedberg (6):
      Bluetooth: Remove unnecessary early initialization of variable
      Bluetooth: Fix ignoring unknown SMP authentication requirement bits
      Bluetooth: Centralize disallowing SMP commands to a single place
      Bluetooth: Fix SMP security level when we have no IO capabilities
      Bluetooth: Add smp_ltk_sec_level() helper function
      Bluetooth: Fix L2CAP information request handling for fixed channels

 net/bluetooth/hci_event.c  |  5 +---
 net/bluetooth/l2cap_core.c | 53 +++++++++++++++++++++++++---------------
 net/bluetooth/smp.c        | 55 ++++++++++++++++++------------------------
 net/bluetooth/smp.h        |  8 ++++++
 4 files changed, 66 insertions(+), 55 deletions(-)

