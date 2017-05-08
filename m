Return-Path: <tobias.regnery@gmail.com>
From: Tobias Regnery <tobias.regnery@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sre@kernel.org,
	Tobias Regnery <tobias.regnery@gmail.com>
Subject: [PATCH] Bluetooth: hci_nokia: select BT_HCIUART_H4
Date: Mon,  8 May 2017 11:39:11 +0200
Message-Id: <20170508093911.25228-1-tobias.regnery@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We see the following build failure with CONFIG_BT_HCIUART_NOKIA=y and
CONFIG_BT_HCIUART_H4=n:

drivers/bluetooth/hci_nokia.c: In function 'nokia_recv':
drivers/bluetooth/hci_nokia.c:644:18: error: implicit declaration of function 'h4_recv_buf' [-Werror=implicit-function-declaration]
...

Fix this by selecting the BT_HCIUART_H4 symbol like all the other users
of the protocoll.

Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index e5fd24d90b0a..35952a94875e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -97,6 +97,7 @@ config BT_HCIUART_NOKIA
 	depends on BT_HCIUART
 	depends on BT_HCIUART_SERDEV
 	depends on PM
+	select BT_HCIUART_H4
 	help
 	  Nokia H4+ is serial protocol for communication between Bluetooth
 	  device and host. This protocol is required for Bluetooth devices
-- 
2.11.0
