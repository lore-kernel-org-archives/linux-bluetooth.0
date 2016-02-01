Return-Path: <jjmeijer88@gmail.com>
From: "J.J. Meijer" <jjmeijer88@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	meijjaa <jjmeijer88@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Add new ACPI ID for bcm43241
Date: Mon,  1 Feb 2016 23:47:55 +0100
Message-Id: <1454366875-32259-1-git-send-email-jjmeijer88@gmail.com>
In-Reply-To: <[PATCH] Another ACPI ID for bcm43241>
References: <[PATCH] Another ACPI ID for bcm43241>
List-ID: <linux-bluetooth.vger.kernel.org>

From: meijjaa <jjmeijer88@gmail.com>

This ACPI ID is used at least by HP for their Omni 10 5600eg tablet.

Signed-off-by: meijjaa <jjmeijer88@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 4797c5c..48dbf51 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -820,6 +820,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E3D", 0 },
 	{ "BCM2E3F", 0 },
 	{ "BCM2E40", 0 },
+	{ "BCM2E54", 0 },
 	{ "BCM2E64", 0 },
 	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
-- 
2.7.0
