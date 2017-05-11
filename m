Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Gross <andy.gross@linaro.org>,
	Loic Poulain <loic.poulain@intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_ll: add proper SERDEV dependency
Date: Thu, 11 May 2017 13:41:54 +0200
Message-Id: <20170511114223.2744939-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

When SERDEV is a loadable module, and the HCI code is built-in, we
get a link error:

drivers/bluetooth/built-in.o: In function `ll_close':
hci_ll.c:(.text+0x278d): undefined reference to `serdev_device_close'
drivers/bluetooth/built-in.o: In function `hci_ti_probe':
hci_ll.c:(.text+0x283c): undefined reference to `hci_uart_register_device'
drivers/bluetooth/built-in.o: In function `ll_setup':
hci_ll.c:(.text+0x289e): undefined reference to `serdev_device_set_flow_control'
hci_ll.c:(.text+0x2b9c): undefined reference to `serdev_device_set_baudrate'
drivers/bluetooth/built-in.o: In function `ll_open':
hci_ll.c:(.text+0x2c77): undefined reference to `serdev_device_open'
drivers/bluetooth/built-in.o: In function `ll_init':
(.init.text+0x10d): undefined reference to `__serdev_device_driver_register'

We already have CONFIG_BT_HCIUART_SERDEV as a Kconfig symbol that is
set when the serdev code is reachable by a driver. Unlike the nokia
driver, this one can also be built when serdev is completely disabled,
so we add a dependency on serdev either being usable or disabled here.

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index a63130ef2b98..b2cf0ae6b62d 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -133,6 +133,7 @@ config BT_HCIUART_ATH3K
 config BT_HCIUART_LL
 	bool "HCILL protocol support"
 	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV || SERIAL_DEV_BUS=n
 	help
 	  HCILL (HCI Low Level) is a serial protocol for communication
 	  between Bluetooth device and host. This protocol is required for
-- 
2.9.0
