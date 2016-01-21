Return-Path: <jjmeijer88@gmail.com>
From: "J.J. Meijer" <jjmeijer88@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	meijjaa <jjmeijer88@gmail.com>
Subject: [PATCH] Add missing ACPI ID for bcm43241, used in HP Omni10
Date: Thu, 21 Jan 2016 16:45:22 +0100
Message-Id: <1453391122-25226-1-git-send-email-jjmeijer88@gmail.com>
In-Reply-To: <Re: [PATCH] Another ACPI ID for bcm43241>
References: <Re: [PATCH] Another ACPI ID for bcm43241>
List-ID: <linux-bluetooth.vger.kernel.org>

From: meijjaa <jjmeijer88@gmail.com>

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
