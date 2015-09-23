Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/5] Bluetooth: hci_bcm: Fix IRQ polarity for T100
Date: Wed, 23 Sep 2015 18:18:08 +0200
Message-Id: <1443025091-1864-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
References: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ACPI table for BCM2E39 of T100TA is not correct.
Set correct irq_polarity for this device.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f306541..2cb5089 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -32,6 +32,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/tty.h>
 #include <linux/interrupt.h>
+#include <linux/dmi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -513,6 +514,22 @@ static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
 };
 
 #ifdef CONFIG_ACPI
+static u8 acpi_active_low = ACPI_ACTIVE_LOW;
+
+/* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
+static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
+	{
+		.ident = "Asus T100TA",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
+					"ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+		},
+		.driver_data = &acpi_active_low,
+	},
+	{ }
+};
+
 static int bcm_resource(struct acpi_resource *ares, void *data)
 {
 	struct bcm_device *dev = data;
@@ -552,6 +569,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	const struct acpi_device_id *id;
 	struct acpi_device *adev;
 	LIST_HEAD(resources);
+	const struct dmi_system_id *dmi_id;
 	int ret;
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
@@ -608,6 +626,13 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
 
+	dmi_id = dmi_first_match(bcm_wrong_irq_dmi_table);
+	if (dmi_id) {
+		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
+			    dmi_id->ident);
+		dev->irq_polarity = *(u8 *)dmi_id->driver_data;
+	}
+
 	return 0;
 }
 #else
-- 
1.9.1

