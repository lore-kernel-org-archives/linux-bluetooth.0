Return-Path: <cyrus@holtmann.org>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Loic Poulain <loic.poulain@intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] Bluetooth: hci_intel: Cleanup the device probe code
Date: Wed, 30 Sep 2015 16:28:52 +0300
Message-Id: <1443619732-19401-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is some unneeded code in "hci_intel" probing. First
acpi_match_device() call is needless as driver/platform/acpi core code has
already done the matching before calling the probe and the driver does not
use the returned pointer to matching _HID other than checking is it NULL.

Then tree wide grep for "hci_intel" doesn't reveal that there is any code
registering this platform device so it looks this device is always backed
with ACPI companion so also ACPI_HANDLE() test can be removed.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/bluetooth/hci_intel.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 49e25409de67..2952107e3bae 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1165,22 +1165,6 @@ static const struct acpi_device_id intel_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, intel_acpi_match);
-
-static int intel_acpi_probe(struct intel_device *idev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(intel_acpi_match, &idev->pdev->dev);
-	if (!id)
-		return -ENODEV;
-
-	return 0;
-}
-#else
-static int intel_acpi_probe(struct intel_device *idev)
-{
-	return -ENODEV;
-}
 #endif
 
 #ifdef CONFIG_PM
@@ -1248,14 +1232,6 @@ static int intel_probe(struct platform_device *pdev)
 
 	idev->pdev = pdev;
 
-	if (ACPI_HANDLE(&pdev->dev)) {
-		int err = intel_acpi_probe(idev);
-		if (err)
-			return err;
-	} else {
-		return -ENODEV;
-	}
-
 	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
 					      GPIOD_OUT_LOW);
 	if (IS_ERR(idev->reset)) {
-- 
2.5.3

