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
Subject: [PATCH 3/6] Bluetooth: btbcm: Make btbcm_initialize() also work for USB connected devices
Date: Fri, 20 Apr 2018 14:44:04 +0200
Message-Id: <20180420124407.19712-3-hdegoede@redhat.com>
In-Reply-To: <20180420124407.19712-1-hdegoede@redhat.com>
References: <20180420124407.19712-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Make btbcm_initialize() also work for USB connected device,
btbcm_initialize() and btbcm_setup_patchram() are quite similar,
this is a preparation patch for making btbcm_setup_patchram() use
btbcm_initialize() to remove the code duplication.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 72 +++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index e3393bceb1a0..dd243afe32de 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -332,12 +332,27 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ }
 };
 
+static const struct bcm_subver_table bcm_usb_subver_table[] = {
+	{ 0x210b, "BCM43142A0"	},	/* 001.001.011 */
+	{ 0x2112, "BCM4314A0"	},	/* 001.001.018 */
+	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
+	{ 0x2126, "BCM4335A0"	},	/* 001.001.038 */
+	{ 0x220e, "BCM20702A1"	},	/* 001.002.014 */
+	{ 0x230f, "BCM4354A2"	},	/* 001.003.015 */
+	{ 0x4106, "BCM4335B0"	},	/* 002.001.006 */
+	{ 0x410e, "BCM20702B0"	},	/* 002.001.014 */
+	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
+	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
+	{ }
+};
+
 int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 {
-	u16 subver, rev;
+	u16 subver, rev, pid, vid;
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
+	const struct bcm_subver_table *bcm_subver_table;
 	int i, err;
 
 	/* Reset */
@@ -360,22 +375,35 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 	if (err)
 		return err;
 
-	switch ((rev & 0xf000) >> 12) {
-	case 0:
-	case 1:
-	case 2:
-	case 3:
-		for (i = 0; bcm_uart_subver_table[i].name; i++) {
-			if (subver == bcm_uart_subver_table[i].subver) {
-				hw_name = bcm_uart_subver_table[i].name;
-				break;
-			}
+	/* Upper nibble of rev should be between 0 and 3? */
+	if (((rev & 0xf000) >> 12) > 3)
+		return 0;
+
+	bcm_subver_table = (hdev->bus == HCI_USB) ? bcm_usb_subver_table :
+						    bcm_uart_subver_table;
+
+	for (i = 0; bcm_subver_table[i].name; i++) {
+		if (subver == bcm_subver_table[i].subver) {
+			hw_name = bcm_subver_table[i].name;
+			break;
 		}
+	}
 
-		snprintf(fw_name, len, "brcm/%s.hcd", hw_name ? : "BCM");
-		break;
-	default:
-		return 0;
+	if (hdev->bus == HCI_USB) {
+		/* Read USB Product Info */
+		skb = btbcm_read_usb_product(hdev);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		vid = get_unaligned_le16(skb->data + 1);
+		pid = get_unaligned_le16(skb->data + 3);
+		kfree_skb(skb);
+
+		snprintf(fw_name, len, "brcm/%s-%4.4x-%4.4x.hcd",
+			 hw_name ? : "BCM", vid, pid);
+	} else {
+		snprintf(fw_name, len, "brcm/%s.hcd",
+			 hw_name ? : "BCM");
 	}
 
 	bt_dev_info(hdev, "%s (%3.3u.%3.3u.%3.3u) build %4.4u",
@@ -420,20 +448,6 @@ int btbcm_finalize(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btbcm_finalize);
 
-static const struct bcm_subver_table bcm_usb_subver_table[] = {
-	{ 0x210b, "BCM43142A0"	},	/* 001.001.011 */
-	{ 0x2112, "BCM4314A0"	},	/* 001.001.018 */
-	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
-	{ 0x2126, "BCM4335A0"	},	/* 001.001.038 */
-	{ 0x220e, "BCM20702A1"	},	/* 001.002.014 */
-	{ 0x230f, "BCM4354A2"	},	/* 001.003.015 */
-	{ 0x4106, "BCM4335B0"	},	/* 002.001.006 */
-	{ 0x410e, "BCM20702B0"	},	/* 002.001.014 */
-	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
-	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
-	{ }
-};
-
 int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	char fw_name[64];
-- 
2.17.0
