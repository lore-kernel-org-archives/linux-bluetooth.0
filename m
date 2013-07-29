Return-Path: <cyrus@holtmann.org>
From: Hector Palacios <hector.palacios@digi.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<linux-kernel@vger.kernel.org>, <vikram.kandukuri@atheros.com>,
	<suraj@atheros.com>, <hector.palacios@digi.com>
Subject: [PATCH] bluetooth: remove wrong dependency for BT_ATH3K
Date: Mon, 29 Jul 2013 18:12:05 +0200
Message-ID: <1375114325-25498-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The Atheros firmware download driver is not dependent on HCI
USB driver. This driver is needed to complement any Atheros
driver like BT_HCIUART_ATH3K.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
CC: Suraj Sumangala <suraj@atheros.com>
CC: Vikram Kandukuri <vikram.kandukuri@atheros.com>
---
 drivers/bluetooth/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 11a6104..a1d482b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -222,7 +222,6 @@ config BT_MRVL_SDIO
 
 config BT_ATH3K
 	tristate "Atheros firmware download driver"
-	depends on BT_HCIBTUSB
 	select FW_LOADER
 	help
 	  Bluetooth firmware download driver.
