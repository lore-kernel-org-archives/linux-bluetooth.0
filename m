Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Cc: sre@kernel.org, pavel@ucw.cz, pali.rohar@gmail.com
Subject: [PATCH] Bluetooth: hci_uart: Add protocol support for Nokia UART devices
Date: Thu,  9 Apr 2015 12:56:38 -0700
Message-Id: <1428609398-11928-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

WARNING: This driver is not complete. It only contains the H4+ protocol
part and not the serial line or GPIO setup.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |  12 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_nok.c   | 269 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h  |   8 +-
 5 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_nok.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index ed5c2738bea2..efc8115b3bbe 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -135,6 +135,18 @@ config BT_HCIUART_BCM
 
 	  Say Y here to compile support for Broadcom protocol.
 
+config BT_HCIUART_NOK
+	bool "Nokia protocol support"
+	depends on BT_HCIUART
+	select BT_HCIUART_H4
+	select BT_BCM
+	help
+	  The Nokia protocol support enables Bluetooth HCI over serial
+	  port interface for Bluetooth devices in Nokia products. This
+	  is sometimes also referenced H4+ UART protocol.
+
+	  Say Y here to compile support for Nokia protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index dd0d9c40b999..2d748e291629 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -33,6 +33,7 @@ hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
+hci_uart-$(CONFIG_BT_HCIUART_NOK)	+= hci_nok.o
 hci_uart-objs				:= $(hci_uart-y)
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5c9a73f02664..8d9849579866 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -684,6 +684,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_BCM
 	bcm_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_NOK
+	nok_init();
+#endif
 
 	return 0;
 }
@@ -710,6 +713,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_BCM
 	bcm_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_NOK
+	nok_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	err = tty_unregister_ldisc(N_HCI);
diff --git a/drivers/bluetooth/hci_nok.c b/drivers/bluetooth/hci_nok.c
new file mode 100644
index 000000000000..c54f3ba131f1
--- /dev/null
+++ b/drivers/bluetooth/hci_nok.c
@@ -0,0 +1,269 @@
+/*
+ *
+ *  Bluetooth HCI UART driver for Nokia devices
+ *
+ *  Copyright (C) 2015  Intel Corporation
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
+#include <linux/tty.h>
+#include <linux/firmware.h>
+#include <asm/unaligned.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btbcm.h"
+#include "hci_uart.h"
+
+#define NOK_NEG_PKT	0x06
+#define NOK_ALIVE_PKT	0x07
+#define NOK_RADIO_PKT	0x08
+
+#define NOK_NEG_HDR_SIZE	1
+#define NOK_ALIVE_HDR_SIZE	1
+
+struct nok_data {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+};
+
+static int nok_open(struct hci_uart *hu)
+{
+	struct nok_data *nok;
+
+	BT_DBG("hu %p", hu);
+
+	nok = kzalloc(sizeof(*nok), GFP_KERNEL);
+	if (!nok)
+		return -ENOMEM;
+
+	skb_queue_head_init(&nok->txq);
+
+	hu->priv = nok;
+	return 0;
+}
+
+static int nok_close(struct hci_uart *hu)
+{
+	struct nok_data *nok = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&nok->txq);
+	kfree_skb(nok->rx_skb);
+	kfree(nok);
+
+	hu->priv = NULL;
+	return 0;
+}
+
+static int nok_flush(struct hci_uart *hu)
+{
+	struct nok_data *nok = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&nok->txq);
+
+	return 0;
+}
+
+static int nok_setup(struct hci_uart *hu)
+{
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	int err;
+
+	BT_DBG("hu %p", hu);
+
+	err = request_firmware(&fw, "nokia/bcmfw.bin", hu->tty->dev);
+	if (err < 0) {
+		BT_ERR("%s: Failed to load Nokia firmware file (%d)",
+		       hu->hdev->name, err);
+		return err;
+	}
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	while (fw_size >= 4) {
+		u16 pkt_size = get_unaligned_le16(fw_ptr);
+		u8 pkt_type = fw_ptr[2];
+		const struct hci_command_hdr *cmd;
+		u16 opcode;
+		struct sk_buff *skb;
+
+		switch (pkt_type) {
+		case HCI_COMMAND_PKT:
+		case NOK_RADIO_PKT:
+			cmd = (struct hci_command_hdr *)(fw_ptr + 3);
+			opcode = le16_to_cpu(cmd->opcode);
+
+			skb = __hci_cmd_sync(hu->hdev, opcode, cmd->plen,
+					     fw_ptr + 3 + HCI_COMMAND_HDR_SIZE,
+					     HCI_INIT_TIMEOUT);
+			if (IS_ERR(skb)) {
+				err = PTR_ERR(skb);
+				BT_ERR("%s: Firmware command %04x failed (%d)",
+				       hu->hdev->name, opcode, err);
+				goto done;
+			}
+			kfree_skb(skb);
+			break;
+		case NOK_NEG_PKT:
+		case NOK_ALIVE_PKT:
+			break;
+		}
+
+		fw_ptr += pkt_size + 2;
+		fw_size -= pkt_size + 2;
+	}
+
+	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
+	set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
+
+done:
+	release_firmware(fw);
+	return err;
+}
+
+static int nok_recv_neg(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int nok_recv_alive(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+	return 0;
+}
+
+static int nok_recv_radio(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Packets received on the dedicated radio channel are
+	 * HCI events and so feed them back into the core.
+	 */
+	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	return hci_recv_frame(hdev, skb);
+}
+
+#define NOK_RECV_NEG \
+	.type = NOK_NEG_PKT, \
+	.hlen = NOK_NEG_HDR_SIZE, \
+	.loff = 0, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
+#define NOK_RECV_ALIVE \
+	.type = NOK_ALIVE_PKT, \
+	.hlen = NOK_ALIVE_HDR_SIZE, \
+	.loff = 0, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
+#define NOK_RECV_RADIO \
+	.type = NOK_RADIO_PKT, \
+	.hlen = HCI_EVENT_HDR_SIZE, \
+	.loff = 1, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
+static const struct h4_recv_pkt nok_recv_pkts[] = {
+	{ H4_RECV_ACL,    .recv = hci_recv_frame },
+	{ H4_RECV_SCO,    .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,  .recv = hci_recv_frame },
+	{ NOK_RECV_NEG,   .recv = nok_recv_neg   },
+	{ NOK_RECV_ALIVE, .recv = nok_recv_alive },
+	{ NOK_RECV_RADIO, .recv = nok_recv_radio },
+};
+
+static int nok_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct nok_data *nok = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	nok->rx_skb = h4_recv_buf(hu->hdev, nok->rx_skb, data, count,
+				  nok_recv_pkts, ARRAY_SIZE(nok_recv_pkts));
+	if (IS_ERR(nok->rx_skb)) {
+		int err = PTR_ERR(nok->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		return err;
+	}
+
+	return count;
+}
+
+static int nok_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct nok_data *bcm = hu->priv;
+	u8 pkt_type;
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	/* Packets for the FM radio control are standard HCI commands, but
+	 * they are sent through the dedicated radio channel.
+	 */
+	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT &&
+	    bt_cb(skb)->opcode == 0xfc15)
+		pkt_type = NOK_RADIO_PKT;
+	else
+		pkt_type = bt_cb(skb)->pkt_type;
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &pkt_type, 1);
+	skb_queue_tail(&bcm->txq, skb);
+
+	return 0;
+}
+
+static struct sk_buff *nok_dequeue(struct hci_uart *hu)
+{
+	struct nok_data *nok = hu->priv;
+
+	return skb_dequeue(&nok->txq);
+}
+
+static const struct hci_uart_proto nok_proto = {
+	.id		= HCI_UART_NOK,
+	.name		= "Nokia",
+	.open		= nok_open,
+	.close		= nok_close,
+	.flush		= nok_flush,
+	.setup		= nok_setup,
+	.recv		= nok_recv,
+	.enqueue	= nok_enqueue,
+	.dequeue	= nok_dequeue,
+};
+
+int __init nok_init(void)
+{
+	return hci_uart_register_proto(&nok_proto);
+}
+
+int __exit nok_deinit(void)
+{
+	return hci_uart_unregister_proto(&nok_proto);
+}
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 72120a5ba13c..3735c8adc6e6 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	8
+#define HCI_UART_MAX_PROTO	9
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -45,6 +45,7 @@
 #define HCI_UART_ATH3K	5
 #define HCI_UART_INTEL	6
 #define HCI_UART_BCM	7
+#define HCI_UART_NOK	8
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -160,3 +161,8 @@ int h5_deinit(void);
 int bcm_init(void);
 int bcm_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_NOK
+int nok_init(void);
+int nok_deinit(void);
+#endif
-- 
2.1.0

