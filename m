Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 00/15] Discovery procedure support
Date: Wed,  5 Oct 2011 20:20:32 -0300
Message-Id: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

The main changes in this new version are basically Marcel's
comments about v4 version.

BR,

Andre

Andre Guedes (15):
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
  Bluetooth: Add LE Set Scan Parameter Command
  Bluetooth: LE scan infra-structure
  Bluetooth: Support LE-Only discovery procedure
  Bluetooth: Support BR/EDR/LE discovery procedure

 include/net/bluetooth/hci.h      |   12 +++
 include/net/bluetooth/hci_core.h |   15 ++++-
 net/bluetooth/hci_core.c         |   96 ++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   99 ++++++++++++++++-----------
 net/bluetooth/mgmt.c             |  138 +++++++++++++++++++++++++++++++++++---
 5 files changed, 310 insertions(+), 50 deletions(-)

-- 
1.7.5.2

