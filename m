Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: add WCNSS dependency for HCI driver
Date: Mon, 29 Aug 2016 14:36:18 +0200
Message-Id: <20160829123630.3314682-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

The newly added bluetooth driver is based on the soc-specific support,
but lacks the obvious compile-time dependency on that:

drivers/bluetooth/btqcomsmd.o: In function `btqcomsmd_probe':
btqcomsmd.c:(.text.btqcomsmd_probe+0x40): undefined reference to `qcom_wcnss_open_channel'
btqcomsmd.c:(.text.btqcomsmd_probe+0x5c): undefined reference to `qcom_wcnss_open_channel'
Makefile:969: recipe for target 'vmlinux' failed

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 90c107dc8b2c ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
---
 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 2c481911f1ce..43e9f9328df8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -333,7 +333,7 @@ config BT_WILINK
 
 config BT_QCOMSMD
 	tristate "Qualcomm SMD based HCI support"
-	depends on QCOM_SMD
+	depends on QCOM_SMD && QCOM_WCNSS_CTRL
 	select BT_QCA
 	help
 	  Qualcomm SMD based HCI driver.
-- 
2.9.0
