Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: hci_conn related fixes
Date: Thu, 11 Dec 2014 21:45:43 +0200
Message-Id: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches contains fixes for various issues introduced by the
generic cmd_complete callback mechanism for pending mgmt commands.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix calling hci_conn_put too early
      Bluetooth: Fix incorrect pending cmd removal in pairing_complete()
      Bluetooth: Fix notifying mgmt power off before flushing connection list

 net/bluetooth/hci_core.c | 14 ++++++--------
 net/bluetooth/mgmt.c     | 42 +++++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 23 deletions(-)


