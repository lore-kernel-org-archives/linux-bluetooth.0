Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v2] Bluetooth: Support for Atheros AR300x serial Bluetooth Chip
Date: Mon, 19 Jul 2010 12:34:07 +0530
Message-ID: <1279523047-4638-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements Atheros AR300x Serial HCI protocol.
This protocol extends H4 serial protocol to implement enhanced power management
features supported by Atheros AR300x serial Bluetooth chipsets.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 drivers/bluetooth/Kconfig     |   12 ++
 drivers/bluetooth/Makefile    |    1 +
 drivers/bluetooth/hci_ath.c   |  235 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |    6 +
 drivers/bluetooth/hci_uart.h  |    8 ++-
 5 files changed, 261 insertions(+), 1 deletions(-)
 create mode 100755 drivers/bluetooth/hci_ath.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 058fbcc..c35047f 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -58,6 +58,18 @@ config BT_HCIUART_BCSP
 
 	  Say Y here to compile support for HCI BCSP protocol.
 
+config BT_HCIUART_ATH3K
+	bool "Atheros AR300x serial Bluetooth support"
+	depends on BT_HCIUART
+	help
+	  HCIATH3K (HCI Atheros AR300x Protocol) is a serial protocol
+	  for communication between host and Atheros AR300x Bluetooth devices.
+	  This protocol enables AR300x Chips to be enabled with
+	  power management support.
+	  Enable this if you have Atheros AR300x serial Bluetooth device.
+
+	  Say Y here to compile support for HCI UART ATH3K protocol.
+
 config BT_HCIUART_LL
 	bool "HCILL protocol support"
 	depends on BT_HCIUART
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 7e5aed5..71bdf13 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -26,4 +26,5 @@ hci_uart-y				:= hci_ldisc.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
 hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
+hci_uart-$(CONFIG_BT_HCIUART_ATH3K)	+= hci_ath.o
 hci_uart-objs				:= $(hci_uart-y)
diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
new file mode 100755
index 0000000..5ab258b
--- /dev/null
+++ b/drivers/bluetooth/hci_ath.c
@@ -0,0 +1,235 @@
+/*
+ *  Atheros Communication Bluetooth HCIATH3K UART protocol
+ *
+ *  HCIATH3K (HCI Atheros AR300x Protocol) is a Atheros Communication's
+ *  power management protocol extension to H4 to support AR300x Bluetooth Chip.
+ *
+ *  Copyright (c) 2009-2010 Atheros Communications Inc.
+ *
+ *  Acknowledgements:
+ *  This file is based on hci_h4.c, which was written
+ *  by Maxim Krasnyansky and Marcel Holtmann.
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/ioctl.h>
+#include <linux/skbuff.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+
+struct ath_struct {
+	struct hci_uart *hu;
+	unsigned int cur_sleep;
+
+	struct sk_buff_head txq;
+	struct work_struct ctxtsw;
+};
+
+static int ath_wakeup_ar3k(struct tty_struct *tty)
+{
+	struct termios settings;
+	int status = tty->driver->ops->tiocmget(tty, NULL);
+
+	if (status & TIOCM_CTS)
+		return status;
+
+	/* Disable Automatic RTSCTS */
+	n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
+	settings.c_cflag &= ~CRTSCTS;
+	n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
+
+	/* Clear RTS first */
+	status = tty->driver->ops->tiocmget(tty, NULL);
+	tty->driver->ops->tiocmset(tty, NULL, 0x00, TIOCM_RTS);
+	mdelay(20);
+
+	/* Set RTS, wake up board */
+	status = tty->driver->ops->tiocmget(tty, NULL);
+	tty->driver->ops->tiocmset(tty, NULL, TIOCM_RTS, 0x00);
+	mdelay(20);
+
+	status = tty->driver->ops->tiocmget(tty, NULL);
+
+	n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
+	settings.c_cflag |= CRTSCTS;
+	n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
+
+	return status;
+}
+
+static void ath_hci_uart_work(struct work_struct *work)
+{
+	int status;
+	struct ath_struct *ath;
+	struct hci_uart *hu;
+	struct tty_struct *tty;
+
+	ath = container_of(work, struct ath_struct, ctxtsw);
+
+	hu = ath->hu;
+	tty = hu->tty;
+
+	/* verify and wake up controller */
+	if (ath->cur_sleep) {
+		status = ath_wakeup_ar3k(tty);
+		if (!(status & TIOCM_CTS))
+			return;
+	}
+
+	/* Ready to send Data */
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	hci_uart_tx_wakeup(hu);
+}
+
+/* Initialize protocol */
+static int ath_open(struct hci_uart *hu)
+{
+	struct ath_struct *ath;
+
+	BT_DBG("hu %p", hu);
+
+	ath = kzalloc(sizeof(*ath), GFP_ATOMIC);
+	if (!ath)
+		return -ENOMEM;
+
+	skb_queue_head_init(&ath->txq);
+
+	hu->priv = ath;
+	ath->hu = hu;
+
+	INIT_WORK(&ath->ctxtsw, ath_hci_uart_work);
+
+	return 0;
+}
+
+/* Flush protocol data */
+static int ath_flush(struct hci_uart *hu)
+{
+	struct ath_struct *ath = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&ath->txq);
+
+	return 0;
+}
+
+/* Close protocol */
+static int ath_close(struct hci_uart *hu)
+{
+	struct ath_struct *ath = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&ath->txq);
+
+	cancel_work_sync(&ath->ctxtsw);
+
+	hu->priv = NULL;
+	kfree(ath);
+
+	return 0;
+}
+
+#define HCI_OP_ATH_SLEEP 0xFC04
+
+/* Enqueue frame for transmittion */
+static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct ath_struct *ath = hu->priv;
+
+	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
+		kfree(skb);
+		return 0;
+	}
+
+	/*
+	 * Update power management enable flag with parameters of
+	 * HCI sleep enable vendor specific HCI command.
+	 */
+	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+		struct hci_command_hdr *hdr = (void *)skb->data;
+
+		if (__le16_to_cpu(hdr->opcode) == HCI_OP_ATH_SLEEP)
+			ath->cur_sleep = skb->data[HCI_COMMAND_HDR_SIZE];
+	}
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+
+	skb_queue_tail(&ath->txq, skb);
+	set_bit(HCI_UART_SENDING, &hu->tx_state);
+
+	schedule_work(&ath->ctxtsw);
+
+	return 0;
+}
+
+static struct sk_buff *ath_dequeue(struct hci_uart *hu)
+{
+	struct ath_struct *ath = hu->priv;
+
+	return skb_dequeue(&ath->txq);
+}
+
+/* Recv data */
+static int ath_recv(struct hci_uart *hu, void *data, int count)
+{
+	if (hci_recv_stream_fragment(hu->hdev, data, count) < 0)
+		BT_ERR("Frame Reassembly Failed");
+
+	return count;
+}
+
+static struct hci_uart_proto athp = {
+	.id = HCI_UART_ATH3K,
+	.open = ath_open,
+	.close = ath_close,
+	.recv = ath_recv,
+	.enqueue = ath_enqueue,
+	.dequeue = ath_dequeue,
+	.flush = ath_flush,
+};
+
+int ath_init(void)
+{
+	int err = hci_uart_register_proto(&athp);
+
+	if (!err)
+		BT_INFO("HCIATH3K protocol initialized");
+	else
+		BT_ERR("HCIATH3K protocol registration failed");
+
+	return err;
+}
+
+int ath_deinit(void)
+{
+	return hci_uart_unregister_proto(&athp);
+}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a57dbfc..998833d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -552,6 +552,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_LL
 	ll_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_ATH3K
+	ath_init();
+#endif
 
 	return 0;
 }
@@ -569,6 +572,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_LL
 	ll_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_ATH3K
+	ath_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	if ((err = tty_unregister_ldisc(N_HCI)))
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 9694d9d..99fb352 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,13 +35,14 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	5
+#define HCI_UART_MAX_PROTO	6
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
 #define HCI_UART_3WIRE	2
 #define HCI_UART_H4DS	3
 #define HCI_UART_LL	4
+#define HCI_UART_ATH3K	5
 
 #define HCI_UART_RAW_DEVICE	0
 
@@ -96,3 +97,8 @@ int bcsp_deinit(void);
 int ll_init(void);
 int ll_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_ATH3K
+int ath_init(void);
+int ath_deinit(void);
+#endif
-- 
1.7.0.4

