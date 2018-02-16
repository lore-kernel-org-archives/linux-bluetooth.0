Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Tobias Regnery <tobias.regnery@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [4.14 only backport] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
Date: Fri, 16 Feb 2018 17:05:35 +0100
Message-Id: <20180216160556.1634805-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

commit 05e89fb576f580ac95e7a5d00bdb34830b09671a upstream.

It is no longer possible to build BT_HCIUART into the kernel
when SERIAL_DEV_BUS is a loadable module, even if none of the
SERIAL_DEV_BUS based implementations are selected:

drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'

This adds a dependency to avoid the broken configuration.

Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 98a60db8e5d1..b33c8d6eb8c7 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -66,6 +66,7 @@ config BT_HCIBTSDIO
 
 config BT_HCIUART
 	tristate "HCI UART driver"
+	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
@@ -80,7 +81,6 @@ config BT_HCIUART
 config BT_HCIUART_SERDEV
 	bool
 	depends on SERIAL_DEV_BUS && BT_HCIUART
-	depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
 	default y
 
 config BT_HCIUART_H4
-- 
2.9.0
