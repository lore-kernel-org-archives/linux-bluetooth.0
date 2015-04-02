Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5] Bluetooth: hci_uart: Add BCM specific setup function
Date: Thu,  2 Apr 2015 16:37:33 +0200
Message-Id: <1427985456-31536-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BCM specific setup loads firmware.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/Kconfig     |  10 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_bcm.c   | 240 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |   5 +
 drivers/bluetooth/hci_uart.h  |   4 +
 5 files changed, 260 insertions(+)
 create mode 100644 drivers/bluetooth/hci_bcm.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 364f080..59c4eb0 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -94,6 +94,16 @@ config BT_HCIUART_3WIRE
 
 	  Say Y here to compile support for Three-wire UART protocol.
 
+config BT_HCIUART_BCM
+	bool "HCI BCM UART driver"
+	depends on BT_HCIUART_H4
+	help
+	  Bluetooth HCI UART BCM driver.
+	  This driver provides the firmware loading mechanism for the Broadcom
+	  UART based devices.
+
+	  Say Y here to compile support for HCI UART BCM devices.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 9fe8a87..9acbee3 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -29,6 +29,7 @@ hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
 hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
+hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
new file mode 100644
index 0000000..7cec648
--- /dev/null
+++ b/drivers/bluetooth/hci_bcm.c
@@ -0,0 +1,240 @@
+/*
+*  Broadcom Bluetooth vendor functions
+*
+*  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
+*  Copyright (C) 2015, Intel Corporation
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License as published by
+*  the Free Software Foundation; either version 2 of the License, or
+*  (at your option) any later version.
+*/
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/skbuff.h>
+#include <linux/firmware.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+
+static int hci_bcm_reset(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: HCI_OP_RESET failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int hci_bcm_read_local_name(struct hci_uart *hu, char *name, size_t size)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_name *rp;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_NAME failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_name)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_NAME event length mismatch",
+		       hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rp = (struct hci_rp_read_local_name *)skb->data;
+	if (rp->status) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_NAME error status (%02x)",
+		       hdev->name, rp->status);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	strncpy(name, rp->name, size - 1);
+	name[size - 1] = '\0';
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int hci_bcm_read_local_version(struct hci_uart *hu, char *name,
+								size_t size)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *rp;
+	uint16_t ver;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION event length mismatch",
+		       hdev->name);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rp = (struct hci_rp_read_local_version *)skb->data;
+	if (rp->status) {
+		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION error status (%02x)",
+		       hdev->name, rp->status);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	ver = le16_to_cpu(rp->lmp_subver);
+	snprintf(name, size, "%3.3u.%3.3u.%3.3u", (ver & 0x7000) >> 13,
+		 (ver & 0x1f00) >> 8, ver & 0x00ff);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static const struct firmware *hci_bcm_get_fw(struct hci_uart *hu,
+						const char *fwname)
+{
+	struct hci_dev *hdev = hu->hdev;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fwname, &hdev->dev);
+	if (ret < 0) {
+		if (ret == -EINVAL) {
+			BT_ERR("%s: BCM firmware file request failed (%d)",
+			       hdev->name, ret);
+			return NULL;
+		}
+
+		BT_ERR("%s: failed to open BCM firmware file: %s(%d)",
+		       hdev->name, fwname, ret);
+
+		return NULL;
+	}
+
+	BT_INFO("%s: BCM Bluetooth firmware file: %s", hdev->name, fwname);
+
+	return fw;
+}
+
+static int hci_bcm_load_firmware(struct hci_uart *hu, const struct firmware *fw)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	const struct hci_command_hdr *cmd;
+	const u8 *cmd_param;
+	u16 opcode;
+
+	BT_DBG("%s: %p", hdev->name, hu);
+
+	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("%s: failed to write download mode command (%ld)",
+		       hdev->name, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	/* Wait 50ms to let the firmware placed in download mode */
+	msleep(50);
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	while (fw_size >= sizeof(*cmd)) {
+		cmd = (struct hci_command_hdr *)fw_ptr;
+		fw_ptr += sizeof(*cmd);
+		fw_size -= sizeof(*cmd);
+
+		if (fw_size < cmd->plen) {
+			BT_ERR("%s: patch is corrupted", hdev->name);
+			return -EINVAL;
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
+			BT_ERR("%s: patch command %04x failed (%ld)",
+			       hdev->name, opcode, PTR_ERR(skb));
+			return PTR_ERR(skb);
+		}
+		kfree_skb(skb);
+	}
+
+	/* Wait for firmware ready */
+	msleep(2000);
+
+	return 0;
+}
+
+int hci_bcm_setup(struct hci_uart *hu)
+{
+	char name[20];
+	char version[12];
+	char fwname[64];
+	const struct firmware *fw = NULL;
+	int err = 0;
+
+	BT_DBG("%s: %p", hu->hdev->name, hu);
+
+	err = hci_bcm_reset(hu);
+	if (err)
+		goto failed;
+
+	err = hci_bcm_read_local_name(hu, name, sizeof(name));
+	if (err)
+		goto failed;
+
+	err = hci_bcm_read_local_version(hu, version, sizeof(version));
+	if (err)
+		goto failed;
+
+	snprintf(fwname, sizeof(fwname), "brcm/%s_%s.hcd", name, version);
+
+	fw = hci_bcm_get_fw(hu, fwname);
+	if (fw) {
+		err = hci_bcm_load_firmware(hu, fw);
+		if (err)
+			goto failed;
+
+		err = hci_bcm_reset(hu);
+		if (err)
+			goto failed;
+	}
+
+failed:
+	if (fw)
+		release_firmware(fw);
+
+	return err;
+}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index cb7fcc6..e8412f8 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -473,6 +473,11 @@ struct hci_uart_devtype_t {
 };
 
 struct hci_uart_devtype_t devtypes[] = {
+#ifdef CONFIG_BT_HCIUART_BCM
+		/* Broadcom */
+		{ "bcm", hci_bcm_setup},
+#endif
+
 		{ "", 0 }
 };
 
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index bd56409..bf6f0e5 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -121,3 +121,7 @@ int ath_deinit(void);
 int h5_init(void);
 int h5_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_BCM
+int hci_bcm_setup(struct hci_uart *hu);
+#endif
-- 
1.9.1

