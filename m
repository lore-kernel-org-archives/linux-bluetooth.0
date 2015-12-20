Return-Path: <luka.karinja@gmail.com>
From: Luka Karinja <luka.karinja@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	frederic.danis@linux.intel.com,
	Luka Karinja <luka.karinja@gmail.com>
Subject: [PATCH v3] Bluetooth: hci_bcm: Add BCM2E65 ACPI ID
Date: Sun, 20 Dec 2015 13:36:06 +0100
Message-Id: <1450614966-3682-1-git-send-email-luka.karinja@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add BCM2E65 device in acpi_device_id table used on Asus T100TAF.

Signed-off-by: Luka Karinja <luka.karinja@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 3eed35e..5c7c696 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -815,6 +815,7 @@ static const struct hci_uart_proto bcm_proto = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E39", 0 },
+	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
 	{ },
 };
-- 
2.6.4
