Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: btbcm: Stop using upper nibble of rev to chose between uart/USB paths
Date: Fri, 20 Apr 2018 14:44:02 +0200
Message-Id: <20180420124407.19712-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btbcm_setup_patchram() was using the upper nibble of the revision code to
determine if we are dealing with an uart or USB connected bcm-bt device,
but just as btbcm_initialize() has started accepting 1 and 2 as uart
connected devices, I've now encountered an USB connected device (0a5c:216c)
which has 0 in the upper nibble. So it seems that the upper nibble is not
really a reliable indicator of the bus type.

Instead check hdev->bus which does give us a reliable indication. This
fixes the patchram code trying to load the patchram by the fallback BCM.hcd
filename, now it correctly requests BCM43142A0-0a5c-216c.hcd.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 6659f113042c..f44ddc0a6b25 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -465,9 +465,11 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	if (err)
 		return err;
 
-	switch ((rev & 0xf000) >> 12) {
-	case 0:
-	case 3:
+	/* Upper nibble of rev should be between 0 and 3? */
+	if (((rev & 0xf000) >> 12) > 3)
+		return 0;
+
+	if (hdev->bus != HCI_USB) {
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
 				hw_name = bcm_uart_subver_table[i].name;
@@ -477,9 +479,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 
 		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
 			 hw_name ? : "BCM");
-		break;
-	case 1:
-	case 2:
+	} else {
 		/* Read USB Product Info */
 		skb = btbcm_read_usb_product(hdev);
 		if (IS_ERR(skb))
@@ -498,9 +498,6 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 
 		snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
 			 hw_name ? : "BCM", vid, pid);
-		break;
-	default:
-		return 0;
 	}
 
 	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-- 
2.17.0
