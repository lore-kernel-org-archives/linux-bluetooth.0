Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	John Keeping <john@metanate.com>
Subject: [PATCH] Bluetooth: hci_bcm: Fix clock (un)prepare
Date: Wed, 15 Mar 2017 12:20:04 +0000
Message-Id: <20170315122005.7702-1-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_bcm driver currently does not prepare/unprepare the clock and
goes directly to enable, but as the documentation for clk_enable says,
clk_prepare must be called before clk_enable.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/bluetooth/hci_bcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5262a2077d7a..c7d3c6842bcf 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -146,13 +146,13 @@ static bool bcm_device_exists(struct bcm_device *device)
 static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
-		clk_enable(dev->clk);
+		clk_prepare_enable(dev->clk);
 
 	gpiod_set_value(dev->shutdown, powered);
 	gpiod_set_value(dev->device_wakeup, powered);
 
 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
-		clk_disable(dev->clk);
+		clk_disable_unprepare(dev->clk);
 
 	dev->clk_enabled = powered;
 
-- 
2.12.0.377.gf910686b23.dirty
