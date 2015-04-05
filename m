Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/14] Bluetooth: btusb: Add option for Broadcom protocol support
Date: Sun,  5 Apr 2015 03:04:57 -0700
Message-Id: <1428228299-28415-12-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the generic Broadcom Bluetooth support module, it is possible to
turn support for firmware and patchram download into an optional
feature.

To keep backwards compatibility with previous kernel configurations,
the new option defaults to enabled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig |  12 ++-
 drivers/bluetooth/btusb.c | 211 +---------------------------------------------
 2 files changed, 15 insertions(+), 208 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 01ec06e6e513..daf92930b601 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -13,7 +13,6 @@ config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
 	select BT_INTEL
-	select BT_BCM
 	help
 	  Bluetooth HCI USB driver.
 	  This driver is required if you want to use Bluetooth devices with
@@ -22,6 +21,17 @@ config BT_HCIBTUSB
 	  Say Y here to compile support for Bluetooth USB devices into the
 	  kernel or say M to compile it as module (btusb).
 
+config BT_HCIBTUSB_BCM
+	bool "Broadcom protocol support"
+	depends on BT_HCIBTUSB
+	select BT_BCM
+	default y
+	help
+	  The Broadcom protocol support enables firmware and patchram
+	  download support for Broadcom Bluetooth controllers.
+
+	  Say Y here to compile support for Broadcom protocol.
+
 config BT_HCIBTSDIO
 	tristate "HCI SDIO driver"
 	depends on MMC
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 543992bc0ef2..ff3b5ecbb164 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include <linux/firmware.h>
-#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -2309,210 +2308,6 @@ static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
 	return 0;
 }
 
-static const struct {
-	u16 subver;
-	const char *name;
-} bcm_subver_table[] = {
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
-static int btusb_setup_bcm_patchram(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct usb_device *udev = data->udev;
-	char fw_name[64];
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	size_t fw_size;
-	const struct hci_command_hdr *cmd;
-	const u8 *cmd_param;
-	u16 opcode, subver, rev;
-	const char *hw_name = NULL;
-	struct sk_buff *skb;
-	struct hci_rp_read_local_version *ver;
-	long ret;
-	int i;
-
-	/* Reset */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
-		return ret;
-	}
-	kfree_skb(skb);
-
-	/* Read Local Version Info */
-	skb = btusb_read_local_version(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	ver = (struct hci_rp_read_local_version *)skb->data;
-	rev = le16_to_cpu(ver->hci_rev);
-	subver = le16_to_cpu(ver->lmp_subver);
-	kfree_skb(skb);
-
-	/* Read Verbose Config Version Info */
-	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: BCM: Read Verbose Version failed (%ld)",
-		       hdev->name, ret);
-		return ret;
-	}
-
-	if (skb->len != 7) {
-		BT_ERR("%s: BCM: Read Verbose Version event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
-	kfree_skb(skb);
-
-	for (i = 0; bcm_subver_table[i].name; i++) {
-		if (subver == bcm_subver_table[i].subver) {
-			hw_name = bcm_subver_table[i].name;
-			break;
-		}
-	}
-
-	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
-		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
-
-	snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
-		 hw_name ? : "BCM",
-		 le16_to_cpu(udev->descriptor.idVendor),
-		 le16_to_cpu(udev->descriptor.idProduct));
-
-	ret = request_firmware(&fw, fw_name, &hdev->dev);
-	if (ret < 0) {
-		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
-		return 0;
-	}
-
-	/* Start Download */
-	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: BCM: Download Minidrv command failed (%ld)",
-		       hdev->name, ret);
-		goto reset_fw;
-	}
-	kfree_skb(skb);
-
-	/* 50 msec delay after Download Minidrv completes */
-	msleep(50);
-
-	fw_ptr = fw->data;
-	fw_size = fw->size;
-
-	while (fw_size >= sizeof(*cmd)) {
-		cmd = (struct hci_command_hdr *)fw_ptr;
-		fw_ptr += sizeof(*cmd);
-		fw_size -= sizeof(*cmd);
-
-		if (fw_size < cmd->plen) {
-			BT_ERR("%s: BCM: patch %s is corrupted",
-			       hdev->name, fw_name);
-			ret = -EINVAL;
-			goto reset_fw;
-		}
-
-		cmd_param = fw_ptr;
-		fw_ptr += cmd->plen;
-		fw_size -= cmd->plen;
-
-		opcode = le16_to_cpu(cmd->opcode);
-
-		skb = __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_param,
-				     HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb)) {
-			ret = PTR_ERR(skb);
-			BT_ERR("%s: BCM: patch command %04x failed (%ld)",
-			       hdev->name, opcode, ret);
-			goto reset_fw;
-		}
-		kfree_skb(skb);
-	}
-
-	/* 250 msec delay after Launch Ram completes */
-	msleep(250);
-
-reset_fw:
-	/* Reset */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		BT_ERR("%s: HCI_OP_RESET failed (%ld)", hdev->name, ret);
-		goto done;
-	}
-	kfree_skb(skb);
-
-	/* Read Local Version Info */
-	skb = btusb_read_local_version(hdev);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		goto done;
-	}
-
-	ver = (struct hci_rp_read_local_version *)skb->data;
-	rev = le16_to_cpu(ver->hci_rev);
-	subver = le16_to_cpu(ver->lmp_subver);
-	kfree_skb(skb);
-
-	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
-		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
-
-	btbcm_check_bdaddr(hdev);
-
-done:
-	release_firmware(fw);
-
-	return ret;
-}
-
-static int btusb_setup_bcm_apple(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	int err;
-
-	/* Read Verbose Config Version Info */
-	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		BT_ERR("%s: BCM: Read Verbose Version failed (%d)",
-		       hdev->name, err);
-		return err;
-	}
-
-	if (skb->len != 7) {
-		BT_ERR("%s: BCM: Read Verbose Version event length mismatch",
-		       hdev->name);
-		kfree_skb(skb);
-		return -EIO;
-	}
-
-	BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
-		get_unaligned_le16(skb->data + 5));
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 				    const bdaddr_t *bdaddr)
 {
@@ -2906,16 +2701,18 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
+#ifdef CONFIG_BT_HCIBTUSB_BCM
 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
-		hdev->setup = btusb_setup_bcm_patchram;
+		hdev->setup = btbcm_setup_patchram;
 		hdev->set_bdaddr = btbcm_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_BCM_APPLE) {
-		hdev->setup = btusb_setup_bcm_apple;
+		hdev->setup = btbcm_setup_apple;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
+#endif
 
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
-- 
2.1.0

