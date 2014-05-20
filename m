Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: SMP cleanups
Date: Tue, 20 May 2014 09:45:46 +0300
Message-Id: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of cleanups for the SMP code.

Johan

----------------------------------------------------------------
Johan Hedberg (6):
      Bluetooth: Make SMP context private to smp.c
      Bluetooth: Fix setting initial local auth_req value
      Bluetooth: Remove unnecessary work structs from SMP code
      Bluetooth: Rename smp->smp_flags to smp->flags
      Bluetooth: Update smp_random to return a response code
      Bluetooth: Update smp_confirm to return a response code

 net/bluetooth/hci_conn.c |   1 +
 net/bluetooth/hci_core.c |   1 +
 net/bluetooth/mgmt.c     |   1 +
 net/bluetooth/smp.c      | 133 ++++++++++++++++++++-------------------
 net/bluetooth/smp.h      |  29 ---------
 5 files changed, 70 insertions(+), 95 deletions(-)

