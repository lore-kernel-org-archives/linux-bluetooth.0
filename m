Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH 4/5] Broadcom Bluetooth protocol UART support
Date: Wed, 3 Jun 2015 17:01:43 -0400
Message-ID: <1433365304-16707-5-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Merge of the Broadcom logic into the Intel's btbcm implementation.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/btbcm.c | 142 ++++++++++++++++++++++++++++++++++++----------
 drivers/bluetooth/btbcm.h |  21 ++++++-
 2 files changed, 132 insertions(+), 31 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 728fce3..e1d5ad0 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -3,6 +3,7 @@
  *  Bluetooth support for Broadcom devices
  *
  *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015  Broadcom Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -32,7 +33,8 @@
 
 #define VERSION "0.1"
 
-#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00} })
+#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43} })
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -43,6 +45,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		BT_ERR("%s: BCM: Reading device address failed (%d)",
 		       hdev->name, err);
 		return err;
@@ -56,10 +59,11 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
 
-	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
-	 * with no configured address.
+	/* Check if the address indicates a controller with no configured
+	 * address.
 	 */
-	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0)) {
+	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3)) {
 		BT_INFO("%s: BCM: Using default device address (%pMR)",
 			hdev->name, &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
@@ -89,21 +93,14 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
-int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
+int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
-	const struct firmware *fw;
 	const u8 *fw_ptr;
 	size_t fw_size;
 	struct sk_buff *skb;
 	u16 opcode;
-	int err;
-
-	err = request_firmware(&fw, firmware, &hdev->dev);
-	if (err < 0) {
-		BT_INFO("%s: BCM: Patch %s not found", hdev->name, firmware);
-		return err;
-	}
+	int err = 0;
 
 	/* Start Download */
 	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
@@ -129,8 +126,7 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
 		fw_size -= sizeof(*cmd);
 
 		if (fw_size < cmd->plen) {
-			BT_ERR("%s: BCM: Patch %s is corrupted", hdev->name,
-			       firmware);
+			BT_ERR("%s: BCM: Patch is corrupted", hdev->name);
 			err = -EINVAL;
 			goto done;
 		}
@@ -156,7 +152,6 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
 	msleep(250);
 
 done:
-	release_firmware(fw);
 	return err;
 }
 EXPORT_SYMBOL(btbcm_patchram);
@@ -168,6 +163,7 @@ static int btbcm_reset(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		BT_ERR("%s: BCM: Reset failed (%d)", hdev->name, err);
 		return err;
 	}
@@ -242,9 +238,101 @@ static const struct {
 	const char *name;
 } bcm_uart_subver_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x610c, "BCM4354_003.001.012.0306.0659"}, /* 003.001.012 */
 	{ }
 };
 
+int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
+{
+	u16 subver, rev;
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
+	switch ((rev & 0xf000) >> 12) {
+	case 0:
+	case 1:
+	case 3:
+		for (i = 0; bcm_uart_subver_table[i].name; i++) {
+			if (subver == bcm_uart_subver_table[i].subver) {
+				hw_name = bcm_uart_subver_table[i].name;
+				break;
+			}
+		}
+
+		snprintf(fw_name, len, "brcm/%s.hcd", hw_name ? : "BCM");
+		break;
+	default:
+		return 0;
+	}
+
+	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_initialize);
+
+int btbcm_finalize(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+	u16 subver, rev;
+	int err;
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
+	BT_INFO("%s: BCM (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		(subver & 0x7000) >> 13, (subver & 0x1f00) >> 8,
+		(subver & 0x00ff), rev & 0x0fff);
+
+	btbcm_check_bdaddr(hdev);
+
+	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_finalize);
+
 static const struct {
 	u16 subver;
 	const char *name;
@@ -265,6 +353,7 @@ static const struct {
 int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	char fw_name[64];
+	const struct firmware *fw;
 	u16 subver, rev, pid, vid;
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
@@ -295,17 +384,6 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	kfree_skb(skb);
 
 	switch ((rev & 0xf000) >> 12) {
-	case 0:
-		for (i = 0; bcm_uart_subver_table[i].name; i++) {
-			if (subver == bcm_uart_subver_table[i].subver) {
-				hw_name = bcm_uart_subver_table[i].name;
-				break;
-			}
-		}
-
-		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
-			 hw_name ? : "BCM");
-		break;
 	case 1:
 	case 2:
 		/* Read USB Product Info */
@@ -335,9 +413,15 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
-	err = btbcm_patchram(hdev, fw_name);
-	if (err == -ENOENT)
+	err = request_firmware(&fw, fw_name, &hdev->dev);
+	if (err < 0) {
+		BT_INFO("%s: BCM: Patch %s not found", hdev->name, fw_name);
 		return 0;
+	}
+
+	btbcm_patchram(hdev, fw);
+
+	release_firmware(fw);
 
 	/* Reset */
 	err = btbcm_reset(hdev);
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index eb6ab5f..32599be 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -21,15 +21,20 @@
  *
  */
 
+#include <linux/firmware.h>
+
 #if IS_ENABLED(CONFIG_BT_BCM)
 
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-int btbcm_patchram(struct hci_dev *hdev, const char *firmware);
+int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
+int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len);
+int btbcm_finalize(struct hci_dev *hdev);
+
 #else
 
 static inline int btbcm_check_bdaddr(struct hci_dev *hdev)
@@ -42,7 +47,8 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
-static inline int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
+static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware
+	*fw)
 {
 	return -EOPNOTSUPP;
 }
@@ -57,4 +63,15 @@ static inline int btbcm_setup_apple(struct hci_dev *hdev)
 	return 0;
 }
 
+static inline int btbcm_initialize(struct hci_dev *hdev, char *fw_name,
+				   size_t len)
+{
+	return 0;
+}
+
+static inline int btbcm_finalize(struct hci_dev *hdev)
+{
+	return 0;
+}
+
 #endif
-- 
1.9.1

