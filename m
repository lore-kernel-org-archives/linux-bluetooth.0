Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?=
        <jerome.debretagne@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Fix autosuspend PM for Lenovo ThinkPad 8
Date: Sun,  9 Oct 2016 15:51:05 +0200
Message-Id: <20161009135105.7970-1-jerome.debretagne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ACPI table for BCM2E55 of Lenovo ThinkPad 8 is not correct.
Set correctly IRQ polarity for this device, fixing the issue of bluetooth
never resuming after autosuspend PM.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5ccb90e..8f6c23c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -643,6 +643,14 @@ static const struct dmi_system_id bcm_wrong_irq_dmi_table[] = {
 		},
 		.driver_data = &acpi_active_low,
 	},
+	{	/* Handle ThinkPad 8 tablets with BCM2E55 chipset ACPI ID */
+		.ident = "Lenovo ThinkPad 8",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 8"),
+		},
+		.driver_data = &acpi_active_low,
+	},
 	{ }
 };
 
-- 
2.9.3

