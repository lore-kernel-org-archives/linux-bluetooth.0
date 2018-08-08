Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce BT_HCIUART_RTL configuration option
Date: Wed,  8 Aug 2018 16:27:12 +0200
Message-Id: <20180808142712.88122-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Like all the other UART protocols, introduce a configuration option for
Realtek based serial devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c3736103c2ac..3a050e02bcb3 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -159,7 +159,6 @@ config BT_HCIUART_LL
 config BT_HCIUART_3WIRE
 	bool "Three-wire UART (H5) protocol support"
 	depends on BT_HCIUART
-	depends on BT_HCIUART_SERDEV
 	help
 	  The HCI Three-wire UART Transport Layer makes it possible to
 	  user the Bluetooth HCI over a serial port interface. The HCI
@@ -195,6 +194,19 @@ config BT_HCIUART_BCM
 
 	  Say Y here to compile support for Broadcom protocol.
 
+config BT_HCIUART_RTL
+	bool "Realtek protocol support"
+	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	depends on GPIOLIB
+	select BT_HCIUART_3WIRE
+	select BT_RTL
+	help
+	  The Realtek protocol support enables Bluetooth HCI over 3-Wire
+	  serial port internface for Realtek Bluetooth controllers.
+
+	  Say Y here to compile support for Realtek protocol.
+
 config BT_HCIUART_QCA
 	bool "Qualcomm Atheros protocol support"
 	depends on BT_HCIUART
-- 
2.17.1

