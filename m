Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: LE CoC fixes
Date: Mon, 10 Nov 2014 13:24:52 +0200
Message-Id: <1415618695-21363-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set contains various fixes for LE CoC. The biggest functional
change is in the last patch proper reaction to the insufficient
authentication/encryption connection responses is implemented.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix sending incorrect LE CoC PDU in BT_CONNECT2 state
      Bluetooth: Add key preference parameter to smp_sufficient_security
      Bluetooth: Trigger SMP for the appropriate LE CoC errors

 net/bluetooth/l2cap_core.c | 39 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/smp.c        |  9 +++++----
 net/bluetooth/smp.h        |  8 +++++++-
 3 files changed, 48 insertions(+), 8 deletions(-)

