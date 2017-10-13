Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH resend 1/3] Bluetooth: btbcm: Add entry for BCM4356A2 UART bluetooth
Date: Fri, 13 Oct 2017 17:54:01 +0200
Message-Id: <20171013155403.27060-2-hdegoede@redhat.com>
In-Reply-To: <20171013155403.27060-1-hdegoede@redhat.com>
References: <20171013155403.27060-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the device ID for the bluetooth chip used in the
Broadcom BCM4356 PCI-E WiFi / UART BT chip.

Successfully tested using Firmware version 0273

The upper nibble of the rev field is 2 on this device, so this commit
also adds handling of 2 to the switch-case done on the upper nibble.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 06e8bed4f5eb..ae1fa390f508 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -328,6 +328,7 @@ static const struct {
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
+	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ }
 };
 
@@ -362,6 +363,7 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
 	case 1:
+	case 2:
 	case 3:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
-- 
2.14.2
