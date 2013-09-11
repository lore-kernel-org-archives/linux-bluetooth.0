Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Fix race condition with rfkill handling
Date: Wed, 11 Sep 2013 14:33:57 +0300
Message-Id: <1378899239-5138-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These two patches fix a pretty severe (hence Cc: stable) race condition
with rfkill handling. If a device gets rfkilled before the HCI setup
stage completes it stays unaccessible through the mgmt interface even it
eventually gets unblocked through rfkill.

The situation is easy to reproduce by running "rfkill block all" before
inserting a dongle, "rfkill unblock all" a bit later and then trying
to do e.g. "btmgmt info". The device will not show up there.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Introduce a new HCI_RFKILLED flag
      Bluetooth: Fix rfkill functionality during the HCI setup stage

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

