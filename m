Return-Path: <heikki.krogerus@linux.intel.com>
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_bcm/rfkill-gpio: move all Broadcom ACPI IDs to BCM HCI driver
Date: Mon,  4 Jan 2016 14:23:21 +0200
Message-Id: <1451910202-42401-2-git-send-email-heikki.krogerus@linux.intel.com>
In-Reply-To: <1451910202-42401-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <1451910202-42401-1-git-send-email-heikki.krogerus@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The IDs should all be for Broadcom BCM43241 module, and
hci_bcm is now the proper driver for them. This removes one
of two different ways of handling PM with the module.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/bluetooth/hci_bcm.c | 4 ++++
 net/rfkill/rfkill-gpio.c    | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 5c7c696..abf13a7 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -814,7 +814,11 @@ static const struct hci_uart_proto bcm_proto = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bcm_acpi_match[] = {
+	{ "BCM2E1A", 0 },
 	{ "BCM2E39", 0 },
+	{ "BCM2E3D", 0 },
+	{ "BCM2E40", 0 },
+	{ "BCM2E64", 0 },
 	{ "BCM2E65", 0 },
 	{ "BCM2E67", 0 },
 	{ },
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 9312722..4b1e3f3 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -163,10 +163,6 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rfkill_acpi_match[] = {
-	{ "BCM2E1A", RFKILL_TYPE_BLUETOOTH },
-	{ "BCM2E3D", RFKILL_TYPE_BLUETOOTH },
-	{ "BCM2E40", RFKILL_TYPE_BLUETOOTH },
-	{ "BCM2E64", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM4752", RFKILL_TYPE_GPS },
 	{ "LNV4752", RFKILL_TYPE_GPS },
 	{ },
-- 
2.6.4
