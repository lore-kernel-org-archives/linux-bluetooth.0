Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 0/2] Disconnect reason in Kernel API
Date: Wed,  8 Aug 2012 09:42:31 +0200
Message-Id: <1344411753-10124-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patchset (split now in two patches) extends the management API to expose the disconnect reason in the device disconnection event.

The original motivation was to distinguish the timeout case from the rest, thus the first versions of the patch provided only this information.

v3 extends the original approach to also determine which side (local host or remote) initiated the ACL disconnection. This is IMO not very useful and misleading, but has still been considered interesting by the subsystem maintainers.

In order to test these patches, the old userland patch ("[RFC BlueZ v1]: mgmt-api: Add reason to device disconnect event") can be used, in terms of log traces, even though it needs the corresponding update.

>From original patch:

During the BlueZ meeting in Brazil it was proposed to add two more values to this enum: "Connection terminated by local host" and "Connection terminated by remote host". However, after some testing, it seems the result can be quite misleading. Therefore and given that there are no known use-cases that need this information (local vs remote disconnection), these two values have been dropped.

Mikel Astiz (2):
  Bluetooth: Add more HCI error codes
  Bluetooth: mgmt: Add device disconnect reason

 include/net/bluetooth/hci.h      |    3 +++
 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/mgmt.h     |    8 ++++++++
 net/bluetooth/hci_event.c        |   24 +++++++++++++++++++++---
 net/bluetooth/mgmt.c             |    9 +++++----
 5 files changed, 38 insertions(+), 8 deletions(-)

-- 
1.7.7.6

