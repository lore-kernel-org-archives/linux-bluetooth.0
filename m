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
Subject: [PATCH resend] Bluetooth: hci_bcm: Add broken-irq dmi blacklist and add Meegopad T08 to it
Date: Tue,  3 Apr 2018 16:40:20 +0200
Message-Id: <20180403144020.14819-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The Meegopad T08 hdmi-stick (think Intel computestick) has a brcm43430
wifi/bt combo chip. The BCM2E90 ACPI device describing the BT part does
contain a valid ActiveLow GpioInt entry, but the GPIO it points to never
goes low, so either the IRQ pin is not connected, or the ACPI resource-
table points to the wrong GPIO.

Eitherway things will not work if we try to use the specified IRQ, this
commits adds a DMI based broken-irq blacklist and disables use of the IRQ
and thus also runtime-pm for devices on this list.

This blacklist starts with the the Meegopad T08, fixing bluetooth not
working on this hdmi-stick. Since this is not a battery powered device
the loss of runtime-pm is not really an issue.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 52cbd18f6ed1..26e4a0cb27c1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -794,6 +794,20 @@ static const struct acpi_gpio_mapping acpi_bcm_int_first_gpios[] = {
 	{ },
 };
 
+/* Some firmware reports an IRQ which does not work (wrong pin in fw table?) */
+static const struct dmi_system_id bcm_broken_irq_dmi_table[] = {
+	{
+		.ident = "Meegopad T08",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR,
+					"To be filled by OEM."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V1.1"),
+		},
+	},
+	{ }
+};
+
 #ifdef CONFIG_ACPI
 /* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
 static const struct dmi_system_id bcm_active_low_irq_dmi_table[] = {
@@ -911,6 +925,8 @@ static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
 
 static int bcm_get_resources(struct bcm_device *dev)
 {
+	const struct dmi_system_id *dmi_id;
+
 	dev->name = dev_name(dev->dev);
 
 	if (x86_apple_machine && !bcm_apple_get_resources(dev))
@@ -943,6 +959,13 @@ static int bcm_get_resources(struct bcm_device *dev)
 		dev->irq = gpiod_to_irq(gpio);
 	}
 
+	dmi_id = dmi_first_match(bcm_broken_irq_dmi_table);
+	if (dmi_id) {
+		dev_info(dev->dev, "%s: Has a broken IRQ config, disabling IRQ support / runtime-pm\n",
+			 dmi_id->ident);
+		dev->irq = 0;
+	}
+
 	dev_dbg(dev->dev, "BCM irq: %d\n", dev->irq);
 	return 0;
 }
-- 
2.17.0.rc2
