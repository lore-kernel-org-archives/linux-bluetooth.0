Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV
Date: Sat,  4 Aug 2018 23:40:26 +0300
Message-Id: <20180804204026.9746-1-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This driver was recently updated to use serdev, so add the appropriate
dependency. Without this one can get compiler warnings like this if
CONFIG_SERIAL_DEV_BUS is not enabled:

  CC [M]  drivers/bluetooth/hci_h5.o
drivers/bluetooth/hci_h5.c:934:36: warning: ‘h5_serdev_driver’ defined but not used [-Wunused-variable]
 static struct serdev_device_driver h5_serdev_driver = {
                                    ^~~~~~~~~~~~~~~~

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index f3c643a0473c..5f953ca8ac5b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -159,6 +159,7 @@ config BT_HCIUART_LL
 config BT_HCIUART_3WIRE
 	bool "Three-wire UART (H5) protocol support"
 	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
 	help
 	  The HCI Three-wire UART Transport Layer makes it possible to
 	  user the Bluetooth HCI over a serial port interface. The HCI
-- 
2.17.1

