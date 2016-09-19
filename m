Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	akarwar@marvell.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2] Bluetooth: hci_uart: Add Marvell support
Date: Mon, 19 Sep 2016 16:29:27 +0200
Message-Id: <1474295367-13208-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces support for Marvell Bluetooth controller over
UART (8897 for now). In order to send the final firmware at full speed,
a helper firmware is firstly sent. Firmware download is driven by the
controller which sends request firmware packets (including expected
size).

This driver is a global rework of the one proposed by
Amitkumar Karwar <akarwar@marvell.com>.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Remove comma from copyright fields
     Use enum instead of defines for mrvl states
     Use separate queue for raw data packets
     Use distinct recv functions for fw_req & chip_ver
     Remove fixed_data, not used anymore in upstream candidate ver
     Change protocol name to Marvell

 drivers/bluetooth/Kconfig     |  11 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_mrvl.c  | 387 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h  |   8 +-
 5 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_mrvl.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 43e9f93..3cc9bff 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -180,6 +180,17 @@ config BT_HCIUART_AG6XX
 
 	  Say Y here to compile support for Intel AG6XX protocol.
 
+config BT_HCIUART_MRVL
+	bool "Marvell protocol support"
+	depends on BT_HCIUART
+	select BT_HCIUART_H4
+	help
+	  Marvell is serial protocol for communication between Bluetooth
+	  device and host. This protocol is required for most Marvell Bluetooth
+	  devices with UART interface.
+
+	  Say Y here to compile support for HCI MRVL protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 3e92cfe..b1fc29a 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -38,6 +38,7 @@ hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
 hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
+hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dda9739..9a3aab6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -810,6 +810,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_AG6XX
 	ag6xx_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_MRVL
+	mrvl_init();
+#endif
 
 	return 0;
 }
@@ -845,6 +848,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_AG6XX
 	ag6xx_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_MRVL
+	mrvl_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	err = tty_unregister_ldisc(N_HCI);
diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
new file mode 100644
index 0000000..bbc4b39
--- /dev/null
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -0,0 +1,387 @@
+/*
+ *
+ *  Bluetooth HCI UART driver for marvell devices
+ *
+ *  Copyright (C) 2016  Marvell International Ltd.
+ *  Copyright (C) 2016  Intel Corporation
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
+
+#define HCI_FW_REQ_PKT 0xA5
+#define HCI_CHIP_VER_PKT 0xAA
+
+#define MRVL_ACK 0x5A
+#define MRVL_NAK 0xBF
+#define MRVL_RAW_DATA 0x1F
+
+enum {
+	STATE_CHIP_VER_PENDING,
+	STATE_FW_REQ_PENDING,
+};
+
+struct mrvl_data {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	struct sk_buff_head rawq;
+	unsigned long flags;
+	unsigned int tx_len;
+	u8 id, rev;
+};
+
+struct hci_mrvl_pkt {
+	__le16 lhs;
+	__le16 rhs;
+} __packed;
+#define HCI_MRVL_PKT_SIZE 4
+
+static int mrvl_open(struct hci_uart *hu)
+{
+	struct mrvl_data *mrvl;
+
+	BT_DBG("hu %p", hu);
+
+	mrvl = kzalloc(sizeof(*mrvl), GFP_KERNEL);
+	if (!mrvl)
+		return -ENOMEM;
+
+	skb_queue_head_init(&mrvl->txq);
+	skb_queue_head_init(&mrvl->rawq);
+
+	set_bit(STATE_CHIP_VER_PENDING, &mrvl->flags);
+
+	hu->priv = mrvl;
+	return 0;
+}
+
+static int mrvl_close(struct hci_uart *hu)
+{
+	struct mrvl_data *mrvl = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&mrvl->txq);
+	skb_queue_purge(&mrvl->rawq);
+	kfree_skb(mrvl->rx_skb);
+	kfree(mrvl);
+
+	hu->priv = NULL;
+	return 0;
+}
+
+static int mrvl_flush(struct hci_uart *hu)
+{
+	struct mrvl_data *mrvl = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&mrvl->txq);
+	skb_queue_purge(&mrvl->rawq);
+
+	return 0;
+}
+
+static struct sk_buff *mrvl_dequeue(struct hci_uart *hu)
+{
+	struct mrvl_data *mrvl = hu->priv;
+	struct sk_buff *skb;
+
+	skb = skb_dequeue(&mrvl->txq);
+	if (!skb) {
+		/* Any raw data ? */
+		skb = skb_dequeue(&mrvl->rawq);
+	} else {
+		/* Prepend skb with frame type */
+		memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	}
+
+	return skb;
+}
+
+static int mrvl_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct mrvl_data *mrvl = hu->priv;
+
+	skb_queue_tail(&mrvl->txq, skb);
+	return 0;
+}
+
+static void mrvl_send_ack(struct hci_uart *hu, unsigned char type)
+{
+	struct mrvl_data *mrvl = hu->priv;
+	struct sk_buff *skb;
+
+	/* No H4 payload, only 1 byte header */
+	skb = bt_skb_alloc(0, GFP_ATOMIC);
+	if (!skb) {
+		bt_dev_err(hu->hdev, "Unable to alloc ack/nak packet");
+		return;
+	}
+	hci_skb_pkt_type(skb) = type;
+
+	skb_queue_tail(&mrvl->txq, skb);
+	hci_uart_tx_wakeup(hu);
+}
+
+static int mrvl_recv_fw_req(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_mrvl_pkt *pkt = (void *)skb->data;
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct mrvl_data *mrvl = hu->priv;
+	int ret = 0;
+
+	if ((pkt->lhs ^ pkt->rhs) != 0xffff) {
+		bt_dev_err(hdev, "Corrupted mrvl header");
+		mrvl_send_ack(hu, MRVL_NAK);
+		ret = -EINVAL;
+		goto done;
+	}
+	mrvl_send_ack(hu, MRVL_ACK);
+
+	if (!test_bit(STATE_FW_REQ_PENDING, &mrvl->flags)) {
+		bt_dev_err(hdev, "Received unexpected firmware request");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	mrvl->tx_len = le16_to_cpu(pkt->lhs);
+
+	clear_bit(STATE_FW_REQ_PENDING, &mrvl->flags);
+	smp_mb__after_atomic();
+	wake_up_bit(&mrvl->flags, STATE_FW_REQ_PENDING);
+
+done:
+	kfree_skb(skb);
+	return ret;
+}
+
+static int mrvl_recv_chip_ver(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_mrvl_pkt *pkt = (void *)skb->data;
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct mrvl_data *mrvl = hu->priv;
+	u16 version = le16_to_cpu(pkt->lhs);
+	int ret = 0;
+
+	if ((pkt->lhs ^ pkt->rhs) != 0xffff) {
+		bt_dev_err(hdev, "Corrupted mrvl header");
+		mrvl_send_ack(hu, MRVL_NAK);
+		ret = -EINVAL;
+		goto done;
+	}
+	mrvl_send_ack(hu, MRVL_ACK);
+
+	if (!test_bit(STATE_CHIP_VER_PENDING, &mrvl->flags)) {
+		bt_dev_err(hdev, "Received unexpected chip version");
+		goto done;
+	}
+
+	mrvl->id = version;
+	mrvl->rev = version >> 8;
+
+	bt_dev_info(hdev, "Controller id = %x, rev = %x", mrvl->id, mrvl->rev);
+
+	clear_bit(STATE_CHIP_VER_PENDING, &mrvl->flags);
+	smp_mb__after_atomic();
+	wake_up_bit(&mrvl->flags, STATE_CHIP_VER_PENDING);
+
+done:
+	kfree_skb(skb);
+	return ret;
+}
+
+#define HCI_RECV_CHIP_VER \
+	.type = HCI_CHIP_VER_PKT, \
+	.hlen = HCI_MRVL_PKT_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = HCI_MRVL_PKT_SIZE
+
+#define HCI_RECV_FW_REQ \
+	.type = HCI_FW_REQ_PKT, \
+	.hlen = HCI_MRVL_PKT_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = HCI_MRVL_PKT_SIZE
+
+static const struct h4_recv_pkt mrvl_recv_pkts[] = {
+	{ H4_RECV_ACL,       .recv = hci_recv_frame     },
+	{ H4_RECV_SCO,       .recv = hci_recv_frame     },
+	{ H4_RECV_EVENT,     .recv = hci_recv_frame     },
+	{ HCI_RECV_FW_REQ,   .recv = mrvl_recv_fw_req   },
+	{ HCI_RECV_CHIP_VER, .recv = mrvl_recv_chip_ver },
+};
+
+static int mrvl_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct mrvl_data *mrvl = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	mrvl->rx_skb = h4_recv_buf(hu->hdev, mrvl->rx_skb, data, count,
+				    mrvl_recv_pkts,
+				    ARRAY_SIZE(mrvl_recv_pkts));
+	if (IS_ERR(mrvl->rx_skb)) {
+		int err = PTR_ERR(mrvl->rx_skb);
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
+		mrvl->rx_skb = NULL;
+		return err;
+	}
+
+	return count;
+}
+
+static int mrvl_load_firmware(struct hci_dev *hdev, const char *name)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct mrvl_data *mrvl = hu->priv;
+	const struct firmware *fw = NULL;
+	const u8 *fw_ptr, *fw_max;
+	int err;
+
+	err = request_firmware(&fw, name, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load firmware file %s", name);
+		return err;
+	}
+
+	fw_ptr = fw->data;
+	fw_max = fw->data + fw->size;
+
+	bt_dev_info(hdev, "Loading %s", name);
+
+	set_bit(STATE_FW_REQ_PENDING, &mrvl->flags);
+
+	while (fw_ptr <= fw_max) {
+		struct sk_buff *skb;
+
+		/* Controller drives the firmware load by sending firmware
+		 * request packets containing the expected fragment size.
+		 */
+		err = wait_on_bit_timeout(&mrvl->flags, STATE_FW_REQ_PENDING,
+					  TASK_INTERRUPTIBLE,
+					  msecs_to_jiffies(2000));
+		if (err == 1) {
+			bt_dev_err(hdev, "Firmware load interrupted");
+			err = -EINTR;
+			break;
+		} else if (err) {
+			bt_dev_err(hdev, "Firmware request timeout");
+			err = -ETIMEDOUT;
+			break;
+		}
+
+		bt_dev_dbg(hdev, "Firmware request, expecting %d bytes",
+			   mrvl->tx_len);
+
+		if (fw_ptr == fw_max) {
+			/* Controller requests a null size once firmware is
+			 * fully loaded. If controller expects more data, there
+			 * is an issue.
+			 */
+			if (!mrvl->tx_len) {
+				bt_dev_info(hdev, "Firmware loading complete");
+			} else {
+				bt_dev_err(hdev, "Firmware loading failure");
+				err = -EINVAL;
+			}
+			break;
+		}
+
+		if (fw_ptr + mrvl->tx_len > fw_max) {
+			mrvl->tx_len = fw_max - fw_ptr;
+			bt_dev_dbg(hdev, "Adjusting tx_len to %d",
+				   mrvl->tx_len);
+		}
+
+		skb = bt_skb_alloc(mrvl->tx_len, GFP_KERNEL);
+		if (!skb) {
+			bt_dev_err(hdev, "Failed to alloc mem for FW packet");
+			err = -ENOMEM;
+			break;
+		}
+		bt_cb(skb)->pkt_type = MRVL_RAW_DATA;
+
+		memcpy(skb_put(skb, mrvl->tx_len), fw_ptr, mrvl->tx_len);
+		fw_ptr += mrvl->tx_len;
+
+		set_bit(STATE_FW_REQ_PENDING, &mrvl->flags);
+
+		skb_queue_tail(&mrvl->rawq, skb);
+		hci_uart_tx_wakeup(hu);
+	}
+
+	release_firmware(fw);
+	return err;
+}
+
+static int mrvl_setup(struct hci_uart *hu)
+{
+	int err;
+
+	hci_uart_set_flow_control(hu, true);
+
+	err = mrvl_load_firmware(hu->hdev, "mrvl/helper_uart_3000000.bin");
+	if (err) {
+		bt_dev_err(hu->hdev, "Unable to download firmware helper");
+		return -EINVAL;
+	}
+
+	hci_uart_set_baudrate(hu, 3000000);
+	hci_uart_set_flow_control(hu, false);
+
+	err = mrvl_load_firmware(hu->hdev, "mrvl/uart8897_bt.bin");
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct hci_uart_proto mrvl_proto = {
+	.id		= HCI_UART_MRVL,
+	.name		= "Marvell",
+	.init_speed	= 115200,
+	.open		= mrvl_open,
+	.close		= mrvl_close,
+	.flush		= mrvl_flush,
+	.setup		= mrvl_setup,
+	.recv		= mrvl_recv,
+	.enqueue	= mrvl_enqueue,
+	.dequeue	= mrvl_dequeue,
+};
+
+int __init mrvl_init(void)
+{
+	return hci_uart_register_proto(&mrvl_proto);
+}
+
+int __exit mrvl_deinit(void)
+{
+	return hci_uart_unregister_proto(&mrvl_proto);
+}
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 22b7c58..0701395 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	11
+#define HCI_UART_MAX_PROTO	12
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -48,6 +48,7 @@
 #define HCI_UART_QCA	8
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
+#define HCI_UART_MRVL	11
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -190,3 +191,8 @@ int qca_deinit(void);
 int ag6xx_init(void);
 int ag6xx_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_MRVL
+int mrvl_init(void);
+int mrvl_deinit(void);
+#endif
-- 
1.9.1
