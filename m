Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Use HCI request framework to enable LE scanning
Date: Wed,  6 Mar 2013 16:10:52 -0300
Message-Id: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

The main goal of this patch set is to update hci_le_scan helper to use the new
HCI Request framework. Additionally, it also moves the LE scanning timeout
handling from LE scanning helpers to discovery code, as Marcel requested
during some discussion about LE connection improvements.

Below follows additional information about some patches of this patch set:

Patch 1 adds the hci_req_cleanup function so we are able to free HCI command
already queued on a given HCI request. This function must be used in case
something goes wrong during the HCI request creation. Otherwise, we will
face some memory leak issues. hci_req_cleanup is used in this patch set in
case something goes wrong with LE scanning HCI request creation.

Patches 6 and 7 do a very trivial changes in order to organize discovery
macros.

Regards,

Andre Guedes


Andre Guedes (7):
  Bluetooth: Add hci_req_cleanup function
  Bluetooth: Update hci_le_scan to use HCI request
  Bluetooth: Merge LE-only and interleaved cases
  Bluetooth: Remove timeout handling from hci_cancel_le_scan
  Bluetooth: Remove LE scan work
  Bluetooth: Change LE scanning timeout macros
  Bluetooth: Add LE scan type macros

 include/net/bluetooth/hci_core.h |  18 ++----
 net/bluetooth/hci_core.c         | 124 ++++++++++++---------------------------
 net/bluetooth/mgmt.c             |  65 +++++++++++++++-----
 3 files changed, 94 insertions(+), 113 deletions(-)

-- 
1.8.1.2

