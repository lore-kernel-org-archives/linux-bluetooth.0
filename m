Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 00/16] Full support discovery procedure
Date: Mon, 11 Jul 2011 18:11:43 -0300
Message-Id: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

The main changes from previous RFC series are:
    - 'status' parameter added to *_discovery_failed() functions. This
       way, we provide a more meaningful value to command status events.
    - Some code refactoring in stop_discovery() race condition prevention.
    - Minor code refactoring in BR/EDR/LE discovery support.

Thanks,

Andre Guedes.

Andre Guedes (16):
  Bluetooth: Periodic Inquiry and mgmt discovering event
  Bluetooth: Add failed/complete functions to discovery commands
  Bluetooth: Remove pending discovery commands
  Bluetooth: Check pending command in start_discovery()
  Bluetooth: Check pending commands in stop_discovery()
  Bluetooth: Create do_inquiry()
  Bluetooth: Create cancel_inquiry()
  Bluetooth: Fix stop_discovery()
  Bluetooth: Prepare for full support discovery procedures
  Bluetooth: Check 'dev_class' in mgmt_device_found()
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: Add 'le_scan_timer' to struct hci_dev
  Bluetooth: Add LE Scan helper functions
  Bluetooth: Support LE-Only discovery procedure
  Bluetooth: Support BR/EDR/LE discovery procedure

 include/net/bluetooth/hci.h      |   12 ++
 include/net/bluetooth/hci_core.h |   13 ++-
 net/bluetooth/hci_core.c         |   13 ++
 net/bluetooth/hci_event.c        |  134 +++++++++++++------
 net/bluetooth/mgmt.c             |  282 ++++++++++++++++++++++++++++++++++++--
 5 files changed, 402 insertions(+), 52 deletions(-)

-- 
1.7.4.1

