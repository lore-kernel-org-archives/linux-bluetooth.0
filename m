Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] Bluetooth: Fix race condition with rfkill handling
Date: Fri, 13 Sep 2013 08:58:16 +0300
Message-Id: <1379051898-2630-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Once again updated based on feedback for patch 2/2 from Marcel.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Introduce a new HCI_RFKILLED flag
      Bluetooth: Fix rfkill functionality during the HCI setup stage

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

