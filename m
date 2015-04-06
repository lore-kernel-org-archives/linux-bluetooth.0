Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] Bluetooth: btbcm: Add support for Broadcom controller setup
Date: Sun,  5 Apr 2015 22:52:13 -0700
Message-Id: <1428299539-8273-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To unify the controller setup of Broadcom devices between USB and UART
transport, add the patchram download support into the Broadcom module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig |   1 +
 drivers/bluetooth/btbcm.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h |  13 +++
 3 files changed, 272 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 9f68e11c1671..0801649a3b41 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -4,6 +4,7 @@ menu "Bluetooth device drivers"
 
 config BT_BCM
 	tristate
+	select FW_LOADER
 
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 20c744a9a3f1..17565ab610f4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -22,6 +22,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/firmware.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -93,6 +95,262 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+static int btbcm_reset(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Reset failed (%d)", hdev->name, err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static struct sk_buff *btbcm_read_local_version(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: BCM: Reading local version info failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+		BT_ERR("%s: BCM: Local version length mismatch", hdev->name);
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *btbcm_read_verbose_config(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: BCM: Read verbose config info failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != 7) {
+		BT_ERR("%s: BCM: Verbose config length mismatch", hdev->name);
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
+static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc5a, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: BCM: Read USB product info failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return skb;
+	}
+
+	if (skb->len != 5) {
+		BT_ERR("%s: BCM: USB product length mismatch", hdev->name);
+		kfree_skb(skb);
+		return ERR_PTR(-EIO);
+	}
+
+	return skb;
+}
+
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
+int btbcm_setup_patchram(struct hci_dev *hdev)
+{
+	const struct hci_command_hdr *cmd;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	char fw_name[64];
+	u16 opcode, subver, rev, pid, vid;
+	const char *hw_name = NULL;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+	int i, err;
+
+	/* Reset */
+	err = btbcm_reset(hdev);
+	if (err)
+		return err;
+
+	/* Read Local Version Info */
+	skb = btbcm_read_local_version(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ver = (struct hci_rp_read_local_version *)skb->data;
+	rev = le16_to_cpu(ver->hci_rev);
+	subver = le16_to_cpu(ver->lmp_subver);
+	kfree_skb(skb);
+
+	/* Read Verbose Config Version Info */
+	skb = btbcm_read_verbose_config(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
+	kfree_skb(skb);
+
+	/* Read USB Product Info */
+	skb = btbcm_read_usb_product(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	vid = get_unaligned_le16(skb->data + 1);
+	pid = get_unaligned_le16(skb->data + 3);
+	kfree_skb(skb);
+
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
+		 hw_name ? : "BCM", vid, pid);
+
+	err = request_firmware(&fw, fw_name, &hdev->dev);
+	if (err < 0) {
+		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
+		return 0;
+	}
+
+	/* Start Download */
+	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Download Minidrv command failed (%d)",
+		       hdev->name, err);
+		goto reset;
+	}
+	kfree_skb(skb);
+
+	/* 50 msec delay after Download Minidrv completes */
+	msleep(50);
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	while (fw_size >= sizeof(*cmd)) {
+		const u8 *cmd_param;
+
+		cmd = (struct hci_command_hdr *)fw_ptr;
+		fw_ptr += sizeof(*cmd);
+		fw_size -= sizeof(*cmd);
+
+		if (fw_size < cmd->plen) {
+			BT_ERR("%s: BCM: patch %s is corrupted", hdev->name,
+			       fw_name);
+			err = -EINVAL;
+			goto reset;
+		}
+
+		cmd_param = fw_ptr;
+		fw_ptr += cmd->plen;
+		fw_size -= cmd->plen;
+
+		opcode = le16_to_cpu(cmd->opcode);
+
+		skb = __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_param,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			BT_ERR("%s: BCM: patch command %04x failed (%d)",
+			       hdev->name, opcode, err);
+			goto reset;
+		}
+		kfree_skb(skb);
+	}
+
+	/* 250 msec delay after Launch Ram completes */
+	msleep(250);
+
+reset:
+	/* Reset */
+	err = btbcm_reset(hdev);
+	if (err)
+		goto done;
+
+	/* Read Local Version Info */
+	skb = btbcm_read_local_version(hdev);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto done;
+	}
+
+	ver = (struct hci_rp_read_local_version *)skb->data;
+	rev = le16_to_cpu(ver->hci_rev);
+	subver = le16_to_cpu(ver->lmp_subver);
+	kfree_skb(skb);
+
+	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
+	btbcm_check_bdaddr(hdev);
+
+done:
+	release_firmware(fw);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
+
+int btbcm_setup_apple(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Read Verbose Config Version Info */
+	skb = btbcm_read_verbose_config(hdev);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	BT_INFO("%s: BCM: chip id %u build %4.4u", hdev->name, skb->data[1],
+		get_unaligned_le16(skb->data + 5));
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_setup_apple);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Broadcom devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 813f7e7e191d..34268ae3eb46 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -26,6 +26,9 @@
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 
+int btbcm_setup_patchram(struct hci_dev *hdev);
+int btbcm_setup_apple(struct hci_dev *hdev);
+
 #else
 
 static inline int btbcm_check_bdaddr(struct hci_dev *hdev)
@@ -38,4 +41,14 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+static inline int btbcm_setup_patchram(struct hci_dev *hdev)
+{
+	return 0;
+}
+
+static inline int btbcm_setup_apple(struct hci_dev *hdev)
+{
+	return 0;
+}
+
 #endif
-- 
2.1.0

