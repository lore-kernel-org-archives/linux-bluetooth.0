Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] Bluetooth: Add Kconfig option to enable Realtek protocol for serial devices
Date: Wed,  8 Aug 2018 16:52:05 +0200
Message-Id: <20180808145205.26230-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new BT_HCIUART_RTL Kconfig option to enable the Realtek protocol for
Bluetooth HCI over serial port interface, mirroring the existing
BT_HCIUART_BCM Kconfig option.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 5f953ca8ac5b..1124034d1c7e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -195,6 +195,20 @@ config BT_HCIUART_BCM
 
 	  Say Y here to compile support for Broadcom protocol.
 
+config BT_HCIUART_RTL
+	bool "Realtek protocol support"
+	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
+	depends on GPIOLIB
+	select BT_HCIUART_3WIRE
+	select BT_RTL
+	help
+	  The Realtek protocol support enables Bluetooth HCI over serial
+	  port interface for Realtek Bluetooth controllers.
+
+	  Say Y here to compile support for the Realtek protocol.
+
 config BT_HCIUART_QCA
 	bool "Qualcomm Atheros protocol support"
 	depends on BT_HCIUART
-- 
2.17.1
