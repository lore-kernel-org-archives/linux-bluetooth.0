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
Subject: [PATCH 2/6] Bluetooth: btbcm: Factor out common code to determine subversion
Date: Fri, 20 Apr 2018 14:44:03 +0200
Message-Id: <20180420124407.19712-2-hdegoede@redhat.com>
In-Reply-To: <20180420124407.19712-1-hdegoede@redhat.com>
References: <20180420124407.19712-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We are using the same loop in both the UART and USB bus cases, refactor
things a bit to share the loop.

This is mostly meant to improve readability.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 40 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f44ddc0a6b25..e3393bceb1a0 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -315,10 +315,12 @@ static int btbcm_read_info(struct hci_dev *hdev)
 	return 0;
 }
 
-static const struct {
+struct bcm_subver_table {
 	u16 subver;
 	const char *name;
-} bcm_uart_subver_table[] = {
+};
+
+static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
@@ -418,10 +420,7 @@ int btbcm_finalize(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btbcm_finalize);
 
-static const struct {
-	u16 subver;
-	const char *name;
-} bcm_usb_subver_table[] = {
+static const struct bcm_subver_table bcm_usb_subver_table[] = {
 	{ 0x210b, "BCM43142A0"	},	/* 001.001.011 */
 	{ 0x2112, "BCM4314A0"	},	/* 001.001.018 */
 	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
@@ -443,6 +442,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
+	const struct bcm_subver_table *bcm_subver_table;
 	int i, err;
 
 	/* Reset */
@@ -469,17 +469,17 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	if (((rev & 0xf000) >> 12) > 3)
 		return 0;
 
-	if (hdev->bus != HCI_USB) {
-		for (i = 0; bcm_uart_subver_table[i].name; i++) {
-			if (subver == bcm_uart_subver_table[i].subver) {
-				hw_name = bcm_uart_subver_table[i].name;
-				break;
-			}
+	bcm_subver_table = (hdev->bus == HCI_USB) ? bcm_usb_subver_table :
+						    bcm_uart_subver_table;
+
+	for (i = 0; bcm_subver_table[i].name; i++) {
+		if (subver == bcm_subver_table[i].subver) {
+			hw_name = bcm_subver_table[i].name;
+			break;
 		}
+	}
 
-		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
-			 hw_name ? : "BCM");
-	} else {
+	if (hdev->bus == HCI_USB) {
 		/* Read USB Product Info */
 		skb = btbcm_read_usb_product(hdev);
 		if (IS_ERR(skb))
@@ -489,15 +489,11 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		pid = get_unaligned_le16(skb->data + 3);
 		kfree_skb(skb);
 
-		for (i = 0; bcm_usb_subver_table[i].name; i++) {
-			if (subver == bcm_usb_subver_table[i].subver) {
-				hw_name = bcm_usb_subver_table[i].name;
-				break;
-			}
-		}
-
 		snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
 			 hw_name ? : "BCM", vid, pid);
+	} else {
+		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
+			 hw_name ? : "BCM");
 	}
 
 	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-- 
2.17.0
