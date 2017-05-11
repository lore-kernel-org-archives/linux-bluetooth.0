Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Gross <andy.gross@linaro.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Loic Poulain <loic.poulain@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_nokia: select CONFIG_BT_HCIUART_H4
Date: Thu, 11 May 2017 14:11:26 +0200
Message-Id: <20170511121135.3505055-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Like the other H4 variants, this only builds when the base
H4 support is enabled, otherwise we get a build error:

drivers/bluetooth/hci_nokia.c:624:33: error: array type has incomplete element type 'struct h4_recv_pkt'

Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 40994d96d151..b2cf0ae6b62d 100644
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
2.9.0
