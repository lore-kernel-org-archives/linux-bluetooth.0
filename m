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
Subject: [PATCH 5/6] Bluetooth: btbcm: Remove duplicate code from btbcm_setup_patchram()
Date: Fri, 20 Apr 2018 14:44:06 +0200
Message-Id: <20180420124407.19712-5-hdegoede@redhat.com>
In-Reply-To: <20180420124407.19712-1-hdegoede@redhat.com>
References: <20180420124407.19712-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btbcm_setup_patchram() starts with initializing the controller (and
getting the firmware filename) and then after loading the firmware,
does a re-init. This almost entirely duplicates the code in
btbcm_initialize(), use that function instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 78 +++------------------------------------
 1 file changed, 5 insertions(+), 73 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index fdcbeb489a2e..d44aa6ff1ed5 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -439,68 +439,14 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	char fw_name[64];
 	const struct firmware *fw;
-	u16 subver, rev, pid, vid;
-	const char *hw_name = NULL;
 	struct sk_buff *skb;
-	struct hci_rp_read_local_version *ver;
-	const struct bcm_subver_table *bcm_subver_table;
-	int i, err;
-
-	/* Reset */
-	err = btbcm_reset(hdev);
-	if (err)
-		return err;
-
-	/* Read Local Version Info */
-	skb = btbcm_read_local_version(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	ver = (struct hci_rp_read_local_version *)skb->data;
-	rev = le16_to_cpu(ver->hci_rev);
-	subver = le16_to_cpu(ver->lmp_subver);
-	kfree_skb(skb);
+	int err;
 
-	/* Read controller information */
-	err = btbcm_read_info(hdev);
+	/* Initialize */
+	err = btbcm_initialize(hdev, fw_name, sizeof(fw_name), false);
 	if (err)
 		return err;
 
-	/* Upper nibble of rev should be between 0 and 3? */
-	if (((rev & 0xf000) >> 12) > 3)
-		return 0;
-
-	bcm_subver_table = (hdev->bus == HCI_USB) ? bcm_usb_subver_table :
-						    bcm_uart_subver_table;
-
-	for (i = 0; bcm_subver_table[i].name; i++) {
-		if (subver == bcm_subver_table[i].subver) {
-			hw_name = bcm_subver_table[i].name;
-			break;
-		}
-	}
-
-	if (hdev->bus == HCI_USB) {
-		/* Read USB Product Info */
-		skb = btbcm_read_usb_product(hdev);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		vid = get_unaligned_le16(skb->data + 1);
-		pid = get_unaligned_le16(skb->data + 3);
-		kfree_skb(skb);
-
-		snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
-			 hw_name ? : "BCM", vid, pid);
-	} else {
-		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
-			 hw_name ? : "BCM");
-	}
-
-	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-		    hw_name ? : "BCM", (subver & 0xe000) >> 13,
-		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
-
 	err = request_firmware(&fw, fw_name, &hdev->dev);
 	if (err < 0) {
 		bt_dev_info(hdev, "BCM: Patch %s not found", fw_name);
@@ -511,25 +457,11 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 
 	release_firmware(fw);
 
-	/* Reset */
-	err = btbcm_reset(hdev);
+	/* Re-initialize */
+	err = btbcm_initialize(hdev, fw_name, sizeof(fw_name), true);
 	if (err)
 		return err;
 
-	/* Read Local Version Info */
-	skb = btbcm_read_local_version(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	ver = (struct hci_rp_read_local_version *)skb->data;
-	rev = le16_to_cpu(ver->hci_rev);
-	subver = le16_to_cpu(ver->lmp_subver);
-	kfree_skb(skb);
-
-	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
-		    hw_name ? : "BCM", (subver & 0xe000) >> 13,
-		    (subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
-
 	/* Read Local Name */
 	skb = btbcm_read_local_name(hdev);
 	if (IS_ERR(skb))
-- 
2.17.0
