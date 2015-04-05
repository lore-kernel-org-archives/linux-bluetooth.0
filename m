Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btbcm: Add firmware table for UART based devices
Date: Sun,  5 Apr 2015 03:42:02 -0700
Message-Id: <1428230522-10628-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom UART based devices seem to use a little bit different
firmare naming prefix. So add a separate table for these devices.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 64 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 5458865c0f52..6194adf31ff0 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -172,7 +172,15 @@ static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
 static const struct {
 	u16 subver;
 	const char *name;
-} bcm_subver_table[] = {
+} bcm_uart_subver_table[] = {
+	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ }
+};
+
+static const struct {
+	u16 subver;
+	const char *name;
+} bcm_usb_subver_table[] = {
 	{ 0x210b, "BCM43142A0"	},	/* 001.001.011 */
 	{ 0x2112, "BCM4314A0"	},	/* 001.001.018 */
 	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
@@ -222,28 +230,46 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
 	kfree_skb(skb);
 
-	/* Read USB Product Info */
-	skb = btbcm_read_usb_product(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	vid = get_unaligned_le16(skb->data + 1);
-	pid = get_unaligned_le16(skb->data + 3);
-	kfree_skb(skb);
-
-	for (i = 0; bcm_subver_table[i].name; i++) {
-		if (subver == bcm_subver_table[i].subver) {
-			hw_name = bcm_subver_table[i].name;
-			break;
-		}
-	}
-
 	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
-	snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
-		 hw_name ? : "BCM", vid, pid);
+	switch ((rev & 0xf000) >> 12) {
+	case 0:
+		for (i = 0; bcm_uart_subver_table[i].name; i++) {
+			if (subver == bcm_uart_subver_table[i].subver) {
+				hw_name = bcm_uart_subver_table[i].name;
+				break;
+			}
+		}
+
+		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
+			 hw_name ? : "BCM");
+		break;
+	case 1:
+	case 2:
+		/* Read USB Product Info */
+		skb = btbcm_read_usb_product(hdev);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		vid = get_unaligned_le16(skb->data + 1);
+		pid = get_unaligned_le16(skb->data + 3);
+		kfree_skb(skb);
+
+		for (i = 0; bcm_usb_subver_table[i].name; i++) {
+			if (subver == bcm_usb_subver_table[i].subver) {
+				hw_name = bcm_usb_subver_table[i].name;
+				break;
+			}
+		}
+
+		snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
+			 hw_name ? : "BCM", vid, pid);
+		break;
+	default:
+		return 0;
+	}
 
 	err = request_firmware(&fw, fw_name, &hdev->dev);
 	if (err < 0) {
-- 
2.1.0

