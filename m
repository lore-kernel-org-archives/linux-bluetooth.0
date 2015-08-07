Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/4] Bluetooth: hci_bcm: Add ACPI and PM support
Date: Fri,  7 Aug 2015 17:00:36 +0200
Message-Id: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches move PM support from rfkill-gpio to hci_uart module.
On, off, suspend and resume functions are supported.
They also parse the ACPI entry to find initial UART baud rate.

v1->v2:
- Add BCM2E67 device in acpi_device_id table
- Add suspend/resume functions

Frederic Danis (4):
  Bluetooth: hci_bcm: Add PM for BCM devices
  net: rfkill: gpio: Make BCM2E39 support optional
  Bluetooth: hci_bcm: Retrieve UART speed from ACPI
  Bluetooth: hci_bcm: Add suspend/resume PM functions

 drivers/bluetooth/hci_bcm.c | 279 +++++++++++++++++++++++++++++++++++++++++++-
 net/rfkill/rfkill-gpio.c    |   2 +
 2 files changed, 279 insertions(+), 2 deletions(-)

-- 
1.9.1

