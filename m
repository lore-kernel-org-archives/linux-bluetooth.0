Return-Path: <jeffy.chen@rock-chips.com>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-bluetooth@vger.kernel.org
Cc: Amitkumar Karwar <akarwar@marvell.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Brian Norris <briannorris@chromium.org>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] btmrvl: avoid double-disable_irq() race
Date: Fri, 20 Jan 2017 19:14:18 +0800
Message-Id: <1484910860-7690-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

It's much the same as what we did for mwifiex in:
b9da4d2 mwifiex: avoid double-disable_irq() race

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/bluetooth/btmrvl_sdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index d02f2c1..c738bae 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1682,8 +1682,12 @@ static int btmrvl_sdio_resume(struct device *dev)
 	/* Disable platform specific wakeup interrupt */
 	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
 		disable_irq_wake(card->plt_wake_cfg->irq_bt);
-		if (!card->plt_wake_cfg->wake_by_bt)
-			disable_irq(card->plt_wake_cfg->irq_bt);
+		disable_irq(card->plt_wake_cfg->irq_bt);
+		if (card->plt_wake_cfg->wake_by_bt)
+			/* Undo our disable, since interrupt handler already
+			 * did this.
+			 */
+			enable_irq(card->plt_wake_cfg->irq_bt);
 	}
 
 	return 0;
-- 
2.1.4
