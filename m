Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 0/5] Add baudrate management for Bluetooth UART
Date: Wed, 20 May 2015 17:46:05 +0200
Message-Id: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduce baudrate management for Bluetooth UART
Controller setup and a first implementation for Broadcom BCM4324B3
used in Asus T100.

v2 -> v6:
- Fixes for __hci_cmd_sync() has been integrated (patch v5)
- In btbcm_check_bdaddr(), merge controller address tests
- Fix declaration of speeds to use "unsigned int" type
- Rename default_speed to init_speed
- Rename operational_speed to oper_speed
- In case of error during vendor specific set_baudrate(), do not change
  host baudrate and continue without changing speed
- Discard changes to bcm_setup_patchram() and in btusb.c
- Introduce helper functions btbcm_initialize() and btbcm_finalize() to
  be used by the UART side of things.

Frederic Danis (5):
  Bluetooth: btbcm: Add BCM4324B3 UART device
  Bluetooth: hci_uart: Support operational speed during setup
  Bluetooth: btbcm: Add helper functions for UART setup
  Bluetooth: hci_uart: Update Broadcom UART setup
  Bluetooth: hci_uart: Add bcm_set_baudrate()

 drivers/bluetooth/btbcm.c     | 109 ++++++++++++++++++++++++++++++++++++------
 drivers/bluetooth/btbcm.h     |  14 ++++++
 drivers/bluetooth/hci_bcm.c   |  75 ++++++++++++++++++++++++++++-
 drivers/bluetooth/hci_ldisc.c |  26 ++++++++++
 drivers/bluetooth/hci_uart.h  |   4 ++
 5 files changed, 213 insertions(+), 15 deletions(-)

-- 
1.9.1

