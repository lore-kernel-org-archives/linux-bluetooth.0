Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 0/4] Bluetooth: hci_bcm: Add ACPI and PM support
Date: Tue, 11 Aug 2015 16:35:34 +0200
Message-Id: <1439303738-24231-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches move PM support from rfkill-gpio to hci_uart module.
On, off, suspend and resume functions are supported.
They also parse the ACPI entry to find initial UART baud rate.

v4->v5:
- Rename parameter and variable of bcm_suspend and bcm_resume

v3->v4:
- Fix commit message of rfkill-gpio patch

v2->v3:
- Add bcm_device existance check as driver can be unbound and reference in
  bcm_data may be invalid
- Add explanation of retrieval of bcm_device corresponding to tty in use
- Rename variables : ptr -> p, device_list -> bcm_device_list,
                     device_list_lock -> bcm_device_list_lock
- Remove BCM2E39 in rfkill-gpio.c instead of making it conditional

v1->v2:
- Add BCM2E67 device in acpi_device_id table
- Add suspend/resume functions

Frederic Danis (4):
  Bluetooth: hci_bcm: Add PM for BCM devices
  net: rfkill: gpio: Remove BCM2E39 support
  Bluetooth: hci_bcm: Retrieve UART speed from ACPI
  Bluetooth: hci_bcm: Add suspend/resume PM functions

 drivers/bluetooth/hci_bcm.c | 303 +++++++++++++++++++++++++++++++++++++++++++-
 net/rfkill/rfkill-gpio.c    |   1 -
 2 files changed, 301 insertions(+), 3 deletions(-)

-- 
1.9.1

