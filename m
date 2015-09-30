Return-Path: <cyrus@holtmann.org>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/5] Bluetooth: hci_bcm: Remove needless looking code
Date: Wed, 30 Sep 2015 16:26:44 +0300
Message-Id: <1443619605-19320-4-git-send-email-jarkko.nikula@linux.intel.com>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Tree wide grep for "hci_bcm" doesn't reveal there is any code registering
this platform device and "struct acpi_device_id" use for passing the
platform data looks a debug/test code leftover to me.

I'm assuming this driver effectively supports only ACPI enumeration and
thus test for ACPI_HANDLE() and platform data can be removed.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index a1b9bbcbcb79..967d16692925 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -724,7 +724,6 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 static int bcm_probe(struct platform_device *pdev)
 {
 	struct bcm_device *dev;
-	struct acpi_device_id *pdata = pdev->dev.platform_data;
 	int ret;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
@@ -733,15 +732,9 @@ static int bcm_probe(struct platform_device *pdev)
 
 	dev->pdev = pdev;
 
-	if (ACPI_HANDLE(&pdev->dev)) {
-		ret = bcm_acpi_probe(dev);
-		if (ret)
-			return ret;
-	} else if (pdata) {
-		dev->name = pdata->id;
-	} else {
-		return -ENODEV;
-	}
+	ret = bcm_acpi_probe(dev);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, dev);
 
-- 
2.5.3
