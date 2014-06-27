Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: Various SMP cleanups & fixes
Date: Fri, 27 Jun 2014 14:23:01 +0300
Message-Id: <1403868187-19396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of cleanups and fixes for SMP. I'd consider all of them as
bluetooth-next material, but it could be debated whether the first patch
should go to bluetooth.git first (I don't have any obvious way of
exploiting it so I don't consider it very critical).

Johan

----------------------------------------------------------------
Johan Hedberg (6):
      Bluetooth: Fix missing hdev locking in smp_cmd_ident_addr_info
      Bluetooth: Add dedicated AES instance for each SMP context
      Bluetooth: Update SMP crypto functions to take the SMP context
      Bluetooth: Remove unnecessary hci_dev_unlock for smp_user_confirm_reply
      Bluetooth: Fix missing check for SMP session in smp_user_confirm_reply
      Bluetooth: Remove unnecessary hcon->smp_conn variable

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/mgmt.c             |  7 ----
 net/bluetooth/smp.c              | 73 ++++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 43 deletions(-)

