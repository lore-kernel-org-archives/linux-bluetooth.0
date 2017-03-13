Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Loic Poulain <loic.poulain@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] Bluetooth: btqcomsmd: fix compile-test dependency
Date: Mon, 13 Mar 2017 17:06:21 +0100
Message-Id: <20170313160635.612251-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

compile-testing fails when QCOM_SMD is a loadable module:

drivers/bluetooth/built-in.o: In function `btqcomsmd_send':
btqca.c:(.text+0xa8): undefined reference to `qcom_smd_send'
drivers/bluetooth/built-in.o: In function `btqcomsmd_probe':
btqca.c:(.text+0x3ec): undefined reference to `qcom_wcnss_open_channel'
btqca.c:(.text+0x46c): undefined reference to `qcom_smd_set_drvdata'

This clarifies the dependency to allow compile-testing only when
SMD is completely disabled, otherwise the dependency on QCOM_SMD
will make sure we can link against it.

Fixes: e27ee2b16bad ("Bluetooth: btqcomsmd: Allow driver to build if COMPILE_TEST is enabled")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Sent on March 1 2017 originally, still needed for v4.11-rc2
---
 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c2c14a12713b..2ef2b240b31b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -344,7 +344,7 @@ config BT_WILINK
 
 config BT_QCOMSMD
 	tristate "Qualcomm SMD based HCI support"
-	depends on (QCOM_SMD && QCOM_WCNSS_CTRL) || COMPILE_TEST
+	depends on (QCOM_SMD && QCOM_WCNSS_CTRL) || (COMPILE_TEST && QCOM_SMD=n)
 	select BT_QCA
 	help
 	  Qualcomm SMD based HCI driver.
-- 
2.9.0
