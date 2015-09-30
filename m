Return-Path: <cyrus@holtmann.org>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-acpi@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/5] Bluetooth: hci_bcm: Handle possible error from acpi_dev_get_resources()
Date: Wed, 30 Sep 2015 16:26:42 +0300
Message-Id: <1443619605-19320-2-git-send-email-jarkko.nikula@linux.intel.com>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Driver doesn't handle possible error from acpi_dev_get_resources(). Test it
and return the error code in case of error.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a538ad6bf2b..5375c9c04fda 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -705,7 +705,9 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (!adev)
 		return 0;
 
-	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+	ret = acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+	if (ret < 0)
+		return ret;
 	acpi_dev_free_resource_list(&resources);
 
 	dmi_id = dmi_first_match(bcm_wrong_irq_dmi_table);
-- 
2.5.3
