Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 00/16] Full support discovery procedure
Date: Fri,  9 Sep 2011 18:56:15 -0300
Message-Id: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

This is the new version of discovery patch series. The main changes
from previous version are:
    - Simpler approach to remove pending discovery commands and
      to send command complete/status events when the discovery
      finishes.
    - enum bt_device_type and get_device_type helper function were
      removed (Marcel's comment).

BR,

Andre Guedes.

Andre Guedes (16):
  Bluetooth: Periodic Inquiry and mgmt discovering event
  Bluetooth: Add mgmt_discovery_complete()
  Bluetooth: Check pending command in start_discovery()
  Bluetooth: Check pending commands in stop_discovery()
  Bluetooth: Create hci_do_inquiry()
  Bluetooth: Create hci_cancel_inquiry()
  Bluetooth: Handle race condition in Discovery
  Bluetooth: Prepare for full support discovery procedures
  Bluetooth: Reduce critical region.
  Bluetooth: Send mgmt_discovering events
  Bluetooth: Check 'dev_class' in mgmt_device_found()
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: LE scan infra-structure
  Bluetooth: Support LE-Only discovery procedure
  Bluetooth: Support BR/EDR/LE discovery procedure

 include/net/bluetooth/hci.h      |   12 +++
 include/net/bluetooth/hci_core.h |   15 ++++-
 net/bluetooth/hci_core.c         |   96 ++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  112 ++++++++++++++++++------------
 net/bluetooth/mgmt.c             |  139 +++++++++++++++++++++++++++++++++++---
 5 files changed, 318 insertions(+), 56 deletions(-)

-- 
1.7.5.2

