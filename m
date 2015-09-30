Return-Path: <cyrus@holtmann.org>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/5] Bluetooth: hci_bcm: Remove needless acpi_match_device() call
Date: Wed, 30 Sep 2015 16:26:43 +0300
Message-Id: <1443619605-19320-3-git-send-email-jarkko.nikula@linux.intel.com>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to call acpi_match_device() in driver's probe path and
verify does it find a match to given ACPI _HIDs in .acpi_match_table as
driver/platform/acpi core code has found the match prior calling the probe.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5375c9c04fda..a1b9bbcbcb79 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -647,16 +647,11 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
-	const struct acpi_device_id *id;
 	struct acpi_device *adev;
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
 	int ret;
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (!id)
-		return -ENODEV;
-
 	/* Retrieve GPIO data */
 	dev->name = dev_name(&pdev->dev);
 	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
-- 
2.5.3
