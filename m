Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Feb 2010 17:13:04 +0530
From: Vikram Kandukuri <vkandukuri@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <suraj@atheros.com>, <lrodriguez@atheros.com>
Subject: [PATCH] Added support for Atheros AR300x UART Bluetooth Chip
Message-ID: <20100209114231.GA6587@ATH-LT-538>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>


 Signed-off-by: Suraj <suraj@atheros.com>

---
 drivers/bluetooth/Kconfig     |   10 +
 drivers/bluetooth/Makefile    |    1 +
 drivers/bluetooth/hci_ath.c   |  545 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ath.h   |   72 ++++++
 drivers/bluetooth/hci_ldisc.c |    6 +
 drivers/bluetooth/hci_uart.h  |    8 +-
 6 files changed, 641 insertions(+), 1 deletions(-)
 create mode 100755 drivers/bluetooth/hci_ath.c
 create mode 100755 drivers/bluetooth/hci_ath.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 058fbcc..32b98a4 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -58,6 +58,16 @@ config BT_HCIUART_BCSP
 
 	  Say Y here to compile support for HCI BCSP protocol.
 
+config BT_HCIUART_ATH
+	bool "Atheros AR3001 Board support"
+	depends on BT_HCIUART
+	help
+	  HCIATH (HCI Atheros) is a serial protocol for communication
+	  between Bluetooth device and host. This protocol is required for
+	  serial Bluetooth devices that are based on Atheros AR3001 chips.
+
+	  Say Y here to compile support for HCIATH protocol.
+
 config BT_HCIUART_LL
 	bool "HCILL protocol support"
 	depends on BT_HCIUART
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 7e5aed5..1481faa 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -26,4 +26,5 @@ hci_uart-y				:= hci_ldisc.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
 hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-$(CONFIG_BT_HCIUART_LL)	+= hci_ll.o
+hci_uart-$(CONFIG_BT_HCIUART_ATH)	+= hci_ath.o
 hci_uart-objs				:= $(hci_uart-y)
diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
new file mode 100755
index 0000000..abacc09
--- /dev/null
+++ b/drivers/bluetooth/hci_ath.c
@@ -0,0 +1,545 @@
+/*
+ * Copyright (c) 2009-2010 Atheros Communications Inc.
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
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/poll.h>
+
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/ioctl.h>
+#include <linux/skbuff.h>
+#include <linux/firmware.h>
+#include <linux/wait.h>
+#include <linux/timer.h>
+#include <linux/tty.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+
+#include "hci_uart.h"
+#include "hci_ath.h"
+static void ath_context_switch(struct work_struct *work)
+{
+	int status;
+	struct ath_struct *ath;
+	struct hci_uart *hu;
+	struct tty_struct *tty;
+	struct sk_buff *skbuf;
+	ath = container_of(work, struct ath_struct, ctxtsw);
+	hu = ath->hu;
+	tty = hu->tty;
+	status = ath_wakeup_ar3001(tty);
+	if ((status & TIOCM_CTS)) {
+		while ((skbuf = skb_dequeue(&ath->tx_wait_q)))
+			skb_queue_tail(&ath->txq, skbuf);
+
+		/* Ready to send Data */
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		hci_uart_tx_wakeup(hu);
+	}
+}
+
+/* Initialize protocol */
+static int ath_open(struct hci_uart *hu)
+{
+	struct ath_struct *ath;
+	BT_DBG("hu %p", hu);
+	ath = kzalloc(sizeof(*ath), GFP_ATOMIC);
+	if (!ath)
+		return -ENOMEM;
+	skb_queue_head_init(&ath->txq);
+	skb_queue_head_init(&ath->tx_wait_q);
+	skb_queue_head_init(&ath->tx_cmd_wait_q);
+	spin_lock_init(&ath->hciath_lock);
+	ath->cur_sleep = 0;
+	ath->num_cmds_complete = 1;
+	hu->priv = ath;
+	ath->hu = hu;
+	init_waitqueue_head(&ath->wqevt);
+	INIT_WORK(&ath->ctxtsw, ath_context_switch);
+	return 0;
+}
+
+/* Flush protocol data */
+static int ath_flush(struct hci_uart *hu)
+{
+	struct ath_struct *ath = hu->priv;
+	BT_DBG("hu %p", hu);
+	skb_queue_purge(&ath->tx_wait_q);
+	skb_queue_purge(&ath->txq);
+	skb_queue_purge(&ath->tx_cmd_wait_q);
+	return 0;
+}
+
+/* Close protocol */
+static int ath_close(struct hci_uart *hu)
+{
+	struct ath_struct *ath;
+	ath = hu->priv;
+	BT_DBG("hu %p", hu);
+	skb_queue_purge(&ath->tx_wait_q);
+	skb_queue_purge(&ath->txq);
+	skb_queue_purge(&ath->tx_cmd_wait_q);
+	if (ath->rx_skb)
+		kfree_skb(ath->rx_skb);
+	wake_up_interruptible(&ath->wqevt);
+	hu->priv = NULL;
+	kfree(ath);
+	return 0;
+}
+
+/* Enqueue frame for transmittion (padding, crc, etc) */
+/* may be called from two simultaneous tasklets */
+static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct ath_struct *ath;
+	ath = hu->priv;
+	if (HCI_SCODATA_PKT == bt_cb(skb)->pkt_type) {
+
+		/* Discard SCO packet as AR3001 does not support SCO over HCI */
+		BT_DBG("SCO Packet over HCI received Dropping\n");
+		kfree(skb);
+		return 0;
+	}
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	if (ath->num_cmds_complete <= 0
+	    && HCI_COMMAND_PKT == bt_cb(skb)->pkt_type) {
+		skb_queue_tail(&ath->tx_cmd_wait_q, skb);
+		return 0;
+	}
+
+	skb_queue_tail(&ath->txq, skb);
+	set_bit(HCI_UART_SENDING, &hu->tx_state);
+
+	schedule_work(&ath->ctxtsw);
+	return 0;
+}
+
+static struct sk_buff *ath_dequeue(struct hci_uart *hu)
+{
+	struct ath_struct *ath;
+	struct sk_buff *skbuff;
+	ath = hu->priv;
+	skbuff = skb_dequeue(&ath->txq);
+	if (NULL != skbuff) {
+		ath_handle_host_data(ath, bt_cb(skbuff)->pkt_type,
+				     &skbuff->data[1], skbuff->len - 1);
+	}
+	return skbuff;
+}
+
+static inline int ath_check_data_len(struct ath_struct *ath, int len)
+{
+	register int room = skb_tailroom(ath->rx_skb);
+	BT_DBG("len %d room %d", len, room);
+	if (!len) {
+		hci_recv_frame(ath->rx_skb);
+	} else if (len > room) {
+		BT_ERR("Data length is too large");
+		kfree_skb(ath->rx_skb);
+	} else {
+		ath->rx_state = HCIATH_W4_DATA;
+		ath->rx_count = len;
+		return len;
+	}
+	ath->rx_state = HCIATH_W4_PACKET_TYPE;
+	ath->rx_skb = NULL;
+	ath->rx_count = 0;
+	return 0;
+}
+
+/* Recv data */
+static int ath_recv(struct hci_uart *hu, void *data, int count)
+{
+	struct ath_struct *ath = hu->priv;
+	register char *ptr;
+	struct hci_event_hdr *eh;
+	struct hci_acl_hdr *ah;
+	struct hci_sco_hdr *sh;
+	struct sk_buff *skbuff;
+	register int len, type, dlen;
+	skbuff = NULL;
+	BT_DBG("hu %p count %d rx_state %d rx_count %d", hu, count,
+	       ath->rx_state, ath->rx_count);
+	ptr = data;
+	while (count) {
+		if (ath->rx_count) {
+			len = min_t(unsigned int, ath->rx_count, count);
+			memcpy(skb_put(ath->rx_skb, len), ptr, len);
+			ath->rx_count -= len;
+			count -= len;
+			ptr += len;
+			if (ath->rx_count)
+				continue;
+			switch (ath->rx_state) {
+			case HCIATH_W4_DATA:
+				ath_handle_data_from_controller(ath,
+								bt_cb
+								(ath->rx_skb)->
+								pkt_type,
+								ath->rx_skb->
+								data,
+								ath->rx_skb->
+								len);
+				if (HCI_EVENT_PKT ==
+				    bt_cb(ath->rx_skb)->pkt_type
+				    && ath->num_cmds_complete > 0) {
+
+					skbuff =
+					    skb_dequeue(&ath->tx_cmd_wait_q);
+					if (skbuff != NULL) {
+						skb_queue_tail(&ath->txq,
+							       skbuff);
+						schedule_work(&ath->ctxtsw);
+					}
+				}
+				if (ath_verify_event_discardable
+				    (hu, bt_cb(ath->rx_skb)->pkt_type,
+				     ath->rx_skb->data)) {
+					kfree(ath->rx_skb);
+					ath->rx_skb = NULL;
+				} else {
+					hci_recv_frame(ath->rx_skb);
+				}
+				ath->rx_state = HCIATH_W4_PACKET_TYPE;
+				ath->rx_skb = NULL;
+				ath->rx_count = 0;
+				continue;
+			case HCIATH_W4_EVENT_HDR:
+				eh = (struct hci_event_hdr *)ath->rx_skb->data;
+				BT_DBG("Event header: evt 0x%2.2x plen %d",
+				       eh->evt, eh->plen);
+				ath_check_data_len(ath, eh->plen);
+				continue;
+			case HCIATH_W4_ACL_HDR:
+				ah = (struct hci_acl_hdr *)ath->rx_skb->data;
+				dlen = __le16_to_cpu(ah->dlen);
+				BT_DBG("ACL header: dlen %d", dlen);
+				ath_check_data_len(ath, dlen);
+				continue;
+			case HCIATH_W4_SCO_HDR:
+				sh = (struct hci_sco_hdr *)ath->rx_skb->data;
+				BT_DBG("SCO header: dlen %d", sh->dlen);
+				ath_check_data_len(ath, sh->dlen);
+				continue;
+			}
+		}
+
+		/* HCIATH_W4_PACKET_TYPE */
+		switch (*ptr) {
+		case HCI_EVENT_PKT:
+			BT_DBG("Event packet");
+			ath->rx_state = HCIATH_W4_EVENT_HDR;
+			ath->rx_count = HCI_EVENT_HDR_SIZE;
+			type = HCI_EVENT_PKT;
+			break;
+		case HCI_ACLDATA_PKT:
+			BT_DBG("ACL packet");
+			ath->rx_state = HCIATH_W4_ACL_HDR;
+			ath->rx_count = HCI_ACL_HDR_SIZE;
+			type = HCI_ACLDATA_PKT;
+			break;
+		case HCI_SCODATA_PKT:
+			BT_DBG("SCO packet");
+			ath->rx_state = HCIATH_W4_SCO_HDR;
+			ath->rx_count = HCI_SCO_HDR_SIZE;
+			type = HCI_SCODATA_PKT;
+			break;
+		default:
+			BT_ERR("Unknown HCI packet type %2.2x", (__u8) *ptr);
+			hu->hdev->stat.err_rx++;
+			ptr++;
+			count--;
+			continue;
+		};
+		ptr++;
+		count--;
+
+		/* Allocate packet */
+		ath->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+		if (!ath->rx_skb) {
+			BT_ERR("Can't allocate mem for new packet");
+			ath->rx_state = HCIATH_W4_PACKET_TYPE;
+			ath->rx_count = 0;
+			return 0;
+		}
+		ath->rx_skb->dev = (void *)hu->hdev;
+		bt_cb(ath->rx_skb)->pkt_type = type;
+	} return count;
+}
+
+static void ath_controller_sleep_mode(struct hci_uart *hu, bool enable)
+{
+	unsigned char sleepcmd[] = { 0x01, 0x04, 0xFC, 0x01, 0x00 };
+	sleepcmd[4] = enable;
+	ath_write_data_to_cntrlr(hu->hdev, sleepcmd, sizeof(sleepcmd));
+}
+
+int ath_wakeup_ar3001(struct tty_struct *tty)
+{
+	struct termios settings;
+	int status = 0x00;
+	mm_segment_t oldfs;
+	status = tty->driver->ops->tiocmget(tty, NULL);
+
+	if ((status & TIOCM_CTS))
+		return status;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
+
+	settings.c_cflag &= ~CRTSCTS;
+	n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
+	set_fs(oldfs);
+	status = tty->driver->ops->tiocmget(tty, NULL);
+
+	tty->driver->ops->tiocmset(tty, NULL, 0x00, TIOCM_RTS);
+	mdelay(20);
+
+	status = tty->driver->ops->tiocmget(tty, NULL);
+
+	tty->driver->ops->tiocmset(tty, NULL, TIOCM_RTS, 0x00);
+	mdelay(20);
+
+	status = tty->driver->ops->tiocmget(tty, NULL);
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	n_tty_ioctl_helper(tty, NULL, TCGETS, (unsigned long)&settings);
+
+	settings.c_cflag |= CRTSCTS;
+	n_tty_ioctl_helper(tty, NULL, TCSETS, (unsigned long)&settings);
+	set_fs(oldfs);
+	return status;
+}
+
+int ath_fullboot_config(struct hci_uart *hu, int current_event)
+{
+	struct sk_buff *skbuf;
+	struct ath_struct *ath = hu->priv;
+	static int autosleep;
+	unsigned char rstevt[] = { 0x1, 0x3, 0xc, 0x0 };
+	if (current_event == HCI_RESET) {
+
+		if (ath->cur_sleep) {
+			autosleep = 1;
+			ath_controller_sleep_mode(hu, 1);
+			return 1;
+		} else {
+			return 0;
+		}
+	}
+
+	if (current_event == HCI_SET_SLEEP_MODE) {
+
+		if (autosleep == 0)
+			return 1;
+
+		while ((skbuf = skb_dequeue(&ath->tx_wait_q)))
+			skb_queue_tail(&ath->txq, skbuf);
+
+		ath_write_data_to_host(hu->hdev, rstevt, sizeof(rstevt));
+		autosleep = 0;
+		return 1;
+	}
+	return 0;
+}
+
+int ath_write_data_to_host(void *dev, unsigned char *data, u8 length)
+{
+	struct sk_buff *skbuf;
+	struct hci_dev *hdev;
+	hdev = (struct hci_dev *)dev;
+	skbuf = bt_skb_alloc(length, GFP_ATOMIC);
+	if (!skbuf) {
+		BT_ERR("Memory allocation failed");
+		return -1;
+	}
+	skb_orphan(skbuf);
+
+	/* First byte will be added as packet type */
+	bt_cb(skbuf)->pkt_type = data[0];
+	skbuf->dev = (void *)hdev;
+	memcpy(skb_put(skbuf, length - 1), &data[1], length - 1);
+	hci_recv_frame(skbuf);
+	return length;
+}
+
+int ath_write_data_to_cntrlr(void *dev, unsigned char *Data, u8 len)
+{
+	struct sk_buff *skbuff;
+	struct ath_struct *ath;
+	struct hci_uart *hu;
+	struct hci_dev *hdev;
+	if (NULL == dev) {
+		BT_DBG("NULL handle received %p  \n", dev);
+		return 0;
+	}
+	hdev = (struct hci_dev *)dev;
+	hu = (struct hci_uart *)hdev->driver_data;
+	if (hu == NULL) {
+		BT_DBG("NULL handle received %p  \n", hdev);
+		return 0;
+	}
+	ath = hu->priv;
+	if (ath == NULL) {
+		BT_DBG("NULL handle received  \n");
+		return 0;
+	}
+	skbuff = bt_skb_alloc(len, GFP_ATOMIC);
+	if (skbuff == NULL) {
+		BT_DBG("Malloc Fail memory %p   \n", skbuff);
+		return 0;
+	}
+	skb_orphan(skbuff);
+
+	if (len != 0)
+		memcpy(skb_put(skbuff, len), Data, len);
+
+	bt_cb(skbuff)->pkt_type = HCI_COMMAND_PKT;
+	skbuff->dev = dev;
+	if (ath->num_cmds_complete > 0) {
+		skb_queue_tail(&ath->txq, skbuff);
+		schedule_work(&ath->ctxtsw);
+	} else {
+		skb_queue_tail(&ath->tx_cmd_wait_q, skbuff);
+	}
+	return len;
+}
+
+int ath_check_sleep_cmd(struct ath_struct *ath, unsigned char *packet)
+{
+	if (packet[0] == HCI_EVENT_PKT && packet[1] == 0xFC)
+		ath->cur_sleep = packet[3];
+
+	return 0;
+}
+
+int ath_verify_event_discardable(struct hci_uart *hu, unsigned char pkt_type,
+				 unsigned char *packet)
+{
+	if (pkt_type != HCI_EVENT_PKT)
+		return 0;
+
+	switch (packet[0]) {
+	case 0x0E:		/* Command Complete Event */
+		if (packet[3] == 0x03 && packet[4] == 0x0C) {
+
+			/* Command complete for HCI Reset Received */
+			return ath_fullboot_config(hu, HCI_RESET);
+		} else if (packet[3] == 0x04 && packet[4] == 0xFC) {
+			return ath_fullboot_config(hu, HCI_SET_SLEEP_MODE);
+		}
+		break;
+	}
+	return 0;
+}
+
+/* Update the number of commands that can be sent to controller */
+void ath_handle_hci_cmd(struct ath_struct *ath, u8 * packet)
+{
+	spin_lock(&ath->hciath_lock);
+	ath->num_cmds_complete--;
+	spin_unlock(&ath->hciath_lock);
+}
+
+void ath_handle_hci_event(struct ath_struct *ath, u8 * packet)
+{
+	switch (packet[0]) {
+	case 0x05:		/* ACL Disconnection Complete Event */
+		break;
+	case 0x03:		/* ACL Connection Complete Event */
+		break;
+	case 0x0E:		/* Command Complete Event */
+		spin_lock(&ath->hciath_lock);
+		ath->num_cmds_complete = packet[2];
+		spin_unlock(&ath->hciath_lock);
+		break;
+	case 0x0F:		/* Command Status Event */
+		spin_lock(&ath->hciath_lock);
+		ath->num_cmds_complete = packet[3];
+		spin_unlock(&ath->hciath_lock);
+		break;
+	}
+}
+
+void ath_handle_host_data(struct ath_struct *ath, u8 pktType, u8 * packet,
+			  unsigned int len)
+{
+	switch (pktType) {
+	case HCI_ACLDATA_PKT:	/* ACL packets */
+		break;
+	case HCI_COMMAND_PKT:	/* HCI Commands */
+		ath_handle_hci_cmd(ath, packet);
+		ath_check_sleep_cmd(ath, packet);
+		break;
+	}
+}
+
+void ath_handle_data_from_controller(struct ath_struct *ath, u8 pktType,
+				     u8 *packet, unsigned int len)
+{
+	switch (pktType) {
+	case HCI_ACLDATA_PKT:	/* ACL packets */
+		break;
+	case HCI_EVENT_PKT:	/* HCI Events */
+		ath_handle_hci_event(ath, packet);
+		break;
+	}
+}
+
+static struct hci_uart_proto athp = {
+	.id = HCI_UART_ATH,
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
+	if (!err)
+		BT_INFO("HCIATH protocol initialized");
+
+	else
+		BT_ERR("HCIATH protocol registration failed");
+	return err;
+}
+
+int ath_deinit(void)
+{
+	return hci_uart_unregister_proto(&athp);
+}
diff --git a/drivers/bluetooth/hci_ath.h b/drivers/bluetooth/hci_ath.h
new file mode 100755
index 0000000..7513a89
--- /dev/null
+++ b/drivers/bluetooth/hci_ath.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2009-2010 Atheros Communications Inc.
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
+#ifndef __HCI_ATH_H_
+#define __HCI_ATH_H_
+
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/timer.h>
+
+#include <linux/ioctl.h>
+#include <linux/skbuff.h>
+#include <linux/firmware.h>
+#include <linux/wait.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+/* HCIATH receiver States */
+#define HCIATH_W4_PACKET_TYPE		0
+#define HCIATH_W4_EVENT_HDR			1
+#define HCIATH_W4_ACL_HDR			2
+#define HCIATH_W4_SCO_HDR			3
+#define HCIATH_W4_DATA				4
+
+#define HCI_SET_SLEEP_MODE			0xFC04
+#define HCI_RESET					0x030C
+    struct ath_struct {
+	struct hci_uart *hu;
+	unsigned int rx_state;
+	unsigned int rx_count;
+	unsigned int cur_sleep;
+	int num_cmds_complete;
+	spinlock_t hciath_lock;
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	struct sk_buff_head tx_wait_q;
+	struct sk_buff_head tx_cmd_wait_q;
+	wait_queue_head_t wqevt;
+	struct work_struct ctxtsw;
+};
+int ath_write_data_to_cntrlr(void *dev, unsigned char *Data, u8 len);
+int ath_write_data_to_host(void *dev, unsigned char *data, u8 length);
+int ath_wakeup_ar3001(struct tty_struct *tty);
+int ath_verify_event_discardable(struct hci_uart *hu, unsigned char pkt_type,
+				 unsigned char *packet);
+int ath_check_sleep_cmd(struct ath_struct *ath, unsigned char *packet);
+void ath_handle_host_data(struct ath_struct *ath, u8 pktType, u8 *packet,
+			  unsigned int len);
+void ath_handle_data_from_controller(struct ath_struct *ath, u8 pktType,
+				     u8 *packet, unsigned int len);
+
+
+#endif	/* __HCI_ATH_H_ */
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index aa09193..bd16130 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -542,6 +542,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_LL
 	ll_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_ATH
+	ath_init();
+#endif
 
 	return 0;
 }
@@ -559,6 +562,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_LL
 	ll_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_ATH
+	ath_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	if ((err = tty_unregister_ldisc(N_HCI)))
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 50113db..385537f 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -33,13 +33,14 @@
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	5
+#define HCI_UART_MAX_PROTO	6
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
 #define HCI_UART_3WIRE	2
 #define HCI_UART_H4DS	3
 #define HCI_UART_LL	4
+#define HCI_UART_ATH	5
 
 struct hci_uart;
 
@@ -91,3 +92,8 @@ int bcsp_deinit(void);
 int ll_init(void);
 int ll_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_ATH
+int ath_init(void);
+int ath_deinit(void);
+#endif
-- 
1.6.3.3
