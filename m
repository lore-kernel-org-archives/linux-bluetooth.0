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
Subject: [PATCH v2 3/3] btmrvl: use dt's irqflags for wakeup pin
Date: Mon, 23 Jan 2017 12:18:53 +0800
Message-Id: <1485145133-8612-3-git-send-email-jeffy.chen@rock-chips.com>
In-Reply-To: <1485145133-8612-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1485145133-8612-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use irqflags parsed from dt.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2: None

 drivers/bluetooth/btmrvl_sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 796f719..23711fe 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -101,8 +101,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 		} else {
 			ret = devm_request_irq(dev, cfg->irq_bt,
 					       btmrvl_wake_irq_bt,
-					       IRQF_TRIGGER_LOW,
-					       "bt_wake", cfg);
+					       0, "bt_wake", cfg);
 			if (ret) {
 				dev_err(dev,
 					"Failed to request irq_bt %d (%d)\n",
-- 
2.1.4
