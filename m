Return-Path: <cyrus@holtmann.org>
Sender: Valentin Ilie <eminemix@gmail.com>
From: Valentin Ilie <valentin.ilie@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	Dean_Jenkins@mentor.com
Cc: linux-bluetooth@vger.kernel.org,
	Valentin Ilie <valentin.ilie@gmail.com>
Subject: [PATCH v2] Bluetooth: Remove assignment in if
Date: Mon, 12 Aug 2013 18:46:00 +0300
Message-Id: <1376322360-28824-1-git-send-email-valentin.ilie@gmail.com>
In-Reply-To: <1376225793-22981-1-git-send-email-valentin.ilie@gmail.com>
References: <1376225793-22981-1-git-send-email-valentin.ilie@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Remove assignment in if

Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
---
 drivers/bluetooth/ath3k.c       |  7 +++----
 drivers/bluetooth/bfusb.c       | 14 ++++++++++----
 drivers/bluetooth/bluecard_cs.c |  9 ++++++---
 drivers/bluetooth/bt3c_cs.c     |  7 ++++---
 drivers/bluetooth/btuart_cs.c   |  6 ++++--
 drivers/bluetooth/dtl1_cs.c     |  9 ++++++---
 drivers/bluetooth/hci_bcsp.c    | 26 +++++++++++++++-----------
 drivers/bluetooth/hci_h5.c      |  6 ++++--
 drivers/bluetooth/hci_ldisc.c   |  9 ++++++---
 9 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index a12b923..bdefdfc 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -166,10 +166,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
 	}
 
 	memcpy(send_buf, firmware->data, 20);
-	if ((err = usb_control_msg(udev, pipe,
-				USB_REQ_DFU_DNLOAD,
-				USB_TYPE_VENDOR, 0, 0,
-				send_buf, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
+	err = usb_control_msg(udev, pipe, USB_REQ_DFU_DNLOAD, USB_TYPE_VENDOR,
+				0, 0, send_buf, 20, USB_CTRL_SET_TIMEOUT);
+	if (err < 0) {
 		BT_ERR("Can't change to loading configuration err");
 		goto error;
 	}
diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 995aee9..2306b0b 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -131,8 +131,11 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 
 	BT_DBG("bfusb %p skb %p len %d", data, skb, skb->len);
 
-	if (!urb && !(urb = usb_alloc_urb(0, GFP_ATOMIC)))
-		return -ENOMEM;
+	if (!urb) {
+		urb = usb_alloc_urb(0, GFP_ATOMIC);
+		if (!urb)
+			return -ENOMEM;
+	}
 
 	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
 
@@ -218,8 +221,11 @@ static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
 
 	BT_DBG("bfusb %p urb %p", data, urb);
 
-	if (!urb && !(urb = usb_alloc_urb(0, GFP_ATOMIC)))
-		return -ENOMEM;
+	if (!urb) {
+		urb = usb_alloc_urb(0, GFP_ATOMIC);
+		if (!urb)
+			return -ENOMEM;
+	}
 
 	skb = bt_skb_alloc(size, GFP_ATOMIC);
 	if (!skb) {
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 6c3e3d4..b09e3a9 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -257,7 +257,8 @@ static void bluecard_write_wakeup(bluecard_info_t *info)
 			ready_bit = XMIT_BUF_ONE_READY;
 		}
 
-		if (!(skb = skb_dequeue(&(info->txq))))
+		skb = skb_dequeue(&(info->txq));
+		if (!skb)
 			break;
 
 		if (bt_cb(skb)->pkt_type & 0x80) {
@@ -391,7 +392,8 @@ static void bluecard_receive(bluecard_info_t *info, unsigned int offset)
 		if (info->rx_skb == NULL) {
 			info->rx_state = RECV_WAIT_PACKET_TYPE;
 			info->rx_count = 0;
-			if (!(info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))) {
+			info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!info->rx_skb) {
 				BT_ERR("Can't allocate mem for new packet");
 				return;
 			}
@@ -567,7 +569,8 @@ static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 	/* Ericsson baud rate command */
 	unsigned char cmd[] = { HCI_COMMAND_PKT, 0x09, 0xfc, 0x01, 0x03 };
 
-	if (!(skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))) {
+	skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+	if (!skb) {
 		BT_ERR("Can't allocate mem for new packet");
 		return -1;
 	}
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index a1aaa3b..653c109 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -193,8 +193,8 @@ static void bt3c_write_wakeup(bt3c_info_t *info)
 		if (!pcmcia_dev_present(info->p_dev))
 			break;
 
-
-		if (!(skb = skb_dequeue(&(info->txq)))) {
+		skb = skb_dequeue(&(info->txq));
+		if (!skb) {
 			clear_bit(XMIT_SENDING, &(info->tx_state));
 			break;
 		}
@@ -238,7 +238,8 @@ static void bt3c_receive(bt3c_info_t *info)
 		if (info->rx_skb == NULL) {
 			info->rx_state = RECV_WAIT_PACKET_TYPE;
 			info->rx_count = 0;
-			if (!(info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))) {
+			info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!info->rx_skb) {
 				BT_ERR("Can't allocate mem for new packet");
 				return;
 			}
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index beb262f..4f99e05 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -149,7 +149,8 @@ static void btuart_write_wakeup(btuart_info_t *info)
 		if (!pcmcia_dev_present(info->p_dev))
 			return;
 
-		if (!(skb = skb_dequeue(&(info->txq))))
+		skb = skb_dequeue(&(info->txq));
+		if (!skb)
 			break;
 
 		/* Send frame */
@@ -190,7 +191,8 @@ static void btuart_receive(btuart_info_t *info)
 		if (info->rx_skb == NULL) {
 			info->rx_state = RECV_WAIT_PACKET_TYPE;
 			info->rx_count = 0;
-			if (!(info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))) {
+			info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!info->rx_skb) {
 				BT_ERR("Can't allocate mem for new packet");
 				return;
 			}
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 33f3a69..358694e 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -153,7 +153,8 @@ static void dtl1_write_wakeup(dtl1_info_t *info)
 		if (!pcmcia_dev_present(info->p_dev))
 			return;
 
-		if (!(skb = skb_dequeue(&(info->txq))))
+		skb = skb_dequeue(&(info->txq));
+		if (!skb)
 			break;
 
 		/* Send frame */
@@ -215,13 +216,15 @@ static void dtl1_receive(dtl1_info_t *info)
 		info->hdev->stat.byte_rx++;
 
 		/* Allocate packet */
-		if (info->rx_skb == NULL)
-			if (!(info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))) {
+		if (info->rx_skb == NULL) {
+			info->rx_skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!info->rx_skb) {
 				BT_ERR("Can't allocate mem for new packet");
 				info->rx_state = RECV_WAIT_NSH;
 				info->rx_count = NSHL;
 				return;
 			}
+		}
 
 		*skb_put(info->rx_skb, 1) = inb(iobase + UART_RX);
 		nsh = (nsh_t *)info->rx_skb->data;
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 57e502e..442f836 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -291,7 +291,8 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	/* First of all, check for unreliable messages in the queue,
 	   since they have priority */
 
-	if ((skb = skb_dequeue(&bcsp->unrel)) != NULL) {
+	skb = skb_dequeue(&bcsp->unrel);
+	if (skb != NULL) {
 		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
 		if (nskb) {
 			kfree_skb(skb);
@@ -308,16 +309,19 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 
 	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
-	if (bcsp->unack.qlen < BCSP_TXWINSIZE && (skb = skb_dequeue(&bcsp->rel)) != NULL) {
-		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
-		if (nskb) {
-			__skb_queue_tail(&bcsp->unack, skb);
-			mod_timer(&bcsp->tbcsp, jiffies + HZ / 4);
-			spin_unlock_irqrestore(&bcsp->unack.lock, flags);
-			return nskb;
-		} else {
-			skb_queue_head(&bcsp->rel, skb);
-			BT_ERR("Could not dequeue pkt because alloc_skb failed");
+	if (bcsp->unack.qlen < BCSP_TXWINSIZE) {
+		skb = skb_dequeue(&bcsp->rel);
+		if (skb != NULL) {
+			struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
+			if (nskb) {
+				__skb_queue_tail(&bcsp->unack, skb);
+				mod_timer(&bcsp->tbcsp, jiffies + HZ / 4);
+				spin_unlock_irqrestore(&bcsp->unack.lock, flags);
+				return nskb;
+			} else {
+				skb_queue_head(&bcsp->rel, skb);
+				BT_ERR("Could not dequeue pkt because alloc_skb failed");
+			}
 		}
 	}
 
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index b6154d5..4e75763 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -673,7 +673,8 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 		return h5_prepare_pkt(hu, HCI_3WIRE_LINK_PKT, wakeup_req, 2);
 	}
 
-	if ((skb = skb_dequeue(&h5->unrel)) != NULL) {
+	skb = skb_dequeue(&h5->unrel);
+	if (skb != NULL) {
 		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
 				      skb->data, skb->len);
 		if (nskb) {
@@ -690,7 +691,8 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 	if (h5->unack.qlen >= h5->tx_win)
 		goto unlock;
 
-	if ((skb = skb_dequeue(&h5->rel)) != NULL) {
+	skb = skb_dequeue(&h5->rel);
+	if (skb != NULL) {
 		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
 				      skb->data, skb->len);
 		if (nskb) {
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index bc68a44..4a052b5 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -279,7 +279,8 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EOPNOTSUPP;
 
-	if (!(hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
+	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
+	if (!hu) {
 		BT_ERR("Can't allocate control structure");
 		return -ENFILE;
 	}
@@ -577,7 +578,8 @@ static int __init hci_uart_init(void)
 	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
 	hci_uart_ldisc.owner		= THIS_MODULE;
 
-	if ((err = tty_register_ldisc(N_HCI, &hci_uart_ldisc))) {
+	err = tty_register_ldisc(N_HCI, &hci_uart_ldisc);
+	if (err) {
 		BT_ERR("HCI line discipline registration failed. (%d)", err);
 		return err;
 	}
@@ -622,7 +624,8 @@ static void __exit hci_uart_exit(void)
 #endif
 
 	/* Release tty registration of line discipline */
-	if ((err = tty_unregister_ldisc(N_HCI)))
+	err = tty_unregister_ldisc(N_HCI);
+	if (err)
 		BT_ERR("Can't unregister HCI line discipline (%d)", err);
 }
 
-- 
1.8.1.2
