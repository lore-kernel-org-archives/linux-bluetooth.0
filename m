Return-Path: <mika.westerberg@linux.intel.com>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Add BCM2E7C ACPI ID
Date: Fri, 29 Jan 2016 16:53:27 +0200
Message-Id: <1454079207-126388-1-git-send-email-mika.westerberg@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Recent macbooks (early 2015) with BCM43241 use this ACPI ID. Add it to the
list of supported devices.

Reported-by: Leif Liddy <leif.liddy@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5f3de181e744..ce00a8045058 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -824,6 +824,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
 	{ "BCM2E7B", 0 },
+	{ "BCM2E7C", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
-- 
2.7.0.rc3
