Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] Use HCI request framework to enable LE scanning
Date: Fri,  8 Mar 2013 20:06:13 -0300
Message-Id: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v2 implements Marcel's comments about the previous patch set.

The changes are:
- set_le_scan_param and set_le_scan_enable helpers were removed and their
  code put into hci_le_scan function.
- Decimal values were replaced by hexadecimal in HCI parameters.

I also removed Patch "Bluetooth: Add hci_req_cleanup function" from this
patch set since all request errors are now handled by the HCI request
framework.

Regards,

Andre

Andre Guedes (6):
  Bluetooth: Update hci_le_scan to use HCI request
  Bluetooth: Merge LE-only and interleaved cases
  Bluetooth: Remove timeout handling from hci_cancel_le_scan
  Bluetooth: Remove LE scan work
  Bluetooth: Change LE scanning timeout macros
  Bluetooth: Add LE scan type macros

 include/net/bluetooth/hci_core.h |  17 ++----
 net/bluetooth/hci_core.c         | 113 ++++++++-------------------------------
 net/bluetooth/mgmt.c             |  62 ++++++++++++++++-----
 3 files changed, 76 insertions(+), 116 deletions(-)

-- 
1.8.1.2

