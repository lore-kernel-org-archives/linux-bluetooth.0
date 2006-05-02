Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4457BEF2.90707@free.fr>
From: matthieu castet <castet.matthieu@free.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------050207000601080107070707"
Subject: [Bluez-devel] RFC : H4 and BCSP proto unification
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 02 May 2006 22:20:02 +0200

This is a multi-part message in MIME format.
--------------050207000601080107070707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch is an attempt to share H4 and BCSP proto for other drivers
than hci_uart.

hci_h4.c and hci_bcsp.c where expecting a hci_uart structure, I define a
more generic one. I need to add a tx_wakeup function for BCSP.

I also added 1 operation henqueue that queue a skb in the head of the
skb list for driver that can't send all the skb data in one operation.

This is far from perfect (I don't like the hci_dev pointer duplication,
...) and untested for hci_uart driver.

Any comments will be appreciated.

Thanks,

Matthieu


--------------050207000601080107070707
Content-Type: text/plain;
 name="bt_proto_stack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bt_proto_stack.diff"

diff -ur linux.old/drivers/bluetooth/Kconfig linux/drivers/bluetooth/Kconfig
--- linux.old/drivers/bluetooth/Kconfig	2006-04-22 23:28:15.000000000 +0200
+++ linux/drivers/bluetooth/Kconfig	2006-04-29 22:20:10.000000000 +0200
@@ -36,7 +36,6 @@
 
 config BT_HCIUART_H4
 	bool "UART (H4) protocol support"
-	depends on BT_HCIUART
 	help
 	  UART (H4) is serial protocol for communication between Bluetooth 
 	  device and host. This protocol is required for most Bluetooth devices 
@@ -46,7 +45,6 @@
 
 config BT_HCIUART_BCSP
 	bool "BCSP protocol support"
-	depends on BT_HCIUART
 	help
 	  BCSP (BlueCore Serial Protocol) is serial protocol for communication 
 	  between Bluetooth device and host. This protocol is required for non
@@ -134,6 +132,7 @@
 config BT_HCIBTUART
 	tristate "HCI UART (PC Card) device driver"
 	depends on PCMCIA
+	select BT_HCIUART_H4
 	help
 	  Bluetooth HCI UART (PC Card) driver.
 	  This driver provides support for Bluetooth PCMCIA devices with
diff -ur linux.old/drivers/bluetooth/Makefile linux/drivers/bluetooth/Makefile
--- linux.old/drivers/bluetooth/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux/drivers/bluetooth/Makefile	2006-04-29 22:20:10.000000000 +0200
@@ -12,8 +12,8 @@
 obj-$(CONFIG_BT_HCIBT3C)	+= bt3c_cs.o
 obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 obj-$(CONFIG_BT_HCIBTUART)	+= btuart_cs.o
+obj-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
+obj-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 
 hci_uart-y				:= hci_ldisc.o
-hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
-hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
 hci_uart-objs				:= $(hci_uart-y)
diff -ur linux.old/drivers/bluetooth/btuart_cs.c linux/drivers/bluetooth/btuart_cs.c
--- linux.old/drivers/bluetooth/btuart_cs.c	2006-04-22 23:28:41.000000000 +0200
+++ linux/drivers/bluetooth/btuart_cs.c	2006-04-29 22:20:10.000000000 +0200
@@ -53,6 +53,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "hci_uart.h"
 
 
 /* ======================== Module parameters ======================== */
@@ -75,12 +76,9 @@
 
 	spinlock_t lock;	/* For serializing operations */
 
-	struct sk_buff_head txq;
 	unsigned long tx_state;
 
-	unsigned long rx_state;
-	unsigned long rx_count;
-	struct sk_buff *rx_skb;
+	struct hci_uart_proto proto;
 } btuart_info_t;
 
 
@@ -155,7 +153,7 @@
 		if (!(info->link.state & DEV_PRESENT))
 			return;
 
-		if (!(skb = skb_dequeue(&(info->txq))))
+		if (!(skb = info->proto.p->dequeue(&info->proto)))
 			break;
 
 		/* Send frame */
@@ -166,7 +164,7 @@
 			kfree_skb(skb);
 		} else {
 			skb_pull(skb, len);
-			skb_queue_head(&(info->txq), skb);
+			info->proto.p->henqueue(&info->proto, skb);
 		}
 
 		info->hdev->stat.byte_tx += len;
@@ -180,7 +178,8 @@
 static void btuart_receive(btuart_info_t *info)
 {
 	unsigned int iobase;
-	int boguscount = 0;
+	int len = 0;
+	char data [16];
 
 	if (!info) {
 		BT_ERR("Unknown device");
@@ -190,102 +189,15 @@
 	iobase = info->link.io.BasePort1;
 
 	do {
-		info->hdev->stat.byte_rx++;
-
-		/* Allocate packet */
-		if (info->rx_skb == NULL) {
-			info->rx_state = RECV_WAIT_PACKET_TYPE;
-			info->rx_count = 0;
-			if (!(info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))) {
-				BT_ERR("Can't allocate mem for new packet");
-				return;
-			}
-		}
-
-		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
-
-			info->rx_skb->dev = (void *) info->hdev;
-			bt_cb(info->rx_skb)->pkt_type = inb(iobase + UART_RX);
-
-			switch (bt_cb(info->rx_skb)->pkt_type) {
-
-			case HCI_EVENT_PKT:
-				info->rx_state = RECV_WAIT_EVENT_HEADER;
-				info->rx_count = HCI_EVENT_HDR_SIZE;
-				break;
-
-			case HCI_ACLDATA_PKT:
-				info->rx_state = RECV_WAIT_ACL_HEADER;
-				info->rx_count = HCI_ACL_HDR_SIZE;
-				break;
-
-			case HCI_SCODATA_PKT:
-				info->rx_state = RECV_WAIT_SCO_HEADER;
-				info->rx_count = HCI_SCO_HDR_SIZE;
-				break;
-
-			default:
-				/* Unknown packet */
-				BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
-				info->hdev->stat.err_rx++;
-				clear_bit(HCI_RUNNING, &(info->hdev->flags));
-
-				kfree_skb(info->rx_skb);
-				info->rx_skb = NULL;
-				break;
-
-			}
-
-		} else {
-
-			*skb_put(info->rx_skb, 1) = inb(iobase + UART_RX);
-			info->rx_count--;
-
-			if (info->rx_count == 0) {
-
-				int dlen;
-				struct hci_event_hdr *eh;
-				struct hci_acl_hdr *ah;
-				struct hci_sco_hdr *sh;
-
-
-				switch (info->rx_state) {
-
-				case RECV_WAIT_EVENT_HEADER:
-					eh = (struct hci_event_hdr *)(info->rx_skb->data);
-					info->rx_state = RECV_WAIT_DATA;
-					info->rx_count = eh->plen;
-					break;
-
-				case RECV_WAIT_ACL_HEADER:
-					ah = (struct hci_acl_hdr *)(info->rx_skb->data);
-					dlen = __le16_to_cpu(ah->dlen);
-					info->rx_state = RECV_WAIT_DATA;
-					info->rx_count = dlen;
-					break;
-
-				case RECV_WAIT_SCO_HEADER:
-					sh = (struct hci_sco_hdr *)(info->rx_skb->data);
-					info->rx_state = RECV_WAIT_DATA;
-					info->rx_count = sh->dlen;
-					break;
-
-				case RECV_WAIT_DATA:
-					hci_recv_frame(info->rx_skb);
-					info->rx_skb = NULL;
-					break;
-
-				}
-
-			}
-
-		}
-
+		data[len] = inb(iobase + UART_RX);
+		
 		/* Make sure we don't stay here too long */
-		if (boguscount++ > 16)
+		if (len++ > 16)
 			break;
 
 	} while (inb(iobase + UART_LSR) & UART_LSR_DR);
+	info->hdev->stat.byte_rx += len;
+	info->proto.p->recv(&info->proto, data, len);
 }
 
 
@@ -404,7 +316,7 @@
 	btuart_info_t *info = (btuart_info_t *)(hdev->driver_data);
 
 	/* Drop TX queue */
-	skb_queue_purge(&(info->txq));
+	info->proto.p->flush(&info->proto);
 
 	return 0;
 }
@@ -453,9 +365,7 @@
 		break;
 	};
 
-	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
-	skb_queue_tail(&(info->txq), skb);
+	info->proto.p->enqueue(&info->proto, skb);
 
 	btuart_write_wakeup(info);
 
@@ -486,12 +396,6 @@
 
 	spin_lock_init(&(info->lock));
 
-	skb_queue_head_init(&(info->txq));
-
-	info->rx_state = RECV_WAIT_PACKET_TYPE;
-	info->rx_count = 0;
-	info->rx_skb = NULL;
-
 	/* Initialize HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
@@ -499,6 +403,9 @@
 		return -ENOMEM;
 	}
 
+	info->proto.p = h4_init();
+	info->proto.p->open(&info->proto, hdev);
+
 	info->hdev = hdev;
 
 	hdev->type = HCI_PCCARD;
@@ -558,6 +465,8 @@
 
 	btuart_hci_close(hdev);
 
+	info->proto.p->close(&info->proto);
+
 	spin_lock_irqsave(&(info->lock), flags);
 
 	/* Reset UART */
diff -ur linux.old/drivers/bluetooth/hci_bcsp.c linux/drivers/bluetooth/hci_bcsp.c
--- linux.old/drivers/bluetooth/hci_bcsp.c	2006-04-22 23:28:41.000000000 +0200
+++ linux/drivers/bluetooth/hci_bcsp.c	2006-04-29 22:21:48.000000000 +0200
@@ -173,9 +173,9 @@
 	}
 }
 
-static int bcsp_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+static int bcsp_enqueue(struct hci_uart_proto *proto, struct sk_buff *skb)
 {
-	struct bcsp_struct *bcsp = hu->priv;
+	struct bcsp_struct *bcsp = proto->priv;
 
 	if (skb->len > 0xFFF) {
 		BT_ERR("Packet too long");
@@ -202,6 +202,12 @@
 	return 0;
 }
 
+static int bcsp_henqueue(struct hci_uart_proto *proto, struct sk_buff *skb)
+{
+	 BT_ERR("bcsp_enqueue : not implemented");
+	 return -ENOENT;
+}
+
 static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
 		int len, int pkt_type)
 {
@@ -307,9 +313,9 @@
 }
 
 /* This is a rewrite of pkt_avail in ABCSP */
-static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
+static struct sk_buff *bcsp_dequeue(struct hci_uart_proto *proto)
 {
-	struct bcsp_struct *bcsp = hu->priv;
+	struct bcsp_struct *bcsp = proto->priv;
 	unsigned long flags;
 	struct sk_buff *skb;
 	
@@ -363,9 +369,9 @@
 	return NULL;
 }
 
-static int bcsp_flush(struct hci_uart *hu)
+static int bcsp_flush(struct hci_uart_proto *proto)
 {
-	BT_DBG("hu %p", hu);
+	BT_DBG("proto %p", proto);
 	return 0;
 }
 
@@ -417,9 +423,9 @@
 /* Handle BCSP link-establishment packets. When we
    detect a "sync" packet, symptom that the BT module has reset,
    we do nothing :) (yet) */
-static void bcsp_handle_le_pkt(struct hci_uart *hu)
+static void bcsp_handle_le_pkt(struct hci_uart_proto *proto)
 {
-	struct bcsp_struct *bcsp = hu->priv;
+	struct bcsp_struct *bcsp = proto->priv;
 	u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
 	u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
 	u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
@@ -436,7 +442,7 @@
 		bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
 
 		skb_queue_head(&bcsp->unrel, nskb);
-		hci_uart_tx_wakeup(hu);
+		proto->tx_wakeup(proto->tx_wakeup_data);
 	}
 	/* Spot "sync" pkts. If we find one...disaster! */
 	else if (bcsp->rx_skb->data[1] >> 4 == 4 && bcsp->rx_skb->data[2] == 0 &&
@@ -494,9 +500,9 @@
 	}
 }
 
-static void bcsp_complete_rx_pkt(struct hci_uart *hu)
+static void bcsp_complete_rx_pkt(struct hci_uart_proto *proto)
 {
-	struct bcsp_struct *bcsp = hu->priv;
+	struct bcsp_struct *bcsp = proto->priv;
 	int pass_up;
 
 	if (bcsp->rx_skb->data[0] & 0x80) {	/* reliable pkt */
@@ -506,7 +512,7 @@
 		bcsp->txack_req    = 1;
 
 		/* If needed, transmit an ack pkt */
-		hci_uart_tx_wakeup(hu);
+		proto->tx_wakeup(proto->tx_wakeup_data);
 	}
 
 	bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;
@@ -526,7 +532,7 @@
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
 			!(bcsp->rx_skb->data[0] & 0x80)) {
-		bcsp_handle_le_pkt(hu);
+		bcsp_handle_le_pkt(proto);
 		pass_up = 0;
 	} else
 		pass_up = 0;
@@ -568,13 +574,13 @@
 }
 
 /* Recv data */
-static int bcsp_recv(struct hci_uart *hu, void *data, int count)
+static int bcsp_recv(struct hci_uart_proto *proto, void *data, int count)
 {
-	struct bcsp_struct *bcsp = hu->priv;
+	struct bcsp_struct *bcsp = proto->priv;
 	register unsigned char *ptr;
 
-	BT_DBG("hu %p count %d rx_state %d rx_count %ld", 
-		hu, count, bcsp->rx_state, bcsp->rx_count);
+	BT_DBG("proto %p count %d rx_state %d rx_count %ld", 
+		proto, count, bcsp->rx_state, bcsp->rx_count);
 
 	ptr = data;
 	while (count) {
@@ -621,7 +627,7 @@
 				bcsp->rx_state = BCSP_W4_CRC;
 				bcsp->rx_count = 2;
 			} else
-				bcsp_complete_rx_pkt(hu);
+				bcsp_complete_rx_pkt(proto);
 			continue;
 
 		case BCSP_W4_CRC:
@@ -640,7 +646,7 @@
 				continue;
 			}
 			skb_trim(bcsp->rx_skb, bcsp->rx_skb->len - 2);
-			bcsp_complete_rx_pkt(hu);
+			bcsp_complete_rx_pkt(proto);
 			continue;
 
 		case BCSP_W4_PKT_DELIMITER:
@@ -678,7 +684,7 @@
 					bcsp->rx_count = 0;
 					return 0;
 				}
-				bcsp->rx_skb->dev = (void *) hu->hdev;
+				bcsp->rx_skb->dev = (void *) proto->hdev;
 				break;
 			}
 			break;
@@ -690,12 +696,12 @@
 	/* Arrange to retransmit all messages in the relq. */
 static void bcsp_timed_event(unsigned long arg)
 {
-	struct hci_uart *hu = (struct hci_uart *) arg;
-	struct bcsp_struct *bcsp = hu->priv;
+	struct hci_uart_proto *proto = (struct hci_uart_proto *) arg;
+	struct bcsp_struct *bcsp = proto->priv;
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	BT_DBG("hu %p retransmitting %u pkts", hu, bcsp->unack.qlen);
+	BT_DBG("proto %p retransmitting %u pkts", proto, bcsp->unack.qlen);
 
 	spin_lock_irqsave(&bcsp->unack.lock, flags);
 
@@ -706,27 +712,31 @@
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
-	hci_uart_tx_wakeup(hu);
+	proto->tx_wakeup(proto->tx_wakeup_data);
 }
 
-static int bcsp_open(struct hci_uart *hu)
+static int bcsp_open(struct hci_uart_proto *proto, struct hci_dev *hdev)
 {
 	struct bcsp_struct *bcsp;
 
-	BT_DBG("hu %p", hu);
+	BT_DBG("proto %p", proto);
+
+	if (!proto->tx_wakeup || !proto->tx_wakeup_data)
+		return -EINVAL;
 
 	bcsp = kzalloc(sizeof(*bcsp), GFP_ATOMIC);
 	if (!bcsp)
 		return -ENOMEM;
 
-	hu->priv = bcsp;
+	proto->priv = bcsp;
+	proto->hdev = hdev;
 	skb_queue_head_init(&bcsp->unack);
 	skb_queue_head_init(&bcsp->rel);
 	skb_queue_head_init(&bcsp->unrel);
 
 	init_timer(&bcsp->tbcsp);
 	bcsp->tbcsp.function = bcsp_timed_event;
-	bcsp->tbcsp.data     = (u_long) hu;
+	bcsp->tbcsp.data     = (u_long) proto;
 
 	bcsp->rx_state = BCSP_W4_PKT_DELIMITER;
 
@@ -736,12 +746,12 @@
 	return 0;
 }
 
-static int bcsp_close(struct hci_uart *hu)
+static int bcsp_close(struct hci_uart_proto *proto)
 {
-	struct bcsp_struct *bcsp = hu->priv;
-	hu->priv = NULL;
+	struct bcsp_struct *bcsp = proto->priv;
+	proto->priv = NULL;
 
-	BT_DBG("hu %p", hu);
+	BT_DBG("proto %p", proto);
 
 	skb_queue_purge(&bcsp->unack);
 	skb_queue_purge(&bcsp->rel);
@@ -752,32 +762,23 @@
 	return 0;
 }
 
-static struct hci_uart_proto bcsp = {
+static struct hci_uart_proto_op bcsp = {
 	.id		= HCI_UART_BCSP,
 	.open		= bcsp_open,
 	.close		= bcsp_close,
 	.enqueue	= bcsp_enqueue,
+	.henqueue	= bcsp_henqueue,
 	.dequeue	= bcsp_dequeue,
 	.recv		= bcsp_recv,
 	.flush		= bcsp_flush
 };
 
-int bcsp_init(void)
+struct hci_uart_proto_op *bcsp_init(void)
 {
-	int err = hci_uart_register_proto(&bcsp);
-
-	if (!err)
-		BT_INFO("HCI BCSP protocol initialized");
-	else
-		BT_ERR("HCI BCSP protocol registration failed");
-
-	return err;
+	return &bcsp;
 }
 
-int bcsp_deinit(void)
-{
-	return hci_uart_unregister_proto(&bcsp);
-}
+EXPORT_SYMBOL_GPL(bcsp_init);
 
 module_param(txcrc, bool, 0644);
 MODULE_PARM_DESC(txcrc, "Transmit CRC with every BCSP packet");
diff -ur linux.old/drivers/bluetooth/hci_h4.c linux/drivers/bluetooth/hci_h4.c
--- linux.old/drivers/bluetooth/hci_h4.c	2006-04-22 23:28:15.000000000 +0200
+++ linux/drivers/bluetooth/hci_h4.c	2006-04-29 22:33:24.000000000 +0200
@@ -70,11 +70,11 @@
 #define H4_W4_DATA		4
 
 /* Initialize protocol */
-static int h4_open(struct hci_uart *hu)
+static int h4_open(struct hci_uart_proto *proto, struct hci_dev *hdev)
 {
 	struct h4_struct *h4;
 
-	BT_DBG("hu %p", hu);
+	BT_DBG("proto %p", proto);
 
 	h4 = kzalloc(sizeof(*h4), GFP_ATOMIC);
 	if (!h4)
@@ -82,16 +82,17 @@
 
 	skb_queue_head_init(&h4->txq);
 
-	hu->priv = h4;
+	proto->priv = h4;
+	proto->hdev = hdev;
 	return 0;
 }
 
 /* Flush protocol data */
-static int h4_flush(struct hci_uart *hu)
+static int h4_flush(struct hci_uart_proto *proto)
 {
-	struct h4_struct *h4 = hu->priv;
+	struct h4_struct *h4 = proto->priv;
 
-	BT_DBG("hu %p", hu);
+	BT_DBG("proto %p", proto);
 
 	skb_queue_purge(&h4->txq);
 
@@ -99,31 +100,31 @@
 }
 
 /* Close protocol */
-static int h4_close(struct hci_uart *hu)
+static int h4_close(struct hci_uart_proto *proto)
 {
-	struct h4_struct *h4 = hu->priv;
+	struct h4_struct *h4 = proto->priv;
 
-	hu->priv = NULL;
+	proto->priv = NULL;
 
-	BT_DBG("hu %p", hu);
+	BT_DBG("proto %p", proto);
 
 	skb_queue_purge(&h4->txq);
 
 	if (h4->rx_skb)
 		kfree_skb(h4->rx_skb);
 
-	hu->priv = NULL;
+	proto->priv = NULL;
 	kfree(h4);
 
 	return 0;
 }
 
 /* Enqueue frame for transmittion (padding, crc, etc) */
-static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+static int h4_enqueue(struct hci_uart_proto *proto, struct sk_buff *skb)
 {
-	struct h4_struct *h4 = hu->priv;
+	struct h4_struct *h4 = proto->priv;
 
-	BT_DBG("hu %p skb %p", hu, skb);
+	BT_DBG("proto %p skb %p", proto, skb);
 
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
@@ -132,6 +133,17 @@
 	return 0;
 }
 
+/* Enqueue frame for transmittion (padding, crc, etc) */
+static int h4_henqueue(struct hci_uart_proto *proto, struct sk_buff *skb)
+{
+	struct h4_struct *h4 = proto->priv;
+
+	BT_DBG("proto %p skb %p", proto, skb);
+
+	skb_queue_head(&h4->txq, skb);
+	return 0;
+}
+
 static inline int h4_check_data_len(struct h4_struct *h4, int len)
 {
 	register int room = skb_tailroom(h4->rx_skb);
@@ -157,17 +169,17 @@
 }
 
 /* Recv data */
-static int h4_recv(struct hci_uart *hu, void *data, int count)
+static int h4_recv(struct hci_uart_proto *proto, void *data, int count)
 {
-	struct h4_struct *h4 = hu->priv;
+	struct h4_struct *h4 = proto->priv;
 	register char *ptr;
 	struct hci_event_hdr *eh;
 	struct hci_acl_hdr   *ah;
 	struct hci_sco_hdr   *sh;
 	register int len, type, dlen;
 
-	BT_DBG("hu %p count %d rx_state %ld rx_count %ld", 
-			hu, count, h4->rx_state, h4->rx_count);
+	BT_DBG("proto %p count %d rx_state %ld rx_count %ld", 
+			proto, count, h4->rx_state, h4->rx_count);
 
 	ptr = data;
 	while (count) {
@@ -241,7 +253,7 @@
 
 		default:
 			BT_ERR("Unknown HCI packet type %2.2x", (__u8)*ptr);
-			hu->hdev->stat.err_rx++;
+			proto->hdev->stat.err_rx++;
 			ptr++; count--;
 			continue;
 		};
@@ -257,16 +269,16 @@
 			return 0;
 		}
 
-		h4->rx_skb->dev = (void *) hu->hdev;
+		h4->rx_skb->dev = (void *) proto->hdev;
 		bt_cb(h4->rx_skb)->pkt_type = type;
 	}
 
 	return count;
 }
 
-static struct sk_buff *h4_dequeue(struct hci_uart *hu)
+static struct sk_buff *h4_dequeue(struct hci_uart_proto *proto)
 {
-	struct h4_struct *h4 = hu->priv;
+	struct h4_struct *h4 = proto->priv;
 	return skb_dequeue(&h4->txq);
 }
 
@@ -276,23 +288,14 @@
 	.close		= h4_close,
 	.recv		= h4_recv,
 	.enqueue	= h4_enqueue,
+	.henqueue	= h4_henqueue,
 	.dequeue	= h4_dequeue,
 	.flush		= h4_flush,
 };
 
-int h4_init(void)
+struct hci_uart_proto_op *h4_init(void)
 {
-	int err = hci_uart_register_proto(&h4p);
-
-	if (!err)
-		BT_INFO("HCI H4 protocol initialized");
-	else
-		BT_ERR("HCI H4 protocol registration failed");
-
-	return err;
+	return &h4p;
 }
 
-int h4_deinit(void)
-{
-	return hci_uart_unregister_proto(&h4p);
-}
+EXPORT_SYMBOL_GPL(h4_init);
diff -ur linux.old/drivers/bluetooth/hci_ldisc.c linux/drivers/bluetooth/hci_ldisc.c
--- linux.old/drivers/bluetooth/hci_ldisc.c	2006-04-22 23:28:41.000000000 +0200
+++ linux/drivers/bluetooth/hci_ldisc.c	2006-04-29 22:20:10.000000000 +0200
@@ -57,9 +57,9 @@
 
 static int reset = 0;
 
-static struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
+static struct hci_uart_proto_op *hup[HCI_UART_MAX_PROTO];
 
-int hci_uart_register_proto(struct hci_uart_proto *p)
+int hci_uart_register_proto(struct hci_uart_proto_op *p)
 {
 	if (p->id >= HCI_UART_MAX_PROTO)
 		return -EINVAL;
@@ -72,20 +72,7 @@
 	return 0;
 }
 
-int hci_uart_unregister_proto(struct hci_uart_proto *p)
-{
-	if (p->id >= HCI_UART_MAX_PROTO)
-		return -EINVAL;
-
-	if (!hup[p->id])
-		return -EINVAL;
-
-	hup[p->id] = NULL;
-
-	return 0;
-}
-
-static struct hci_uart_proto *hci_uart_get_proto(unsigned int id)
+static struct hci_uart_proto_op *hci_uart_get_proto(unsigned int id)
 {
 	if (id >= HCI_UART_MAX_PROTO)
 		return NULL;
@@ -118,7 +105,7 @@
 	struct sk_buff *skb = hu->tx_skb;
 
 	if (!skb)
-		skb = hu->proto->dequeue(hu);
+		skb = hu->proto.p->dequeue(&hu->proto);
 	else
 		hu->tx_skb = NULL;
 
@@ -196,7 +183,7 @@
 		tty->driver->flush_buffer(tty);
 
 	if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-		hu->proto->flush(hu);
+		hu->proto.p->flush(&hu->proto);
 
 	return 0;
 }
@@ -233,7 +220,7 @@
 
 	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
-	hu->proto->enqueue(hu, skb);
+	hu->proto.p->enqueue(&hu->proto, skb);
 
 	hci_uart_tx_wakeup(hu);
 
@@ -316,7 +303,7 @@
 		hci_uart_close(hdev);
 
 		if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
-			hu->proto->close(hu);
+			hu->proto.p->close(&hu->proto);
 			hci_unregister_dev(hdev);
 			hci_free_dev(hdev);
 		}
@@ -372,7 +359,7 @@
 		return;
 
 	spin_lock(&hu->rx_lock);
-	hu->proto->recv(hu, (void *) data, count);
+	hu->proto.p->recv(&hu->proto, (void *) data, count);
 	hu->hdev->stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
@@ -383,6 +370,7 @@
 static int hci_uart_register_dev(struct hci_uart *hu)
 {
 	struct hci_dev *hdev;
+	int err;	
 
 	BT_DBG("");
 
@@ -393,6 +381,10 @@
 		return -ENOMEM;
 	}
 
+	err = hu->proto.p->open(&hu->proto, hdev);
+	if (err)
+		return err;
+
 	hu->hdev = hdev;
 
 	hdev->type = HCI_UART;
@@ -420,22 +412,20 @@
 
 static int hci_uart_set_proto(struct hci_uart *hu, int id)
 {
-	struct hci_uart_proto *p;
+	struct hci_uart_proto_op *p;
 	int err;
 
 	p = hci_uart_get_proto(id);
 	if (!p)
 		return -EPROTONOSUPPORT;
 
-	err = p->open(hu);
-	if (err)
-		return err;
-
-	hu->proto = p;
+ 	hu->proto.p = p;
+ 	hu->proto.tx_wakeup_data = hu;;
+ 	hu->proto.tx_wakeup = (int (*)(void *)) hci_uart_tx_wakeup;
 
 	err = hci_uart_register_dev(hu);
 	if (err) {
-		p->close(hu);
+		hu->proto.p->close(&hu->proto);
 		return err;
 	}
 
@@ -481,7 +471,7 @@
 
 	case HCIUARTGETPROTO:
 		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
-			return hu->proto->id;
+			return hu->proto.p->id;
 		return -EUNATCH;
 
 	default:
@@ -541,12 +531,12 @@
 	}
 
 #ifdef CONFIG_BT_HCIUART_H4
-	h4_init();
+	hci_uart_register_proto(h4_init());
 #endif
 #ifdef CONFIG_BT_HCIUART_BCSP
-	bcsp_init();
+	hci_uart_register_proto(bcsp_init());
 #endif
-	
+
 	return 0;
 }
 
@@ -554,13 +544,6 @@
 {
 	int err;
 
-#ifdef CONFIG_BT_HCIUART_H4
-	h4_deinit();
-#endif
-#ifdef CONFIG_BT_HCIUART_BCSP
-	bcsp_deinit();
-#endif
-
 	/* Release tty registration of line discipline */
 	if ((err = tty_unregister_ldisc(N_HCI)))
 		BT_ERR("Can't unregister HCI line discipline (%d)", err);
diff -ur linux.old/drivers/bluetooth/hci_uart.h linux/drivers/bluetooth/hci_uart.h
--- linux.old/drivers/bluetooth/hci_uart.h	2006-04-22 23:28:15.000000000 +0200
+++ linux/drivers/bluetooth/hci_uart.h	2006-04-29 22:20:10.000000000 +0200
@@ -41,14 +41,26 @@
 
 struct hci_uart;
 
+struct hci_uart_proto_op;
+
 struct hci_uart_proto {
+	struct hci_uart_proto_op *p;
+	void               *priv;
+
+	struct hci_dev     *hdev;
+	int (*tx_wakeup) (void *data);
+	void *tx_wakeup_data;
+};
+
+struct hci_uart_proto_op {
 	unsigned int id;
-	int (*open)(struct hci_uart *hu);
-	int (*close)(struct hci_uart *hu);
-	int (*flush)(struct hci_uart *hu);
-	int (*recv)(struct hci_uart *hu, void *data, int len);
-	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
-	struct sk_buff *(*dequeue)(struct hci_uart *hu);
+	int (*open)(struct hci_uart_proto *proto, struct hci_dev *hdev);
+	int (*close)(struct hci_uart_proto *proto);
+	int (*flush)(struct hci_uart_proto *proto);
+	int (*recv)(struct hci_uart_proto *proto, void *data, int len);
+	int (*enqueue)(struct hci_uart_proto *proto, struct sk_buff *skb);
+	int (*henqueue)(struct hci_uart_proto *proto, struct sk_buff *skb);
+	struct sk_buff *(*dequeue)(struct hci_uart_proto *proto);
 };
 
 struct hci_uart {
@@ -57,7 +69,6 @@
 	unsigned long		flags;
 
 	struct hci_uart_proto	*proto;
-	void			*priv;
 
 	struct sk_buff		*tx_skb;
 	unsigned long		tx_state;
@@ -71,16 +82,12 @@
 #define HCI_UART_SENDING	1
 #define HCI_UART_TX_WAKEUP	2
 
-int hci_uart_register_proto(struct hci_uart_proto *p);
-int hci_uart_unregister_proto(struct hci_uart_proto *p);
-int hci_uart_tx_wakeup(struct hci_uart *hu);
+int hci_uart_register_proto(struct hci_uart_proto_op *p);
 
 #ifdef CONFIG_BT_HCIUART_H4
-int h4_init(void);
-int h4_deinit(void);
+struct hci_uart_proto_op *h4_init(void);
 #endif
 
 #ifdef CONFIG_BT_HCIUART_BCSP
-int bcsp_init(void);
-int bcsp_deinit(void);
+struct hci_uart_proto_op *bcsp_init(void);
 #endif

--------------050207000601080107070707--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
