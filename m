Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: hci_bcm: Do not tie GPIO pin order to a specific ACPI HID
Date: Fri, 16 Mar 2018 21:28:11 +0100
Message-Id: <20180316202811.5678-5-hdegoede@redhat.com>
In-Reply-To: <20180316202811.5678-1-hdegoede@redhat.com>
References: <20180316202811.5678-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Since I've been doing a lot of work on Linux Bay Trail / Cherry Trail
support, I've gathered a collection of ACPI DSDTs from about 50 such
machines.

Looking at these DSTDs many have an ACPI device entry describing a bcm
bluetooth device (often disabled in the DSDT), quite a few of these ACPI
device entries have a resource-table where the order does not match with
the order currently associated with the HID of that entry in the
bcm_acpi_match table.

Looking at the Windows .inf files, there is nothing indicating a specific
order there, so I believe that there is no 1:1 mapping between the ACPI
HID and the order in which the resources are listed.

Therefor this commit replaces the hardcoded mapping based on ACPI HID,
with code which actually checks in which order the resources are listed
and bases the gpio-mapping on that.

This should ensure that we always pick the right mapping and this will
make adding new ACPI HIDs to the driver easier.

This has been tested on the following devices:
-Asus T100CHI           BCM2E39 / brcmfmac43241b4-sdio / BCM4324B3-37.4M.hcd
-Asus T100TA            BCM2E39 / brcmfmac43241b4-sdio / BCM4324B3-37.4M.hcd
-Asus T200TA            BCM2E65 / brcmfmac43340-sdio   / BCM43341B0-37.4M.hcd
-Jumper ezPad mini 3    BCM2E74 / brcmfmac43430a0-sdio / BCM4343A0-26M.hcd
-Acer Iconia Tab8 w1-8  BCM2E83 / brcmfmac4330-sdio    / BCM4330B1-26M.hcd
-Chuwi Vi8 plus(CWI519) BCM2EAA / brcmfmac43430-sdio   / BCM43430A1-26M.hcd

Which together cover all 3 combinations of using an Interrupt resource /
GpioInt resource as first resource / GpioInt resource as last resource.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 91 +++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 3c7fc5d6ef9f..13f8dda11715 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -98,6 +98,8 @@ struct bcm_device {
 	int			(*set_shutdown)(struct bcm_device *, bool);
 #ifdef CONFIG_ACPI
 	acpi_handle		btlp, btpu, btpd;
+	int			gpio_count;
+	int			gpio_int_idx;
 #endif
 
 	struct clk		*clk;
@@ -829,8 +831,11 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 
 	case ACPI_RESOURCE_TYPE_GPIO:
 		gpio = &ares->data.gpio;
-		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT)
+		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
+			dev->gpio_int_idx = dev->gpio_count;
 			dev->irq_active_low = gpio->polarity == ACPI_ACTIVE_LOW;
+		}
+		dev->gpio_count++;
 		break;
 
 	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
@@ -947,20 +952,11 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	LIST_HEAD(resources);
 	const struct dmi_system_id *dmi_id;
 	const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
-	const struct acpi_device_id *id;
 	struct resource_entry *entry;
 	int ret;
 
-	/* Retrieve GPIO data */
-	id = acpi_match_device(dev->dev->driver->acpi_match_table, dev->dev);
-	if (id)
-		gpio_mapping = (const struct acpi_gpio_mapping *) id->driver_data;
-
-	ret = devm_acpi_dev_add_driver_gpios(dev->dev, gpio_mapping);
-	if (ret)
-		return ret;
-
 	/* Retrieve UART ACPI info */
+	dev->gpio_int_idx = -1;
 	ret = acpi_dev_get_resources(ACPI_COMPANION(dev->dev),
 				     &resources, bcm_resource, dev);
 	if (ret < 0)
@@ -974,6 +970,29 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	}
 	acpi_dev_free_resource_list(&resources);
 
+	/* If the DSDT uses an Interrupt resource for the IRQ, then there are
+	 * only 2 GPIO resources, we use the irq-last mapping for this, since
+	 * we already have an irq the 3th / last mapping will not be used.
+	 */
+	if (dev->irq)
+		gpio_mapping = acpi_bcm_int_last_gpios;
+	else if (dev->gpio_int_idx == 0)
+		gpio_mapping = acpi_bcm_int_first_gpios;
+	else if (dev->gpio_int_idx == 2)
+		gpio_mapping = acpi_bcm_int_last_gpios;
+	else
+		dev_warn(dev->dev, "Unexpected ACPI gpio_int_idx: %d\n",
+			 dev->gpio_int_idx);
+
+	/* Warn if our expectations are not met. */
+	if (dev->gpio_count != (dev->irq ? 2 : 3))
+		dev_warn(dev->dev, "Unexpected number of ACPI GPIOs: %d\n",
+			 dev->gpio_count);
+
+	ret = devm_acpi_dev_add_driver_gpios(dev->dev, gpio_mapping);
+	if (ret)
+		return ret;
+
 	if (irq_polarity != -1) {
 		dev->irq_active_low = irq_polarity;
 		dev_warn(dev->dev, "Overwriting IRQ polarity to active %s by module-param\n",
@@ -1070,31 +1089,31 @@ static const struct hci_uart_proto bcm_proto = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
-	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E38", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E3F", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E40", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E54", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E55", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E64", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E65", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E67", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E72", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E74", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
-	{ "BCM2E83", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
-	{ "BCM2E84", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E90", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
-	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
-	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
-	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
-	{ "BCM2EAA", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2E1A" },
+	{ "BCM2E38" },
+	{ "BCM2E39" },
+	{ "BCM2E3A" },
+	{ "BCM2E3D" },
+	{ "BCM2E3F" },
+	{ "BCM2E40" },
+	{ "BCM2E54" },
+	{ "BCM2E55" },
+	{ "BCM2E64" },
+	{ "BCM2E65" },
+	{ "BCM2E67" },
+	{ "BCM2E71" },
+	{ "BCM2E72" },
+	{ "BCM2E74" },
+	{ "BCM2E7B" },
+	{ "BCM2E7C" },
+	{ "BCM2E7E" },
+	{ "BCM2E83" },
+	{ "BCM2E84" },
+	{ "BCM2E90" },
+	{ "BCM2E95" },
+	{ "BCM2E96" },
+	{ "BCM2EA4" },
+	{ "BCM2EAA" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
-- 
2.14.3
