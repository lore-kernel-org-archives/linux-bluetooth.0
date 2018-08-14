Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Bluetooth: Make BT_HCIUART_RTL configuration option depend on ACPI
Date: Tue, 14 Aug 2018 11:57:07 +0200
Message-Id: <20180814095707.5674-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

At the moment we only support ACPI enumeration for serial port attached
RTL bluetooth controllers.

This commit adds a dependency on ACPI to the BT_HCIUART_RTL configuration
option, fixing the following warning when ACPI is not enabled:

drivers/bluetooth/hci_h5.c:920:22: warning: 'rtl_vnd' defined but not used

Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 933eb90d1ce2..709ed3f7dfe8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -200,6 +200,7 @@ config BT_HCIUART_RTL
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
 	depends on GPIOLIB
+	depends on ACPI
 	select BT_HCIUART_3WIRE
 	select BT_RTL
 	help
-- 
2.18.0
