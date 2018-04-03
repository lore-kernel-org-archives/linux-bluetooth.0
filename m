Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Remove irq-active-low DMI quirk for the Thinkpad 8
Date: Tue,  3 Apr 2018 17:35:21 +0200
Message-Id: <20180403153521.16349-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Interrupts specified through an "Interrupt" ACPI resource (versus through
a "GpioInt" resource) are now always assumed to be active low.

When this change was originally made the Thinkpad 8 quirk was kept around
because it was uncertain if the Thinkpad 8 uses an "Interrupt" or a
"GpioInt" resource.

Bug https://bugzilla.kernel.org/show_bug.cgi?id=196701 has a DSDT for the
Thinkpad 8 attached and it uses an "Interrupt" resource, so the quirk is
not necessary and the quirk, as well as the irq-active-low quirk handling
code can be removed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index c937a0600f0f..3cd11b59b533 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -809,18 +809,6 @@ static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
 };
 
 #ifdef CONFIG_ACPI
-/* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
-static const struct dmi_system_id bcm_active_low_irq_dmi_table[] = {
-	{	/* Handle ThinkPad 8 tablets with BCM2E55 chipset ACPI ID */
-		.ident = "Lenovo ThinkPad 8",
-		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 8"),
-		},
-	},
-	{ }
-};
-
 static int bcm_resource(struct acpi_resource *ares, void *data)
 {
 	struct bcm_device *dev = data;
@@ -967,7 +955,6 @@ static int bcm_get_resources(struct bcm_device *dev)
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	LIST_HEAD(resources);
-	const struct dmi_system_id *dmi_id;
 	const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
 	struct resource_entry *entry;
 	int ret;
@@ -1014,13 +1001,6 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 		dev->irq_active_low = irq_polarity;
 		dev_warn(dev->dev, "Overwriting IRQ polarity to active %s by module-param\n",
 			 dev->irq_active_low ? "low" : "high");
-	} else {
-		dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
-		if (dmi_id) {
-			dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
-				 dmi_id->ident);
-			dev->irq_active_low = true;
-		}
 	}
 
 	return 0;
-- 
2.17.0.rc2
