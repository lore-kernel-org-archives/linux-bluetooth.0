Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 00/16] Full support discovery procedure
Date: Fri, 10 Jun 2011 16:35:57 -0300
Message-Id: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

This patch series implements the full support to discovery procedure through
management interface. Today, only BR/EDR devices are supported. This work is
part of the effort to have discovery procedures and name resolution supported
in management interface.

Before beginning LE-Only and BR/EDR/LE support, it was needed to fix some
issues in BR/EDR discovery. These issues are discussed in patches 1 to 6.

Thanks,

Andre Guedes.

Andre Guedes (16):
  Bluetooth: Periodic Inquiry and mgmt discovering event
  Bluetooth: Add failed/complete functions to discovery commands
  Bluetooth: Remove pending discovery commands
  Bluetooth: Check pending command in start_discovery()
  Bluetooth: Check pending commands in stop_discovery()
  Bluetooth: Fix stop_discovery()
  Bluetooth: Create do_inquiry()
  Bluetooth: Create cancel_inquiry()
  Bluetooth: Prepare for full support discovery procedures
  Bluetooth: Check 'dev_class' in mgmt_device_found()
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: Add 'le_scan_timer' to struct hci_dev
  Bluetooth: Add LE Scan helper functions
  Bluetooth: Support LE-Only discovery procedure
  Bluetooth: Support BR/EDR/LE discovery procedure

 include/net/bluetooth/hci.h      |   12 ++
 include/net/bluetooth/hci_core.h |   12 ++-
 net/bluetooth/hci_core.c         |   19 +++
 net/bluetooth/hci_event.c        |  145 +++++++++++++++------
 net/bluetooth/mgmt.c             |  262 ++++++++++++++++++++++++++++++++++++--
 5 files changed, 398 insertions(+), 52 deletions(-)

-- 
1.7.4.1

