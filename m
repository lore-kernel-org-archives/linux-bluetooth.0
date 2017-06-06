Return-Path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] Bluetooth: hci_bcm: Switch to devm_acpi_dev_add_driver_gpios()
Date: Tue,  6 Jun 2017 17:47:17 +0300
Message-Id: <20170606144718.77620-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Switch to use managed variant of acpi_dev_add_driver_gpios() to simplify
error path and fix potentially wrong assingment if ->probe() fails.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f87bfdfee4ff..e2096c7803b3 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -762,8 +762,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (id)
 		gpio_mapping = (const struct acpi_gpio_mapping *) id->driver_data;
 
-	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
-					gpio_mapping);
+	ret = devm_acpi_dev_add_driver_gpios(&pdev->dev, gpio_mapping);
 	if (ret)
 		return ret;
 
@@ -834,8 +833,6 @@ static int bcm_remove(struct platform_device *pdev)
 	list_del(&dev->list);
 	mutex_unlock(&bcm_device_lock);
 
-	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
-
 	dev_info(&pdev->dev, "%s device unregistered.\n", dev->name);
 
 	return 0;
-- 
2.11.0
