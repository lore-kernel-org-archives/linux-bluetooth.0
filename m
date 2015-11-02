Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: L2CAP LE CoC fixes
Date: Mon,  2 Nov 2015 14:39:14 +0200
Message-Id: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These are fixes for missing parameter validity checks in the LE CoC
code.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: L2CAP: Fix returning correct LE CoC response codes
      Bluetooth: L2CAP: Fix checked range when allocating new CID
      Bluetooth: L2CAP: Add missing checks for invalid LE DCID

 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)


