Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] Error handling in HCI request framework
Date: Thu,  7 Mar 2013 18:48:06 -0300
Message-Id: <1362692892-28716-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v2 is based on Johan's suggestions about the previous patch set.
The main comments were:
- Replace EINVAL by ENODATA in a separated patch.
- Save the exact error code in struct hci_request instead of having just a
  flag to indicate an error has occurred.
- Check req->err before before empty queue check.

I also added a new patch (Patch 1) to fix a problem found in __hci_req_sync
while I was working on this patch set.

Regards,

Andre

Andre Guedes (6):
  Bluetooth: Fix __hci_req_sync
  Bluetooth: Return ENODATA in hci_req_run
  Bluetooth: Check hci_req_run returning value in __hci_req_sync
  Bluetooth: HCI request error handling
  Bluetooth: Make hci_req_add returning void
  Bluetooth: Check req->err in hci_req_add

 include/net/bluetooth/hci_core.h |  7 +++++-
 net/bluetooth/hci_core.c         | 46 +++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 16 deletions(-)

-- 
1.8.1.2

