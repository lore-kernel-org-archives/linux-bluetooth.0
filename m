Return-Path: <lukas@wunner.de>
Message-Id: <4d4ac18f570efc6371bc44c70836bdd3ddee3902.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 01/10] Bluetooth: Depend on rather than select GPIOLIB
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 27378f4c1b92 ("Bluetooth: Avoid WARN splat due to missing
GPIOLIB") amended Kconfig to select GPIOLIB if BT_HCIUART_NOKIA,
BT_HCIUART_INTEL or BT_HCIUART_BCM is enabled since all three drivers
require it to function.

The diagnosis was correct but the treatment was not.  As stated in
Documentation/gpio/consumer.txt:

    Guidelines for GPIOs consumers
    ==============================

    Drivers that can't work without standard GPIO calls should have
    Kconfig entries that depend on GPIOLIB.
                         ^^^^^^^^^
Fix it.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index d816ce9e23a7..07e55cd8f8c8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -108,10 +108,10 @@ config BT_HCIUART_NOKIA
 	tristate "UART Nokia H4+ protocol support"
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
+	depends on GPIOLIB
 	depends on PM
 	select BT_HCIUART_H4
 	select BT_BCM
-	select GPIOLIB
 	help
 	  Nokia H4+ is serial protocol for communication between Bluetooth
 	  device and host. This protocol is required for Bluetooth devices
@@ -170,9 +170,9 @@ config BT_HCIUART_3WIRE
 config BT_HCIUART_INTEL
 	bool "Intel protocol support"
 	depends on BT_HCIUART
+	depends on GPIOLIB
 	select BT_HCIUART_H4
 	select BT_INTEL
-	select GPIOLIB
 	help
 	  The Intel protocol support enables Bluetooth HCI over serial
 	  port interface for Intel Bluetooth controllers.
@@ -184,9 +184,9 @@ config BT_HCIUART_BCM
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
 	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
+	depends on GPIOLIB
 	select BT_HCIUART_H4
 	select BT_BCM
-	select GPIOLIB
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
 	  port interface for Broadcom Bluetooth controllers.
-- 
2.15.1
