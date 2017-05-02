Return-Path: <tobias.regnery@gmail.com>
From: Tobias Regnery <tobias.regnery@gmail.com>
To: robh@kernel.org,
	marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] bluetooth: hci_uart: fix kconfig dependency
Date: Tue,  2 May 2017 15:15:01 +0200
Message-Id: <20170502131501.15851-1-tobias.regnery@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We see the following link error with CONFIG_BT_HCIUART=y,
CONFIG_BT_HCIUART_LL=y and CONFIG_SERIAL_DEV_BUS=m:

drivers/built-in.o: In function 'll_close':
supp.c:(.text+0x55add4): undefined reference to 'serdev_device_close'
supp.c:(.text+0x55add4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_close'
drivers/built-in.o: In function 'll_open':
supp.c:(.text+0x55aed0): undefined reference to 'serdev_device_open'
supp.c:(.text+0x55aed0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_open'
drivers/built-in.o: In function `hci_ti_probe':
supp.c:(.text+0x55b00c): undefined reference to 'hci_uart_register_device'
supp.c:(.text+0x55b00c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'hci_uart_register_device'
drivers/built-in.o: In function `ll_setup':
supp.c:(.text+0x55b08c): undefined reference to 'serdev_device_set_flow_control'
supp.c:(.text+0x55b08c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_set_flow_control'
supp.c:(.text+0x55b324): undefined reference to 'serdev_device_set_baudrate'
supp.c:(.text+0x55b324): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 'serdev_device_set_baudrate'
drivers/built-in.o: In function 'll_init':
supp.c:(.init.text+0x1b508): undefined reference to '__serdev_device_driver_register'
supp.c:(.init.text+0x1b508): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol '__serdev_device_driver_register'

Fix this by dependig BT_HCIUART_LL on the BT_HCIUART_SERDEV symbol.
This implies a dependency on BT_HCIUART and hci_ll.c is only compiled in
if SERIAl_DEV_BUS is built in or SERIAL_DEV_BUS and BT_HCIUART are
modules.

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
Hi,

I'm not sure if this is the right fix because the dependencies are quite
complicated but at least the build failure goes away with this change.

 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 737d93ef27c5..e5fd24d90b0a 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -131,7 +131,7 @@ config BT_HCIUART_ATH3K
 
 config BT_HCIUART_LL
 	bool "HCILL protocol support"
-	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
 	help
 	  HCILL (HCI Low Level) is a serial protocol for communication
 	  between Bluetooth device and host. This protocol is required for
-- 
2.11.0
