Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: David Lechner <david@lechnology.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Tobias Regnery <tobias.regnery@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hciuart: add nvmem dependency
Date: Tue,  2 Jan 2018 11:50:30 +0100
Message-Id: <20180102105044.1436954-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

When the hci support is built-in, but mvmem is a loadable module, we
get a link failure:

drivers/bluetooth/hci_ll.o: In function `hci_ti_probe':
hci_ll.c:(.text+0x226): undefined reference to `nvmem_cell_get'
hci_ll.c:(.text+0x238): undefined reference to `nvmem_cell_read'
hci_ll.c:(.text+0x244): undefined reference to `nvmem_cell_put'

This adds another Kconfig dependency to enforce valid configurations.

Fixes: 0e58d0cdb3eb ("Bluetooth: hci_ll: Add optional nvmem BD address source")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 41932f0e68d0..d816ce9e23a7 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -77,6 +77,7 @@ config BT_HCIBTSDIO
 config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
+	depends on NVMEM || !NVMEM
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
-- 
2.9.0
