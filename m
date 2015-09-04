Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: hci_bcm: Fix IRQ polarity for T100
Date: Fri,  4 Sep 2015 15:35:45 +0200
Message-Id: <1441373747-23042-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ACPI table for BCM2E39 of T100TA is not correct.
Invert irq_polarity for this device.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f306541..efb9566 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -32,6 +32,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/tty.h>
 #include <linux/interrupt.h>
+#include <linux/dmi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -546,6 +547,20 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
+/* IRQ polarity of some chipset are not defined correctly in ACPI table. */
+static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Asus T100TA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+		},
+	},
+#endif
+	{ }
+};
+
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
@@ -608,6 +623,12 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
 
+	if (strstr(id->id, "BCM2E39") &&
+	    dmi_check_system(bcm_wrong_irq_dmi_table)) {
+		bt_dev_dbg(dev, "Fix irq polarity");
+		dev->irq_polarity = !dev->irq_polarity;
+	}
+
 	return 0;
 }
 #else
-- 
1.9.1

