Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/15] Bluetooth: LE Privacy support
Date: Sat, 22 Feb 2014 19:06:30 +0200
Message-Id: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches implements support for the Set Privacy mgmt command,
i.e. the ability to have a local IRK and use it to generate a local RPA.

I'm not expecting most of the patches to have too many points of
discussion, except for the last one: we might want to consider adding
some restrictions to when Set Privacy can be called in order to make the
command implementation simpler. We could e.g. reject the command
whenever advertising is enabled or possibly even when the adapter is
powered on.

Johan

----------------------------------------------------------------
Johan Hedberg (15):
      Bluetooth: Add helper variables to smp_distribute_keys()
      Bluetooth: Add initial code for distributing local IRK
      Bluetooth: Move enable/disable_advertising higher up in mgmt.c
      Bluetooth: Add mgmt defines for privacy
      Bluetooth: Add Privacy lag to mgmt supported/current settings
      Bluetooth: Add skeleton for Set Privacy command
      Bluetooth: Add SMP function for generating RPAs
      Bluetooth: Don't write static address when privacy is enabled
      Bluetooth: Fix hdev->own_addr_type value when privacy is set
      Bluetooth: Add mechanism for updating the local RPA
      Bluetooth: Update local RPA if necessary when connecting LE
      Bluetooth: Update local RPA if necessary before enabling advertising
      Bluetooth: Update local RPA if necessary before starting LE scan
      Bluetooth: Add debugfs entry for RPA regeneration timeout
      Bluetooth: Add full support for updating privacy state

 include/net/bluetooth/hci.h      |   2 +
 include/net/bluetooth/hci_core.h |   9 ++
 include/net/bluetooth/mgmt.h     |   8 ++
 net/bluetooth/hci_conn.c         |   3 +
 net/bluetooth/hci_core.c         |  60 ++++++++++-
 net/bluetooth/mgmt.c             | 198 +++++++++++++++++++++++++++--------
 net/bluetooth/smp.c              |  40 +++++--
 net/bluetooth/smp.h              |   1 +
 8 files changed, 262 insertions(+), 59 deletions(-)

