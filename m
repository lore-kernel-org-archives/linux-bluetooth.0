Return-Path: <root@localhost.localdomain>
From: Xinming Hu <huxm@marvell.com>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Amitkumar Karwar
	<akarwar@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Xinming Hu
	<huxm@marvell.com>, Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/2] Bluetooth: btmrvl: remove unnecessary wakeup interrupt number sanity check
Date: Thu, 30 Mar 2017 22:37:16 +0800
Message-ID: <1490884636-18684-2-git-send-email-huxm@marvell.com>
In-Reply-To: <1490884636-18684-1-git-send-email-huxm@marvell.com>
References: <1490884636-18684-1-git-send-email-huxm@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Sanity check of interrupt number in interrupt handler is unnecessary and
confusion, remove it.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
v2: fix apply error in v1
---
 drivers/bluetooth/btmrvl_sdio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 95e40ec..eb794f0 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -64,11 +64,9 @@ static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
 	struct btmrvl_sdio_card *card = priv;
 	struct btmrvl_plt_wake_cfg *cfg = card->plt_wake_cfg;
 
-	if (cfg->irq_bt >= 0) {
-		pr_info("%s: wake by bt", __func__);
-		cfg->wake_by_bt = true;
-		disable_irq_nosync(irq);
-	}
+	pr_info("%s: wake by bt", __func__);
+	cfg->wake_by_bt = true;
+	disable_irq_nosync(irq);
 
 	pm_wakeup_event(&card->func->dev, 0);
 	pm_system_wakeup();
-- 
1.8.1.4
