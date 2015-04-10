Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Export patchram download as separate function
Date: Fri, 10 Apr 2015 14:02:20 -0700
Message-Id: <1428699740-32324-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This isolates the Broadcom patchram download procedure as separate
function so that it can be easily used from USB and UART based drivers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 148 +++++++++++++++++++++++++---------------------
 drivers/bluetooth/btbcm.h |   6 ++
 2 files changed, 85 insertions(+), 69 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d0741f3ed7ec..4bba86677adc 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -95,6 +95,78 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
+{
+	const struct hci_command_hdr *cmd;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	struct sk_buff *skb;
+	u16 opcode;
+	int err;
+
+	err = request_firmware(&fw, firmware, &hdev->dev);
+	if (err < 0) {
+		BT_INFO("%s: BCM: Patch %s not found", hdev->name, firmware);
+		return err;
+	}
+
+	/* Start Download */
+	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Download Minidrv command failed (%d)",
+		       hdev->name, err);
+		goto done;
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
+			BT_ERR("%s: BCM: Patch %s is corrupted", hdev->name,
+			       firmware);
+			err = -EINVAL;
+			goto done;
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
+			BT_ERR("%s: BCM: Patch command %04x failed (%d)",
+			       hdev->name, opcode, err);
+			goto done;
+		}
+		kfree_skb(skb);
+	}
+
+	/* 250 msec delay after Launch Ram completes */
+	msleep(250);
+
+done:
+	release_firmware(fw);
+	return err;
+}
+EXPORT_SYMBOL(btbcm_patchram);
+
 static int btbcm_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -198,12 +270,8 @@ static const struct {
 
 int btbcm_setup_patchram(struct hci_dev *hdev)
 {
-	const struct hci_command_hdr *cmd;
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	size_t fw_size;
 	char fw_name[64];
-	u16 opcode, subver, rev, pid, vid;
+	u16 subver, rev, pid, vid;
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
@@ -273,74 +341,19 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
-	err = request_firmware(&fw, fw_name, &hdev->dev);
-	if (err < 0) {
-		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
+	err = btbcm_patchram(hdev, fw_name);
+	if (err == -ENOENT)
 		return 0;
-	}
-
-	/* Start Download */
-	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		BT_ERR("%s: BCM: Download Minidrv command failed (%d)",
-		       hdev->name, err);
-		goto reset;
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
-		const u8 *cmd_param;
-
-		cmd = (struct hci_command_hdr *)fw_ptr;
-		fw_ptr += sizeof(*cmd);
-		fw_size -= sizeof(*cmd);
-
-		if (fw_size < cmd->plen) {
-			BT_ERR("%s: BCM: patch %s is corrupted", hdev->name,
-			       fw_name);
-			err = -EINVAL;
-			goto reset;
-		}
 
-		cmd_param = fw_ptr;
-		fw_ptr += cmd->plen;
-		fw_size -= cmd->plen;
-
-		opcode = le16_to_cpu(cmd->opcode);
-
-		skb = __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_param,
-				     HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-			BT_ERR("%s: BCM: patch command %04x failed (%d)",
-			       hdev->name, opcode, err);
-			goto reset;
-		}
-		kfree_skb(skb);
-	}
-
-	/* 250 msec delay after Launch Ram completes */
-	msleep(250);
-
-reset:
 	/* Reset */
 	err = btbcm_reset(hdev);
 	if (err)
-		goto done;
+		return err;
 
 	/* Read Local Version Info */
 	skb = btbcm_read_local_version(hdev);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		goto done;
-	}
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	ver = (struct hci_rp_read_local_version *)skb->data;
 	rev = le16_to_cpu(ver->hci_rev);
@@ -355,10 +368,7 @@ reset:
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
-done:
-	release_firmware(fw);
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
 
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 34268ae3eb46..eb6ab5f9483d 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -25,6 +25,7 @@
 
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+int btbcm_patchram(struct hci_dev *hdev, const char *firmware);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -41,6 +42,11 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+static inline int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	return 0;
-- 
2.1.0

