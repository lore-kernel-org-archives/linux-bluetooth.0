Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_bcm: Add BCM2E71 ACPI ID
Date: Mon,  4 Apr 2016 11:31:12 +0200
Message-Id: <1459762272-12977-1-git-send-email-loic.poulain@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This ID is used at least by Asus T100-CHI.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index d8881dc..1c97eda 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -825,6 +825,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E64", 0 },
 	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
+	{ "BCM2E71", 0 },
 	{ "BCM2E7B", 0 },
 	{ "BCM2E7C", 0 },
 	{ },
-- 
1.9.1

