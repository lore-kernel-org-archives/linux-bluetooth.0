Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Bluetooth: Bluetooth: LE CoC fixes
Date: Thu, 13 Nov 2014 10:55:16 +0200
Message-Id: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's v2 of this patch set, now without the l2cap_chan locking hack
thanks to the nesting level patches that were already applied.

>From the original cover letter:

This patch set contains various fixes for LE CoC. The biggest functional
change is in the last patch proper reaction to the insufficient
authentication/encryption connection responses is implemented.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix sending incorrect LE CoC PDU in BT_CONNECT2 state
      Bluetooth: Add key preference parameter to smp_sufficient_security
      Bluetooth: Trigger SMP for the appropriate LE CoC errors

 net/bluetooth/l2cap_core.c | 29 ++++++++++++++++++++++++++---
 net/bluetooth/smp.c        | 20 +++++++++++---------
 net/bluetooth/smp.h        |  9 ++++++++-
 3 files changed, 45 insertions(+), 13 deletions(-)

