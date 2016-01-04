Return-Path: <heikki.krogerus@linux.intel.com>
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_bcm: new ACPI IDs
Date: Mon,  4 Jan 2016 14:23:22 +0200
Message-Id: <1451910202-42401-3-git-send-email-heikki.krogerus@linux.intel.com>
In-Reply-To: <1451910202-42401-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <1451910202-42401-1-git-send-email-heikki.krogerus@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

These are used at least by Acer with BCM43241.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index abf13a7..5f3de18 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -816,11 +816,14 @@ static const struct hci_uart_proto bcm_proto = {
 static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E1A", 0 },
 	{ "BCM2E39", 0 },
+	{ "BCM2E3A", 0 },
 	{ "BCM2E3D", 0 },
+	{ "BCM2E3F", 0 },
 	{ "BCM2E40", 0 },
 	{ "BCM2E64", 0 },
 	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
+	{ "BCM2E7B", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
-- 
2.6.4
