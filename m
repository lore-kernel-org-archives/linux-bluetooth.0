Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: Fix race condition with rfkill handling
Date: Thu, 12 Sep 2013 12:29:11 +0300
Message-Id: <1378978153-5683-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's an updated patch set for the rfkill issue. The only change is the
added explicit initialization of the HCI_RFKILLED flag by checking the
return value of rfkill_blocked() once rfkill_register() has succeeded.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Introduce a new HCI_RFKILLED flag
      Bluetooth: Fix rfkill functionality during the HCI setup stage

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

