Return-Path: <raghuhack78@gmail.com>
From: RAGHU Halharvi <raghuhack78@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: RAGHU Halharvi <raghuhack78@gmail.com>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth:hci_bcm:Check return value from devm_clk_get
Date: Tue, 17 Jul 2018 17:36:35 +0530
Message-Id: <20180717120635.25259-1-raghuhack78@gmail.com>
In-Reply-To: <5b4ddae5.1c69fb81.61055.042e.GMRIR@mx.google.com>
References: <5b4ddae5.1c69fb81.61055.042e.GMRIR@mx.google.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Check return value from devm_clk_get & return appropriate error.
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 441f5e1deb11..1295cc89d702 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -910,6 +910,8 @@ static int bcm_get_resources(struct bcm_device *dev)
 		return 0;
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.17.1
