Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Add active_low irq polarity quirk for Asus T100CHI
Date: Thu, 29 Jun 2017 14:21:32 +0200
Message-Id: <20170629122132.4537-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Just like the T100TA the host-wake irq on the Asus T100CHI is
active low. Having a quirk for this is actually extra important on the
T100CHI as it ships with a bluetooth keyboard dock, which does not
work properly without this quirk.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f87bfdfee4ff..fc4575c69dbd 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -657,6 +657,15 @@ static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
 		},
 		.driver_data = &acpi_active_low,
 	},
+	{
+		.ident = "Asus T100CHI",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
+					"ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100CHI"),
+		},
+		.driver_data = &acpi_active_low,
+	},
 	{	/* Handle ThinkPad 8 tablets with BCM2E55 chipset ACPI ID */
 		.ident = "Lenovo ThinkPad 8",
 		.matches = {
-- 
2.13.0
