Return-Path: <bjorn.andersson@linaro.org>
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btqcomsmd: fix compile-test dependency
Date: Mon, 20 Mar 2017 15:31:10 -0700
Message-Id: <20170320223110.30431-1-bjorn.andersson@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

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
[bjorn: Restructure and clarify dependency to QCOM_WCNSS_CTRL]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bluetooth/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c2c14a12713b..08e054507d0b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -344,7 +344,8 @@ config BT_WILINK
 
 config BT_QCOMSMD
 	tristate "Qualcomm SMD based HCI support"
-	depends on (QCOM_SMD && QCOM_WCNSS_CTRL) || COMPILE_TEST
+	depends on QCOM_SMD || (COMPILE_TEST && QCOM_SMD=n)
+	depends on QCOM_WCNSS_CTRL || (COMPILE_TEST && QCOM_WCNSS_CTRL=n)
 	select BT_QCA
 	help
 	  Qualcomm SMD based HCI driver.
-- 
2.12.0
