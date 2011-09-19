Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 00/14] Discovery support
Date: Mon, 19 Sep 2011 18:35:22 -0300
Message-Id: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

I rebased the discovery series as you asked.

Andre. 

Andre Guedes (14):
  Bluetooth: Periodic Inquiry and mgmt discovering event
  Bluetooth: Add mgmt_discovery_complete()
  Bluetooth: Check pending command in start_discovery()
  Bluetooth: Check pending commands in stop_discovery()
  Bluetooth: Create hci_do_inquiry()
  Bluetooth: Create hci_cancel_inquiry()
  Bluetooth: Handle race condition in Discovery
  Bluetooth: Prepare for full support discovery procedures
  Bluetooth: Send mgmt_discovering events
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: LE scan infra-structure
  Bluetooth: Support LE-Only discovery procedure
  Bluetooth: Support BR/EDR/LE discovery procedure

 include/net/bluetooth/hci.h      |   12 ++++
 include/net/bluetooth/hci_core.h |   15 ++++-
 net/bluetooth/hci_core.c         |   96 +++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  104 ++++++++++++++++++-----------
 net/bluetooth/mgmt.c             |  135 +++++++++++++++++++++++++++++++++++---
 5 files changed, 312 insertions(+), 50 deletions(-)

-- 
1.7.5.2

