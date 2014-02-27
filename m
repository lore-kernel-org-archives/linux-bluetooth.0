Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Fix initiator/responder addresses for SMP
Date: Thu, 27 Feb 2014 14:05:39 +0200
Message-Id: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm presenting this patch set as an alternative to the two patches from
Marcel. The main difference is that we trade some more complexity during
the connection creation phase with less complexity in looking up the
values in SMP when the time comes for calling the smp_c1 function.

One source of extra complexity is the attempt to handle the case of
whitelist initiated connections. Since we do not use those I'm not
completely sure it's worth to have code for it. If the handling is not
needed patch 3/4 gets a bit simpler and patch 2/4 can potentially be
dropped (I added that new function mainly to make 3/4 actually readable
with this extra whitelist handling logic).

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Add tracking of advertising address type
      Bluetooth: Add hci_copy_identity_address convenience function
      Bluetooth: Track LE initiator and responder address information
      Bluetooth: Use hdev->init/resp_addr values for smp_c1 function

 include/net/bluetooth/hci_core.h |   7 +++
 net/bluetooth/hci_core.c         |  35 ++++++++---
 net/bluetooth/hci_event.c        | 114 ++++++++++++++++++++++++++++++-----
 net/bluetooth/smp.c              |  22 ++-----
 4 files changed, 136 insertions(+), 42 deletions(-)


