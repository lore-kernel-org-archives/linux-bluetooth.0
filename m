Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use matching names for Broadcom firmware files
Date: Sat, 14 Feb 2015 23:08:47 -0800
Message-Id: <1423984127-16749-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Broadcom firmware files are named with firmware version information
encoded into lmp_subver field. So BCM20702B0_002.001.014.0527.0607.hex
would be represented by 0x410e. To allow for an easier decoding of the
actual firmware names, provide an internal table that does the mapping
and request the firmware file by name.

Bluetooth: hci0: BCM20702B0 (002.001.014) build 0607

Now the complicated encoding of lmp_subver will be decoded and turned
into the name and firmware version information from the firmware files.

The previous attempt of using udev->product failed badly since it never
contains any matching entry to the actual hardware or firmware files
distributed by Broadcom in their Windows drivers. It is even worse since
it can change depending on if the internal bootstrapping happened before
the USB bus enumeration or after. This caused many race conditions.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 75 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0f4c43652d71..3ca2e1bf7bfa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2366,6 +2366,23 @@ static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
 	return 0;
 }
 
+static const struct {
+	u16 subver;
+	const char *name;
+} bcm_subver_table[] = {
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
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 
 static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
@@ -2378,29 +2395,20 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 	size_t fw_size;
 	const struct hci_command_hdr *cmd;
 	const u8 *cmd_param;
-	u16 opcode;
+	u16 opcode, subver, rev;
+	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
 	struct hci_rp_read_bd_addr *bda;
 	long ret;
-
-	snprintf(fw_name, sizeof(fw_name), "brcm/%s-%04x-%04x.hcd",
-		 udev->product ? udev->product : "BCM",
-		 le16_to_cpu(udev->descriptor.idVendor),
-		 le16_to_cpu(udev->descriptor.idProduct));
-
-	ret = request_firmware(&fw, fw_name, &hdev->dev);
-	if (ret < 0) {
-		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
-		return 0;
-	}
+	int i;
 
 	/* Reset */
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
-		goto done;
+		return ret;
 	}
 	kfree_skb(skb);
 
@@ -2411,23 +2419,43 @@ static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
 		       hdev->name, ret);
-		goto done;
+		return ret;
 	}
 
 	if (skb->len != sizeof(*ver)) {
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
 		       hdev->name);
 		kfree_skb(skb);
-		ret = -EIO;
-		goto done;
+		return -EIO;
 	}
 
 	ver = (struct hci_rp_read_local_version *)skb->data;
-	BT_INFO("%s: BCM: patching hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
-		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
-		ver->lmp_ver, ver->lmp_subver);
+	rev = le16_to_cpu(ver->hci_rev);
+	subver = le16_to_cpu(ver->lmp_subver);
 	kfree_skb(skb);
 
+	for (i = 0; bcm_subver_table[i].name; i++) {
+		if (subver == bcm_subver_table[i].subver) {
+			hw_name = bcm_subver_table[i].name;
+			break;
+		}
+	}
+
+	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
+	snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
+		 hw_name ? : "BCM",
+		 le16_to_cpu(udev->descriptor.idVendor),
+		 le16_to_cpu(udev->descriptor.idProduct));
+
+	ret = request_firmware(&fw, fw_name, &hdev->dev);
+	if (ret < 0) {
+		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
+		return 0;
+	}
+
 	/* Start Download */
 	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -2505,11 +2533,14 @@ reset_fw:
 	}
 
 	ver = (struct hci_rp_read_local_version *)skb->data;
-	BT_INFO("%s: BCM: firmware hci_ver=%02x hci_rev=%04x lmp_ver=%02x "
-		"lmp_subver=%04x", hdev->name, ver->hci_ver, ver->hci_rev,
-		ver->lmp_ver, ver->lmp_subver);
+	rev = le16_to_cpu(ver->hci_rev);
+	subver = le16_to_cpu(ver->lmp_subver);
 	kfree_skb(skb);
 
+	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
 	/* Read BD Address */
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
 			     HCI_INIT_TIMEOUT);
-- 
2.1.0

