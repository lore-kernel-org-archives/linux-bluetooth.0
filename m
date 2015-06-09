Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8] Add baudrate management for Bluetooth UART
Date: Tue,  9 Jun 2015 11:04:52 +0200
Message-Id: <1433840693-5991-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduce baudrate management for Bluetooth UART
Controller setup and a first implementation for Broadcom BCM4324B3
used in Asus T100.

v7 -> v8:
- Patches 1 to 5 has been integrated
- Rename "struct hci_cp_bcm_set_speed" to "struct bcm_set_speed" and
  move it to btbcm.h
- Rename parameter "dummy" to "zero" in "struct bcm_set_speed"
- Add comments above vendor commands
- Add "BCM: " in BT_ERR strings
- Assign value of "param" variable above related vendor command

v6 -> v7:
- Fix setup when firmware is missing by moving
  request/release_firmware() out of btbcm_patchram().

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
Frederic Danis (1):
  Bluetooth: hci_uart: Add bcm_set_baudrate()

 drivers/bluetooth/btbcm.h   |  5 ++++
 drivers/bluetooth/hci_bcm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
1.9.1

