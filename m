Return-Path: <javier@osg.samsung.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btqcomsmd: Allow driver to build if COMPILE_TEST is enabled
Date: Mon,  2 Jan 2017 10:23:23 -0300
Message-Id: <1483363403-25934-1-git-send-email-javier@osg.samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The driver only has runtime but no build time dependency with QCOM_SMD &&
QCOM_WCNSS_CTRL. So it can be built for testing purposes if COMPILE_TEST
option is enabled.

This is useful to have more build coverage and make sure that the driver
is not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 3cc9bff9d99d..c2c14a12713b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -344,7 +344,7 @@ config BT_WILINK
 
 config BT_QCOMSMD
 	tristate "Qualcomm SMD based HCI support"
-	depends on QCOM_SMD && QCOM_WCNSS_CTRL
+	depends on (QCOM_SMD && QCOM_WCNSS_CTRL) || COMPILE_TEST
 	select BT_QCA
 	help
 	  Qualcomm SMD based HCI driver.
-- 
2.7.4
