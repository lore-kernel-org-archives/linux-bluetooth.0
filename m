Return-Path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl: *_err() and *_info() strings should end with newlines
Date: Mon, 25 Sep 2017 13:07:39 +0530
Message-Id: <4f30b7d1f1933dadaa9a9af8adc66b85b67bb573.1506324921.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

pr_err(), dev_err() and pr_info() messages should terminated with
a new-line to avoid other messages being concatenated onto the end.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 03341ce9..cd709a7 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -64,7 +64,7 @@ static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
 	struct btmrvl_sdio_card *card = priv;
 	struct btmrvl_plt_wake_cfg *cfg = card->plt_wake_cfg;
 
-	pr_info("%s: wake by bt", __func__);
+	pr_info("%s: wake by bt\n", __func__);
 	cfg->wake_by_bt = true;
 	disable_irq_nosync(irq);
 
@@ -87,7 +87,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 
 	if (!dev->of_node ||
 	    !of_match_node(btmrvl_sdio_of_match_table, dev->of_node)) {
-		pr_err("sdio platform data not available");
+		pr_err("sdio platform data not available\n");
 		return -1;
 	}
 
@@ -99,7 +99,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 	if (cfg && card->plt_of_node) {
 		cfg->irq_bt = irq_of_parse_and_map(card->plt_of_node, 0);
 		if (!cfg->irq_bt) {
-			dev_err(dev, "fail to parse irq_bt from device tree");
+			dev_err(dev, "fail to parse irq_bt from device tree\n");
 			cfg->irq_bt = -1;
 		} else {
 			ret = devm_request_irq(dev, cfg->irq_bt,
-- 
1.9.1
