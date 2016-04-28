Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: heikki.krogerus@linux.intel.com,
	linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_intel: Fix null gpio desc pointer dereference
Date: Thu, 28 Apr 2016 18:48:25 +0200
Message-Id: <1461862105-23970-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

gpiod_get_optional can return either ERR_PTR or NULL pointer.
NULL case is not tested and then dereferenced later in desc_to_gpio.
Fix this by using non optional version which returns ERR_PTR in any
error case (this is not an optional gpio).
Use the same non optional version for the host-wake gpio.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 91d6051..f6f2b01 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1210,8 +1210,7 @@ static int intel_probe(struct platform_device *pdev)
 
 	idev->pdev = pdev;
 
-	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
-					      GPIOD_OUT_LOW);
+	idev->reset = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(idev->reset)) {
 		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
 		return PTR_ERR(idev->reset);
@@ -1223,8 +1222,7 @@ static int intel_probe(struct platform_device *pdev)
 
 		dev_err(&pdev->dev, "No IRQ, falling back to gpio-irq\n");
 
-		host_wake = devm_gpiod_get_optional(&pdev->dev, "host-wake",
-						    GPIOD_IN);
+		host_wake = devm_gpiod_get(&pdev->dev, "host-wake", GPIOD_IN);
 		if (IS_ERR(host_wake)) {
 			dev_err(&pdev->dev, "Unable to retrieve IRQ\n");
 			goto no_irq;
-- 
1.9.1
