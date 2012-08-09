Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 0/3] Disconnect reason in Kernel API
Date: Thu,  9 Aug 2012 09:52:27 +0200
Message-Id: <1344498750-2698-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patchset extends the management API to expose the low-level disconnect reason.

v4 integrates the feedback from Marcel, mainly:
- Fix minor coding style issue (patch v4 2/3)
- Remove references to "ACL" in mgmt terminology
- Add MGMT_DEV_DISCONN_UNKNOWN
- Add helper function to translate from HCI error codes to mgmt reason

Updated userland patch to be used for testing purposes will be submitted soon.

>From original patch:

During the BlueZ meeting in Brazil it was proposed to add two more values to this enum: "Connection terminated by local host" and "Connection terminated by remote host". However, after some testing, it seems the result can be quite misleading. Therefore and given that there are no known use-cases that need this information (local vs remote disconnection), these two values have been dropped.

Mikel Astiz (3):
  Bluetooth: Add more HCI error codes
  Bluetooth: Fix minor coding style in hci_event.c
  Bluetooth: mgmt: Add device disconnect reason

 include/net/bluetooth/hci.h      |    3 +++
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    9 +++++++++
 net/bluetooth/hci_event.c        |   32 ++++++++++++++++++++++++++------
 net/bluetooth/mgmt.c             |    9 +++++----
 5 files changed, 44 insertions(+), 11 deletions(-)

-- 
1.7.7.6

