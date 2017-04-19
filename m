Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@codeaurora.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blutooth: try to improve CONFIG_SERIAL_DEV_BUS dependency
Date: Wed, 19 Apr 2017 19:50:18 +0200
Message-Id: <20170419175051.4177480-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

With CONFIG_SERIAL_DEV_BUS=m, the hci_serdev.o file does not actually
get built into hci_uart.o as the Makefile doesn't pick it up, leading
to a link error with anything referring to it:

ERROR: "hci_uart_register_device" [drivers/bluetooth/hci_nokia.ko] undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed

Changing this in the Makefile would cause another problem when
hci_uart itself is built-in and cannot reference symbols from the
serdev module.

This tries to address both problems by introducing a new hidden
Kconfig symbol that controls both the compilation of hci_serdev.o
and whether the Nokia driver can be selected. This seems to address
the problem for me, though there might be a better way to do it.

Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig  | 8 +++++++-
 drivers/bluetooth/Makefile | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 8aafbed9e160..737d93ef27c5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -76,6 +76,12 @@ config BT_HCIUART
 	  Say Y here to compile support for Bluetooth UART devices into the
 	  kernel or say M to compile it as module (hci_uart).
 
+config BT_HCIUART_SERDEV
+	bool
+	depends on SERIAL_DEV_BUS && BT_HCIUART
+	depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
+	default y
+
 config BT_HCIUART_H4
 	bool "UART (H4) protocol support"
 	depends on BT_HCIUART
@@ -89,7 +95,7 @@ config BT_HCIUART_H4
 config BT_HCIUART_NOKIA
 	tristate "UART Nokia H4+ protocol support"
 	depends on BT_HCIUART
-	depends on SERIAL_DEV_BUS
+	depends on BT_HCIUART_SERDEV
 	depends on PM
 	help
 	  Nokia H4+ is serial protocol for communication between Bluetooth
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index a7f237320f4b..e693ca6eeed9 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -31,7 +31,7 @@ btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
 
 hci_uart-y				:= hci_ldisc.o
-hci_uart-$(CONFIG_SERIAL_DEV_BUS)	+= hci_serdev.o
+hci_uart-$(CONFIG_BT_HCIUART_SERDEV)	+= hci_serdev.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
 hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
-- 
2.9.0
