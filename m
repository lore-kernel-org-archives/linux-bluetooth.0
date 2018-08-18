Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jiecheng Wu <jasonwood2031@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hci_bcm.c: fix missing return value check of devm_clk_get()
Date: Sat, 18 Aug 2018 10:06:06 +0800
Message-Id: <20180818020606.12052-1-jasonwood2031@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Function bcm_get_resources() defined in drivers/bluetooth/hci_bcm.c calls devm_clk_get() that may return an error code. The return value of function bcm_get_resources() should be checked whether it is an error code.
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6..f4089a2 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -906,6 +906,8 @@ static int bcm_get_resources(struct bcm_device *dev)
 		return 0;
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.6.4
