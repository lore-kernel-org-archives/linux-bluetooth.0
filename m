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
Subject: [PATCH 2/3] btmrvl: set irq_bt to -1 when failed to parse it
Date: Fri, 20 Jan 2017 19:14:19 +0800
Message-Id: <1484910860-7690-2-git-send-email-jeffy.chen@rock-chips.com>
In-Reply-To: <1484910860-7690-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1484910860-7690-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The irq_of_parse_and_map will return 0 as a invalid irq.

Set irq_bt to -1 in this case, so that the btmrvl resume/suspend code
would not get confused.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/bluetooth/btmrvl_sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index c738bae..796f719 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -97,6 +97,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 		cfg->irq_bt = irq_of_parse_and_map(card->plt_of_node, 0);
 		if (!cfg->irq_bt) {
 			dev_err(dev, "fail to parse irq_bt from device tree");
+			cfg->irq_bt = -1;
 		} else {
 			ret = devm_request_irq(dev, cfg->irq_bt,
 					       btmrvl_wake_irq_bt,
-- 
2.1.4
