Return-Path: <jeffy.chen@rock-chips.com>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Rajat Jain <rajatja@google.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] btmrvl: wake system up when receives a wake irq
Date: Fri, 24 Feb 2017 14:24:30 +0800
Message-Id: <1487917471-5501-2-git-send-email-jeffy.chen@rock-chips.com>
In-Reply-To: <1487917471-5501-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1487917471-5501-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Currrently we are disabling this wake irq after receiving it. If this
happens before we finish suspend and the pm event check is disabled,
the system will continue suspending, and this irq would not work again.

We may need to abort system suspend to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/bluetooth/btmrvl_sdio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 08e01f0..d39bf3c 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -20,6 +20,7 @@
 
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
@@ -60,7 +61,8 @@ static const struct of_device_id btmrvl_sdio_of_match_table[] = {
 
 static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
 {
-	struct btmrvl_plt_wake_cfg *cfg = priv;
+	struct btmrvl_sdio_card *card = priv;
+	struct btmrvl_plt_wake_cfg *cfg = card->plt_wake_cfg;
 
 	if (cfg->irq_bt >= 0) {
 		pr_info("%s: wake by bt", __func__);
@@ -68,6 +70,9 @@ static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
 		disable_irq_nosync(irq);
 	}
 
+	pm_wakeup_event(&card->func->dev, 0);
+	pm_system_wakeup();
+
 	return IRQ_HANDLED;
 }
 
@@ -101,7 +106,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 		} else {
 			ret = devm_request_irq(dev, cfg->irq_bt,
 					       btmrvl_wake_irq_bt,
-					       0, "bt_wake", cfg);
+					       0, "bt_wake", card);
 			if (ret) {
 				dev_err(dev,
 					"Failed to request irq_bt %d (%d)\n",
-- 
2.1.4
