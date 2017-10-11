Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Reichel <sre@kernel.org>,
	Tobias Regnery <tobias.regnery@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
Date: Wed, 11 Oct 2017 15:47:54 +0200
Message-Id: <20171011134805.3207569-1-arnd@arndb.de>
In-Reply-To: <20171011134640.3152236-1-arnd@arndb.de>
References: <20171011134640.3152236-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

It is no longer possible to build BT_HCIUART into the kernel
when SERIAL_DEV_BUS is a loadable module, even if none of the
SERIAL_DEV_BUS based implementations are selected:

drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'

This adds a dependency to avoid the broken configuration.

Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fae5a74dc737..4427d54b7331 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -65,6 +65,7 @@ config BT_HCIBTSDIO
 
 config BT_HCIUART
 	tristate "HCI UART driver"
+	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
@@ -79,7 +80,6 @@ config BT_HCIUART
 config BT_HCIUART_SERDEV
 	bool
 	depends on SERIAL_DEV_BUS && BT_HCIUART
-	depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
 	default y
 
 config BT_HCIUART_H4
-- 
2.9.0
