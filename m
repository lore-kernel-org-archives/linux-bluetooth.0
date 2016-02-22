Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2] Bluetooth: hci_uart: Add Intel/AG6xx support
Date: Mon, 22 Feb 2016 10:48:03 +0100
Message-Id: <1456134483-29815-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This driver implements support for iBT2.1 Bluetooth controller embedded
in the AG620 communication combo. The controller needs to be configured
with bddata and can be patched with a binary patch file (pbn).
These operations are performed in manufacturing mode.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Add PBN file description
     Convert le PBN addr and plen before usage
     Remove firmware fallback, we need full hw/fw ids

 drivers/bluetooth/Kconfig     |  11 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ag6xx.c | 326 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_uart.h  |   8 +-
 5 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_ag6xx.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index ec6af15..cf50fd2 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -169,6 +169,17 @@ config BT_HCIUART_QCA
 
 	  Say Y here to compile support for QCA protocol.
 
+config BT_HCIUART_AG6XX
+	bool "Intel AG6XX protocol support"
+	depends on BT_HCIUART
+	select BT_HCIUART_H4
+	select BT_INTEL
+	help
+	  The Intel/AG6XX protocol support enables Bluetooth HCI over serial
+	  port interface for Intel ibt 2.1 Bluetooth controllers.
+
+	  Say Y here to compile support for Intel AG6XX protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 07c9cf3..9c18939 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -36,6 +36,7 @@ hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
+hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_ag6xx.c b/drivers/bluetooth/hci_ag6xx.c
new file mode 100644
index 0000000..ea65c2d
--- /dev/null
+++ b/drivers/bluetooth/hci_ag6xx.c
@@ -0,0 +1,326 @@
+/*
+ *
+ *  Bluetooth HCI UART driver for Intel/AG6xx devices
+ *
+ *  Copyright (C) 2016  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/skbuff.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/tty.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+#include "btintel.h"
+
+struct ag6xx_data {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+};
+
+struct pbn_entry {
+	__le32 addr;
+	__le32 plen;
+	__u8 data[0];
+} __packed;
+
+static int ag6xx_open(struct hci_uart *hu)
+{
+	struct ag6xx_data *ag6xx;
+
+	BT_DBG("hu %p", hu);
+
+	ag6xx = kzalloc(sizeof(*ag6xx), GFP_KERNEL);
+	if (!ag6xx)
+		return -ENOMEM;
+
+	skb_queue_head_init(&ag6xx->txq);
+
+	hu->priv = ag6xx;
+	return 0;
+}
+
+static int ag6xx_close(struct hci_uart *hu)
+{
+	struct ag6xx_data *ag6xx = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&ag6xx->txq);
+	kfree_skb(ag6xx->rx_skb);
+	kfree(ag6xx);
+
+	hu->priv = NULL;
+	return 0;
+}
+
+static int ag6xx_flush(struct hci_uart *hu)
+{
+	struct ag6xx_data *ag6xx = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&ag6xx->txq);
+	return 0;
+}
+
+static struct sk_buff *ag6xx_dequeue(struct hci_uart *hu)
+{
+	struct ag6xx_data *ag6xx = hu->priv;
+	struct sk_buff *skb;
+
+	skb = skb_dequeue(&ag6xx->txq);
+	if (!skb)
+		return skb;
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	return skb;
+}
+
+static int ag6xx_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct ag6xx_data *ag6xx = hu->priv;
+
+	skb_queue_tail(&ag6xx->txq, skb);
+	return 0;
+}
+
+static const struct h4_recv_pkt ag6xx_recv_pkts[] = {
+	{ H4_RECV_ACL,    .recv = hci_recv_frame   },
+	{ H4_RECV_SCO,    .recv = hci_recv_frame   },
+	{ H4_RECV_EVENT,  .recv = hci_recv_frame   },
+};
+
+static int ag6xx_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct ag6xx_data *ag6xx = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	ag6xx->rx_skb = h4_recv_buf(hu->hdev, ag6xx->rx_skb, data, count,
+				    ag6xx_recv_pkts,
+				    ARRAY_SIZE(ag6xx_recv_pkts));
+	if (IS_ERR(ag6xx->rx_skb)) {
+		int err = PTR_ERR(ag6xx->rx_skb);
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
+		ag6xx->rx_skb = NULL;
+		return err;
+	}
+
+	return count;
+}
+
+static int intel_mem_write(struct hci_dev *hdev, u32 addr, u32 plen,
+			   const void *data)
+{
+	/* Can write a maximum of 247 bytes per HCI command.
+	 * HCI cmd Header (3), Intel mem write header (6), data (247).
+	 */
+	while (plen > 0) {
+		struct sk_buff *skb;
+		u8 cmd_param[253], fragment_len = (plen > 247) ? 247 : plen;
+		__le32 leaddr = cpu_to_le32(addr);
+
+		memcpy(cmd_param, &leaddr, 4);
+		cmd_param[4] = 0;
+		cmd_param[5] = fragment_len;
+		memcpy(cmd_param + 6, data, fragment_len);
+
+		skb = __hci_cmd_sync(hdev, 0xfc8e, fragment_len + 6, cmd_param,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+		kfree_skb(skb);
+
+		plen -= fragment_len;
+		data += fragment_len;
+		addr += fragment_len;
+	}
+
+	return 0;
+}
+
+static int ag6xx_setup(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct intel_version ver;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	char fwname[64];
+	bool patched = false;
+	int err;
+
+	err = btintel_enter_mfg(hdev);
+	if (err)
+		return err;
+
+	err = btintel_read_version(hdev, &ver);
+	if (err)
+		return err;
+
+	btintel_version_info(hdev, &ver);
+
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver.hw_platform != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform: 0x%X",
+			   ver.hw_platform);
+		return -EINVAL;
+	}
+
+	/* Only the hardware variant iBT 2.1 (AG6XX) is supported by this
+	 * firmware setup method.
+	 */
+	if (ver.hw_variant != 0x0a) {
+		bt_dev_err(hdev, "Unsupported Intel hardware variant: 0x%x",
+			   ver.hw_variant);
+		return -EINVAL;
+	}
+
+	snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bddata",
+		 ver.hw_platform, ver.hw_variant);
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to open Intel bddata file: %s (%d)",
+			   fwname, err);
+		goto patch;
+	}
+	fw_ptr = fw->data;
+
+	bt_dev_info(hdev, "Applying bddata (%s)", fwname);
+
+	skb = __hci_cmd_sync_ev(hdev, 0xfc2f, fw->size, fw->data,
+				HCI_EV_CMD_STATUS, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Applying bddata failed (%ld)", PTR_ERR(skb));
+		release_firmware(fw);
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	release_firmware(fw);
+
+patch:
+	/* If there is no applied patch, fw_patch_num is always 0x00. In other
+	 * cases, current firmware is already patched. No need to patch it.
+	 */
+	if (ver.fw_patch_num) {
+		bt_dev_info(hdev, "Device is already patched. patch num: %02x",
+			    ver.fw_patch_num);
+		patched = true;
+		goto complete;
+	}
+
+	snprintf(fwname, sizeof(fwname),
+		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.pbn",
+		 ver.hw_platform, ver.hw_variant, ver.hw_revision,
+		 ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
+		 ver.fw_build_ww, ver.fw_build_yy);
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to open Intel patch file: %s(%d)",
+			   fwname, err);
+		goto complete;
+	}
+	fw_ptr = fw->data;
+
+	bt_dev_info(hdev, "Patching firmware file (%s)", fwname);
+
+	/* PBN patch file contains a list of binary patches to be applied on top
+	 * of the embedded firmware. Each patch entry header contains the target
+	 * address and patch size.
+	 *
+	 * Patch entry:
+	 * | addr(le) | patch_len(le) | patch_data |
+	 * | 4 Bytes  |    4 Bytes    |   n Bytes  |
+	 *
+	 * PBN file is terminated by a patch entry whose address is 0xffffffff.
+	 */
+	while (fw->size > fw_ptr - fw->data) {
+		struct pbn_entry *pbn = (void *)fw_ptr;
+		u32 addr, plen;
+
+		if (pbn->addr == 0xffffffff) {
+			bt_dev_info(hdev, "Patching complete");
+			patched = true;
+			break;
+		}
+
+		addr = le32_to_cpu(pbn->addr);
+		plen = le32_to_cpu(pbn->plen);
+
+		if (fw->data + fw->size <= pbn->data + plen) {
+			bt_dev_info(hdev, "Invalid patch len (%d)", plen);
+			break;
+		}
+
+		bt_dev_info(hdev, "Patching %td/%zu", (fw_ptr - fw->data),
+			    fw->size);
+
+		err = intel_mem_write(hdev, addr, plen, pbn->data);
+		if (err) {
+			bt_dev_err(hdev, "Patching failed");
+			break;
+		}
+
+		fw_ptr = pbn->data + plen;
+	}
+
+	release_firmware(fw);
+
+complete:
+	/* Exit manufacturing mode and reset */
+	err = btintel_exit_mfg(hdev, true, patched);
+
+	return err;
+}
+
+static const struct hci_uart_proto ag6xx_proto = {
+	.id		= HCI_UART_AG6XX,
+	.name		= "AG6XX",
+	.manufacturer	= 2,
+	.open		= ag6xx_open,
+	.close		= ag6xx_close,
+	.flush		= ag6xx_flush,
+	.setup		= ag6xx_setup,
+	.recv		= ag6xx_recv,
+	.enqueue	= ag6xx_enqueue,
+	.dequeue	= ag6xx_dequeue,
+};
+
+int __init ag6xx_init(void)
+{
+	return hci_uart_register_proto(&ag6xx_proto);
+}
+
+int __exit ag6xx_deinit(void)
+{
+	return hci_uart_unregister_proto(&ag6xx_proto);
+}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 73202624..c00168a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -804,6 +804,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_QCA
 	qca_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_AG6XX
+	ag6xx_init();
+#endif
 
 	return 0;
 }
@@ -836,6 +839,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_QCA
 	qca_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_AG6XX
+	ag6xx_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	err = tty_unregister_ldisc(N_HCI);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 82c92f1..4814ff0 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	9
+#define HCI_UART_MAX_PROTO	10
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -46,6 +46,7 @@
 #define HCI_UART_INTEL	6
 #define HCI_UART_BCM	7
 #define HCI_UART_QCA	8
+#define HCI_UART_AG6XX	9
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -182,3 +183,8 @@ int bcm_deinit(void);
 int qca_init(void);
 int qca_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_AG6XX
+int ag6xx_init(void);
+int ag6xx_deinit(void);
+#endif
-- 
1.9.1

