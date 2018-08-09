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
Subject: [PATCH v2] Bluetooth: Introduce BT_HCIUART_RTL configuration option
Date: Thu,  9 Aug 2018 10:33:07 +0200
Message-Id: <20180809083307.29127-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

Like all the other UART protocols, introduce a configuration option for
Realtek based serial devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2 (Hans de Goede)
-Keep the depends on BT_HCIUART_SERDEV for BT_HCIUART_3WIRE even if we #ifdef
 the btrtl bits we still need it for hci_uart_[un]register_device()
-Add #ifdef CONFIG_BT_HCIUART_RTL checks to hci_h5.c so that it does not
 reference the rtlbt.c code when BT_HCIUART_RTL is not set, this fixes linker
 errors when BT_HCIUART_RTL is not set, BT_HCIUART_3WIRE=y (builtin) and
 BT_HCIBTUSB_RTL=m, which selects BT_RTL=m, which would end up having the
 btrtl symbols in a module with builtin code referencing it
---
 drivers/bluetooth/Kconfig  | 13 +++++++++++++
 drivers/bluetooth/hci_h5.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 5f953ca8ac5b..933eb90d1ce2 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -195,6 +195,19 @@ config BT_HCIUART_BCM
 
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
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 63c0dcbc4914..8eede1197cd2 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -841,6 +841,7 @@ static void h5_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&h5->serdev_hu);
 }
 
+#ifdef CONFIG_BT_HCIUART_RTL
 static int h5_btrtl_setup(struct h5 *h5)
 {
 	struct btrtl_device_info *btrtl_dev;
@@ -922,10 +923,13 @@ static struct h5_vnd rtl_vnd = {
 	.close		= h5_btrtl_close,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
+#ifdef CONFIG_BT_HCIUART_RTL
 	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
-- 
2.18.0
