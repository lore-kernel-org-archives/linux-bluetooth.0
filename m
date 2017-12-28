Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "loic . poulain @ gmail . com" <loic.poulain@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] Bluetooth: Replace dependency on SERIAL_DEV_BUS by selection
Date: Thu, 28 Dec 2017 21:55:03 +0200
Message-Id: <20171228195503.4283-1-andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The change restores build behaviour for old configurations when user
didn't know and thus didn't select SERIAL_DEV_BUS explicitly for given
HCI modules, such as hci_bcm.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: get rid of recursive dependencies
 drivers/bluetooth/Kconfig | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 60e1c7d6986d..ea3d114d19e5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -66,7 +66,6 @@ config BT_HCIBTSDIO
 
 config BT_HCIUART
 	tristate "HCI UART driver"
-	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
@@ -78,11 +77,6 @@ config BT_HCIUART
 	  Say Y here to compile support for Bluetooth UART devices into the
 	  kernel or say M to compile it as module (hci_uart).
 
-config BT_HCIUART_SERDEV
-	bool
-	depends on SERIAL_DEV_BUS && BT_HCIUART
-	default y
-
 config BT_HCIUART_H4
 	bool "UART (H4) protocol support"
 	depends on BT_HCIUART
@@ -96,8 +90,8 @@ config BT_HCIUART_H4
 config BT_HCIUART_NOKIA
 	tristate "UART Nokia H4+ protocol support"
 	depends on BT_HCIUART
-	depends on BT_HCIUART_SERDEV
 	depends on PM
+	select SERIAL_DEV_BUS
 	select BT_HCIUART_H4
 	select BT_BCM
 	help
@@ -134,7 +128,8 @@ config BT_HCIUART_ATH3K
 
 config BT_HCIUART_LL
 	bool "HCILL protocol support"
-	depends on BT_HCIUART_SERDEV
+	depends on BT_HCIUART
+	select SERIAL_DEV_BUS
 	help
 	  HCILL (HCI Low Level) is a serial protocol for communication
 	  between Bluetooth device and host. This protocol is required for
@@ -169,8 +164,8 @@ config BT_HCIUART_INTEL
 config BT_HCIUART_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIUART
-	depends on BT_HCIUART_SERDEV
-	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
+	select SERIAL_DEV_CTRL_TTYPORT if !ACPI
+	select SERIAL_DEV_BUS
 	select BT_HCIUART_H4
 	select BT_BCM
 	help
-- 
2.15.1

