Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <451A35A1.6020309@brainhub.org>
Date: Wed, 27 Sep 2006 01:26:09 -0700
From: Andrey Jivsov <bluetooth@brainhub.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <451A1A54.3020903@brainhub.org>
	<1159343538.22162.11.camel@localhost>
In-Reply-To: <1159343538.22162.11.camel@localhost>
Content-Type: multipart/mixed; boundary="------------050707010609040808060504"
Subject: Re: [Bluez-users] Microsoft IntelliMouse with kernel 2.6.1 and
 patch-2.6.18-mh1 is broken (fix provided)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050707010609040808060504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel, here is the patch against linux-2.6.18-mh1 to fix 
IntelliMouse. That's the best range of changes I have time to provide: 
somewhere in these changes IntelliMouse was broken. I believe this 
happened between patch-2.6.15-mh2 and linux-2.6.18-mh1. While there are 
a lot of changes in these 17 files, but most of them are variable 
renames. I hope this helps you to narrow down the issue.

[ Does sending compressed patched works? Trying uncompressed first. ]

--------------050707010609040808060504
Content-Type: text/x-patch;
 name="patch-2.6.18-2-mh1aj.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.18-2-mh1aj.diff"

diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/drivers/bluetooth/bfusb.c linux-2.6.18-my-bt/drivers/bluetooth/bfusb.c
--- linux-2.6.18-mh1/drivers/bluetooth/bfusb.c	2006-09-23 19:59:12.000000000 -0700
+++ linux-2.6.18-my-bt/drivers/bluetooth/bfusb.c	2006-09-23 22:53:14.000000000 -0700
@@ -2,7 +2,7 @@
  *
  *  AVM BlueFRITZ! USB driver
  *
- *  Copyright (C) 2003-2006  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2003  Marcel Holtmann <marcel@holtmann.org>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -59,6 +59,7 @@
 
 MODULE_DEVICE_TABLE(usb, bfusb_table);
 
+
 #define BFUSB_MAX_BLOCK_SIZE	256
 
 #define BFUSB_BLOCK_TIMEOUT	3000
@@ -69,7 +70,7 @@
 #define BFUSB_MAX_BULK_TX	2
 #define BFUSB_MAX_BULK_RX	2
 
-struct bfusb_data {
+struct bfusb {
 	struct hci_dev		*hdev;
 
 	unsigned long		state;
@@ -91,136 +92,137 @@
 	struct sk_buff_head	completed_q;
 };
 
-struct bfusb_data_scb {
+struct bfusb_scb {
 	struct urb *urb;
 };
 
 static void bfusb_tx_complete(struct urb *urb, struct pt_regs *regs);
 static void bfusb_rx_complete(struct urb *urb, struct pt_regs *regs);
 
-static struct urb *bfusb_get_completed(struct bfusb_data *data)
+static struct urb *bfusb_get_completed(struct bfusb *bfusb)
 {
 	struct sk_buff *skb;
 	struct urb *urb = NULL;
 
-	BT_DBG("bfusb %p", data);
+	BT_DBG("bfusb %p", bfusb);
 
-	skb = skb_dequeue(&data->completed_q);
+	skb = skb_dequeue(&bfusb->completed_q);
 	if (skb) {
-		urb = ((struct bfusb_data_scb *) skb->cb)->urb;
+		urb = ((struct bfusb_scb *) skb->cb)->urb;
 		kfree_skb(skb);
 	}
 
 	return urb;
 }
 
-static void bfusb_unlink_urbs(struct bfusb_data *data)
+static void bfusb_unlink_urbs(struct bfusb *bfusb)
 {
 	struct sk_buff *skb;
 	struct urb *urb;
 
-	BT_DBG("bfusb %p", data);
+	BT_DBG("bfusb %p", bfusb);
 
-	while ((skb = skb_dequeue(&data->pending_q))) {
-		urb = ((struct bfusb_data_scb *) skb->cb)->urb;
+	while ((skb = skb_dequeue(&bfusb->pending_q))) {
+		urb = ((struct bfusb_scb *) skb->cb)->urb;
 		usb_kill_urb(urb);
-		skb_queue_tail(&data->completed_q, skb);
+		skb_queue_tail(&bfusb->completed_q, skb);
 	}
 
-	while ((urb = bfusb_get_completed(data)))
+	while ((urb = bfusb_get_completed(bfusb)))
 		usb_free_urb(urb);
 }
 
-static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
+
+static int bfusb_send_bulk(struct bfusb *bfusb, struct sk_buff *skb)
 {
-	struct bfusb_data_scb *scb = (void *) skb->cb;
-	struct urb *urb = bfusb_get_completed(data);
+	struct bfusb_scb *scb = (void *) skb->cb;
+	struct urb *urb = bfusb_get_completed(bfusb);
 	int err, pipe;
 
-	BT_DBG("bfusb %p skb %p len %d", data, skb, skb->len);
+	BT_DBG("bfusb %p skb %p len %d", bfusb, skb, skb->len);
 
 	if (!urb && !(urb = usb_alloc_urb(0, GFP_ATOMIC)))
 		return -ENOMEM;
 
-	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
+	pipe = usb_sndbulkpipe(bfusb->udev, bfusb->bulk_out_ep);
 
-	usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, skb->len,
+	usb_fill_bulk_urb(urb, bfusb->udev, pipe, skb->data, skb->len,
 			bfusb_tx_complete, skb);
 
 	scb->urb = urb;
 
-	skb_queue_tail(&data->pending_q, skb);
+	skb_queue_tail(&bfusb->pending_q, skb);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk tx submit failed urb %p err %d", 
-					data->hdev->name, urb, err);
-		skb_unlink(skb, &data->pending_q);
+					bfusb->hdev->name, urb, err);
+		skb_unlink(skb, &bfusb->pending_q);
 		usb_free_urb(urb);
 	} else
-		atomic_inc(&data->pending_tx);
+		atomic_inc(&bfusb->pending_tx);
 
 	return err;
 }
 
-static void bfusb_tx_wakeup(struct bfusb_data *data)
+static void bfusb_tx_wakeup(struct bfusb *bfusb)
 {
 	struct sk_buff *skb;
 
-	BT_DBG("bfusb %p", data);
+	BT_DBG("bfusb %p", bfusb);
 
-	if (test_and_set_bit(BFUSB_TX_PROCESS, &data->state)) {
-		set_bit(BFUSB_TX_WAKEUP, &data->state);
+	if (test_and_set_bit(BFUSB_TX_PROCESS, &bfusb->state)) {
+		set_bit(BFUSB_TX_WAKEUP, &bfusb->state);
 		return;
 	}
 
 	do {
-		clear_bit(BFUSB_TX_WAKEUP, &data->state);
+		clear_bit(BFUSB_TX_WAKEUP, &bfusb->state);
 
-		while ((atomic_read(&data->pending_tx) < BFUSB_MAX_BULK_TX) &&
-				(skb = skb_dequeue(&data->transmit_q))) {
-			if (bfusb_send_bulk(data, skb) < 0) {
-				skb_queue_head(&data->transmit_q, skb);
+		while ((atomic_read(&bfusb->pending_tx) < BFUSB_MAX_BULK_TX) &&
+				(skb = skb_dequeue(&bfusb->transmit_q))) {
+			if (bfusb_send_bulk(bfusb, skb) < 0) {
+				skb_queue_head(&bfusb->transmit_q, skb);
 				break;
 			}
 		}
 
-	} while (test_bit(BFUSB_TX_WAKEUP, &data->state));
+	} while (test_bit(BFUSB_TX_WAKEUP, &bfusb->state));
 
-	clear_bit(BFUSB_TX_PROCESS, &data->state);
+	clear_bit(BFUSB_TX_PROCESS, &bfusb->state);
 }
 
 static void bfusb_tx_complete(struct urb *urb, struct pt_regs *regs)
 {
 	struct sk_buff *skb = (struct sk_buff *) urb->context;
-	struct bfusb_data *data = (struct bfusb_data *) skb->dev;
+	struct bfusb *bfusb = (struct bfusb *) skb->dev;
 
-	BT_DBG("bfusb %p urb %p skb %p len %d", data, urb, skb, skb->len);
+	BT_DBG("bfusb %p urb %p skb %p len %d", bfusb, urb, skb, skb->len);
 
-	atomic_dec(&data->pending_tx);
+	atomic_dec(&bfusb->pending_tx);
 
-	if (!test_bit(HCI_RUNNING, &data->hdev->flags))
+	if (!test_bit(HCI_RUNNING, &bfusb->hdev->flags))
 		return;
 
 	if (!urb->status)
-		data->hdev->stat.byte_tx += skb->len;
+		bfusb->hdev->stat.byte_tx += skb->len;
 	else
-		data->hdev->stat.err_tx++;
+		bfusb->hdev->stat.err_tx++;
 
-	read_lock(&data->lock);
+	read_lock(&bfusb->lock);
 
-	skb_unlink(skb, &data->pending_q);
-	skb_queue_tail(&data->completed_q, skb);
+	skb_unlink(skb, &bfusb->pending_q);
+	skb_queue_tail(&bfusb->completed_q, skb);
 
-	bfusb_tx_wakeup(data);
+	bfusb_tx_wakeup(bfusb);
 
-	read_unlock(&data->lock);
+	read_unlock(&bfusb->lock);
 }
 
 
-static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
+static int bfusb_rx_submit(struct bfusb *bfusb, struct urb *urb)
 {
-	struct bfusb_data_scb *scb;
+	struct bfusb_scb *scb;
 	struct sk_buff *skb;
 	int err, pipe, size = HCI_MAX_FRAME_SIZE + 32;
 
@@ -229,29 +231,28 @@
 	if (!urb && !(urb = usb_alloc_urb(0, GFP_ATOMIC)))
 		return -ENOMEM;
 
-	skb = bt_skb_alloc(size, GFP_ATOMIC);
-	if (!skb) {
+	if (!(skb = bt_skb_alloc(size, GFP_ATOMIC))) {
 		usb_free_urb(urb);
 		return -ENOMEM;
 	}
 
-	skb->dev = (void *) data;
+	skb->dev = (void *) bfusb;
 
-	scb = (struct bfusb_data_scb *) skb->cb;
+	scb = (struct bfusb_scb *) skb->cb;
 	scb->urb = urb;
 
-	pipe = usb_rcvbulkpipe(data->udev, data->bulk_in_ep);
+	pipe = usb_rcvbulkpipe(bfusb->udev, bfusb->bulk_in_ep);
 
-	usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, size,
+	usb_fill_bulk_urb(urb, bfusb->udev, pipe, skb->data, size,
 			bfusb_rx_complete, skb);
 
-	skb_queue_tail(&data->pending_q, skb);
+	skb_queue_tail(&bfusb->pending_q, skb);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk rx submit failed urb %p err %d",
-					data->hdev->name, urb, err);
-		skb_unlink(skb, &data->pending_q);
+					bfusb->hdev->name, urb, err);
+		skb_unlink(skb, &bfusb->pending_q);
 		kfree_skb(skb);
 		usb_free_urb(urb);
 	}
@@ -259,15 +260,15 @@
 	return err;
 }
 
-static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned char *buf, int len)
+static inline int bfusb_recv_block(struct bfusb *bfusb, int hdr, unsigned char *data, int len)
 {
-	BT_DBG("bfusb %p hdr 0x%02x data %p len %d", data, hdr, buf, len);
+	BT_DBG("bfusb %p hdr 0x%02x data %p len %d", bfusb, hdr, data, len);
 
 	if (hdr & 0x10) {
-		BT_ERR("%s error in block", data->hdev->name);
-		if (data->reassembly)
-			kfree_skb(data->reassembly);
-		data->reassembly = NULL;
+		BT_ERR("%s error in block", bfusb->hdev->name);
+		if (bfusb->reassembly)
+			kfree_skb(bfusb->reassembly);
+		bfusb->reassembly = NULL;
 		return -EIO;
 	}
 
@@ -276,46 +277,46 @@
 		unsigned char pkt_type;
 		int pkt_len = 0;
 
-		if (data->reassembly) {
-			BT_ERR("%s unexpected start block", data->hdev->name);
-			kfree_skb(data->reassembly);
-			data->reassembly = NULL;
+		if (bfusb->reassembly) {
+			BT_ERR("%s unexpected start block", bfusb->hdev->name);
+			kfree_skb(bfusb->reassembly);
+			bfusb->reassembly = NULL;
 		}
 
 		if (len < 1) {
-			BT_ERR("%s no packet type found", data->hdev->name);
+			BT_ERR("%s no packet type found", bfusb->hdev->name);
 			return -EPROTO;
 		}
 
-		pkt_type = *buf++; len--;
+		pkt_type = *data++; len--;
 
 		switch (pkt_type) {
 		case HCI_EVENT_PKT:
 			if (len >= HCI_EVENT_HDR_SIZE) {
-				struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+				struct hci_event_hdr *hdr = (struct hci_event_hdr *) data;
 				pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
 			} else {
-				BT_ERR("%s event block is too short", data->hdev->name);
+				BT_ERR("%s event block is too short", bfusb->hdev->name);
 				return -EILSEQ;
 			}
 			break;
 
 		case HCI_ACLDATA_PKT:
 			if (len >= HCI_ACL_HDR_SIZE) {
-				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) data;
 				pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
 			} else {
-				BT_ERR("%s data block is too short", data->hdev->name);
+				BT_ERR("%s data block is too short", bfusb->hdev->name);
 				return -EILSEQ;
 			}
 			break;
 
 		case HCI_SCODATA_PKT:
 			if (len >= HCI_SCO_HDR_SIZE) {
-				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) data;
 				pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
 			} else {
-				BT_ERR("%s audio block is too short", data->hdev->name);
+				BT_ERR("%s audio block is too short", bfusb->hdev->name);
 				return -EILSEQ;
 			}
 			break;
@@ -323,27 +324,27 @@
 
 		skb = bt_skb_alloc(pkt_len, GFP_ATOMIC);
 		if (!skb) {
-			BT_ERR("%s no memory for the packet", data->hdev->name);
+			BT_ERR("%s no memory for the packet", bfusb->hdev->name);
 			return -ENOMEM;
 		}
 
-		skb->dev = (void *) data->hdev;
+		skb->dev = (void *) bfusb->hdev;
 		bt_cb(skb)->pkt_type = pkt_type;
 
-		data->reassembly = skb;
+		bfusb->reassembly = skb;
 	} else {
-		if (!data->reassembly) {
-			BT_ERR("%s unexpected continuation block", data->hdev->name);
+		if (!bfusb->reassembly) {
+			BT_ERR("%s unexpected continuation block", bfusb->hdev->name);
 			return -EIO;
 		}
 	}
 
 	if (len > 0)
-		memcpy(skb_put(data->reassembly, len), buf, len);
+		memcpy(skb_put(bfusb->reassembly, len), data, len);
 
 	if (hdr & 0x08) {
-		hci_recv_frame(data->reassembly);
-		data->reassembly = NULL;
+		hci_recv_frame(bfusb->reassembly);
+		bfusb->reassembly = NULL;
 	}
 
 	return 0;
@@ -352,22 +353,22 @@
 static void bfusb_rx_complete(struct urb *urb, struct pt_regs *regs)
 {
 	struct sk_buff *skb = (struct sk_buff *) urb->context;
-	struct bfusb_data *data = (struct bfusb_data *) skb->dev;
+	struct bfusb *bfusb = (struct bfusb *) skb->dev;
 	unsigned char *buf = urb->transfer_buffer;
 	int count = urb->actual_length;
 	int err, hdr, len;
 
 	BT_DBG("bfusb %p urb %p skb %p len %d", bfusb, urb, skb, skb->len);
 
-	read_lock(&data->lock);
+	read_lock(&bfusb->lock);
 
-	if (!test_bit(HCI_RUNNING, &data->hdev->flags))
+	if (!test_bit(HCI_RUNNING, &bfusb->hdev->flags))
 		goto unlock;
 
 	if (urb->status || !count)
 		goto resubmit;
 
-	data->hdev->stat.byte_rx += count;
+	bfusb->hdev->stat.byte_rx += count;
 
 	skb_put(skb, count);
 
@@ -386,89 +387,90 @@
 
 		if (count < len) {
 			BT_ERR("%s block extends over URB buffer ranges",
-					data->hdev->name);
+					bfusb->hdev->name);
 		}
 
 		if ((hdr & 0xe1) == 0xc1)
-			bfusb_recv_block(data, hdr, buf, len);
+			bfusb_recv_block(bfusb, hdr, buf, len);
 
 		count -= len;
 		buf   += len;
 	}
 
-	skb_unlink(skb, &data->pending_q);
+	skb_unlink(skb, &bfusb->pending_q);
 	kfree_skb(skb);
 
-	bfusb_rx_submit(data, urb);
+	bfusb_rx_submit(bfusb, urb);
 
-	read_unlock(&data->lock);
+	read_unlock(&bfusb->lock);
 
 	return;
 
 resubmit:
-	urb->dev = data->udev;
+	urb->dev = bfusb->udev;
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
 		BT_ERR("%s bulk resubmit failed urb %p err %d",
-					data->hdev->name, urb, err);
+					bfusb->hdev->name, urb, err);
 	}
 
 unlock:
-	read_unlock(&data->lock);
+	read_unlock(&bfusb->lock);
 }
 
+
 static int bfusb_open(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb *bfusb = (struct bfusb *) hdev->driver_data;
 	unsigned long flags;
 	int i, err;
 
-	BT_DBG("hdev %p bfusb %p", hdev, data);
+	BT_DBG("hdev %p bfusb %p", hdev, bfusb);
 
 	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
-	write_lock_irqsave(&data->lock, flags);
+	write_lock_irqsave(&bfusb->lock, flags);
 
-	err = bfusb_rx_submit(data, NULL);
+	err = bfusb_rx_submit(bfusb, NULL);
 	if (!err) {
 		for (i = 1; i < BFUSB_MAX_BULK_RX; i++)
-			bfusb_rx_submit(data, NULL);
+			bfusb_rx_submit(bfusb, NULL);
 	} else {
 		clear_bit(HCI_RUNNING, &hdev->flags);
 	}
 
-	write_unlock_irqrestore(&data->lock, flags);
+	write_unlock_irqrestore(&bfusb->lock, flags);
 
 	return err;
 }
 
 static int bfusb_flush(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb *bfusb = (struct bfusb *) hdev->driver_data;
 
-	BT_DBG("hdev %p bfusb %p", hdev, data);
+	BT_DBG("hdev %p bfusb %p", hdev, bfusb);
 
-	skb_queue_purge(&data->transmit_q);
+	skb_queue_purge(&bfusb->transmit_q);
 
 	return 0;
 }
 
 static int bfusb_close(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb *bfusb = (struct bfusb *) hdev->driver_data;
 	unsigned long flags;
 
-	BT_DBG("hdev %p bfusb %p", hdev, data);
+	BT_DBG("hdev %p bfusb %p", hdev, bfusb);
 
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
-	write_lock_irqsave(&data->lock, flags);
-	write_unlock_irqrestore(&data->lock, flags);
+	write_lock_irqsave(&bfusb->lock, flags);
+	write_unlock_irqrestore(&bfusb->lock, flags);
 
-	bfusb_unlink_urbs(data);
+	bfusb_unlink_urbs(bfusb);
 	bfusb_flush(hdev);
 
 	return 0;
@@ -477,7 +479,7 @@
 static int bfusb_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
-	struct bfusb_data *data;
+	struct bfusb *bfusb;
 	struct sk_buff *nskb;
 	unsigned char buf[3];
 	int sent = 0, size, count;
@@ -492,7 +494,7 @@
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	data = hdev->driver_data;
+	bfusb = (struct bfusb *) hdev->driver_data;
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -512,13 +514,12 @@
 	count = skb->len;
 
 	/* Max HCI frame size seems to be 1511 + 1 */
-	nskb = bt_skb_alloc(count + 32, GFP_ATOMIC);
-	if (!nskb) {
+	if (!(nskb = bt_skb_alloc(count + 32, GFP_ATOMIC))) {
 		BT_ERR("Can't allocate memory for new packet");
 		return -ENOMEM;
 	}
 
-	nskb->dev = (void *) data;
+	nskb->dev = (void *) bfusb;
 
 	while (count) {
 		size = min_t(uint, count, BFUSB_MAX_BLOCK_SIZE);
@@ -535,18 +536,18 @@
 	}
 
 	/* Don't send frame with multiple size of bulk max packet */
-	if ((nskb->len % data->bulk_pkt_size) == 0) {
+	if ((nskb->len % bfusb->bulk_pkt_size) == 0) {
 		buf[0] = 0xdd;
 		buf[1] = 0x00;
 		memcpy(skb_put(nskb, 2), buf, 2);
 	}
 
-	read_lock(&data->lock);
+	read_lock(&bfusb->lock);
 
-	skb_queue_tail(&data->transmit_q, nskb);
-	bfusb_tx_wakeup(data);
+	skb_queue_tail(&bfusb->transmit_q, nskb);
+	bfusb_tx_wakeup(bfusb);
 
-	read_unlock(&data->lock);
+	read_unlock(&bfusb->lock);
 
 	kfree_skb(skb);
 
@@ -555,11 +556,11 @@
 
 static void bfusb_destruct(struct hci_dev *hdev)
 {
-	struct bfusb_data *data = hdev->driver_data;
+	struct bfusb *bfusb = (struct bfusb *) hdev->driver_data;
 
-	BT_DBG("hdev %p bfusb %p", hdev, data);
+	BT_DBG("hdev %p bfusb %p", hdev, bfusb);
 
-	kfree(data);
+	kfree(bfusb);
 }
 
 static int bfusb_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
@@ -567,24 +568,25 @@
 	return -ENOIOCTLCMD;
 }
 
-static int bfusb_load_firmware(struct bfusb_data *data, unsigned char *firmware, int count)
+
+static int bfusb_load_firmware(struct bfusb *bfusb, unsigned char *firmware, int count)
 {
 	unsigned char *buf;
 	int err, pipe, len, size, sent = 0;
 
-	BT_DBG("bfusb %p udev %p", data, data->udev);
+	BT_DBG("bfusb %p udev %p", bfusb, bfusb->udev);
 
 	BT_INFO("BlueFRITZ! USB loading firmware");
 
-	pipe = usb_sndctrlpipe(data->udev, 0);
+	pipe = usb_sndctrlpipe(bfusb->udev, 0);
 
-	if (usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
+	if (usb_control_msg(bfusb->udev, pipe, USB_REQ_SET_CONFIGURATION,
 				0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
 		BT_ERR("Can't change to loading configuration");
 		return -EBUSY;
 	}
 
-	data->udev->toggle[0] = data->udev->toggle[1] = 0;
+	bfusb->udev->toggle[0] = bfusb->udev->toggle[1] = 0;
 
 	buf = kmalloc(BFUSB_MAX_BLOCK_SIZE + 3, GFP_ATOMIC);
 	if (!buf) {
@@ -592,14 +594,14 @@
 		return -ENOMEM;
 	}
 
-	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
+	pipe = usb_sndbulkpipe(bfusb->udev, bfusb->bulk_out_ep);
 
 	while (count) {
 		size = min_t(uint, count, BFUSB_MAX_BLOCK_SIZE + 3);
 
 		memcpy(buf, firmware + sent, size);
 
-		err = usb_bulk_msg(data->udev, pipe, buf, size,
+		err = usb_bulk_msg(bfusb->udev, pipe, buf, size,
 					&len, BFUSB_BLOCK_TIMEOUT);
 
 		if (err || (len != size)) {
@@ -611,23 +613,21 @@
 		count -= size;
 	}
 
-	err = usb_bulk_msg(data->udev, pipe, NULL, 0,
-					&len, BFUSB_BLOCK_TIMEOUT);
-	if (err < 0) {
+	if ((err = usb_bulk_msg(bfusb->udev, pipe, NULL, 0,
+				&len, BFUSB_BLOCK_TIMEOUT)) < 0) {
 		BT_ERR("Error in null packet request");
 		goto error;
 	}
 
-	pipe = usb_sndctrlpipe(data->udev, 0);
+	pipe = usb_sndctrlpipe(bfusb->udev, 0);
 
-	err = usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
-	if (err < 0) {
+        if ((err = usb_control_msg(bfusb->udev, pipe, USB_REQ_SET_CONFIGURATION,
+				0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT)) < 0) {
 		BT_ERR("Can't change to running configuration");
 		goto error;
 	}
 
-	data->udev->toggle[0] = data->udev->toggle[1] = 0;
+	bfusb->udev->toggle[0] = bfusb->udev->toggle[1] = 0;
 
 	BT_INFO("BlueFRITZ! USB device ready");
 
@@ -637,9 +637,9 @@
 error:
 	kfree(buf);
 
-	pipe = usb_sndctrlpipe(data->udev, 0);
+	pipe = usb_sndctrlpipe(bfusb->udev, 0);
 
-	usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
+	usb_control_msg(bfusb->udev, pipe, USB_REQ_SET_CONFIGURATION,
 				0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 
 	return err;
@@ -652,7 +652,7 @@
 	struct usb_host_endpoint *bulk_out_ep;
 	struct usb_host_endpoint *bulk_in_ep;
 	struct hci_dev *hdev;
-	struct bfusb_data *data;
+	struct bfusb *bfusb;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -672,24 +672,23 @@
 	}
 
 	/* Initialize control structure and load firmware */
-	data = kzalloc(sizeof(struct bfusb_data), GFP_KERNEL);
-	if (!data) {
+	if (!(bfusb = kzalloc(sizeof(struct bfusb), GFP_KERNEL))) {
 		BT_ERR("Can't allocate memory for control structure");
 		goto done;
 	}
 
-	data->udev = udev;
-	data->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
-	data->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
-	data->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
-
-	rwlock_init(&data->lock);
-
-	data->reassembly = NULL;
-
-	skb_queue_head_init(&data->transmit_q);
-	skb_queue_head_init(&data->pending_q);
-	skb_queue_head_init(&data->completed_q);
+	bfusb->udev = udev;
+	bfusb->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
+	bfusb->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
+	bfusb->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
+
+	rwlock_init(&bfusb->lock);
+
+	bfusb->reassembly = NULL;
+
+	skb_queue_head_init(&bfusb->transmit_q);
+	skb_queue_head_init(&bfusb->pending_q);
+	skb_queue_head_init(&bfusb->completed_q);
 
 	if (request_firmware(&firmware, "bfubase.frm", &udev->dev) < 0) {
 		BT_ERR("Firmware request failed");
@@ -698,7 +697,7 @@
 
 	BT_DBG("firmware data %p size %d", firmware->data, firmware->size);
 
-	if (bfusb_load_firmware(data, firmware->data, firmware->size) < 0) {
+	if (bfusb_load_firmware(bfusb, firmware->data, firmware->size) < 0) {
 		BT_ERR("Firmware loading failed");
 		goto release;
 	}
@@ -712,10 +711,10 @@
 		goto error;
 	}
 
-	data->hdev = hdev;
+	bfusb->hdev = hdev;
 
 	hdev->type = HCI_USB;
-	hdev->driver_data = data;
+	hdev->driver_data = bfusb;
 	SET_HCIDEV_DEV(hdev, &intf->dev);
 
 	hdev->open     = bfusb_open;
@@ -733,7 +732,7 @@
 		goto error;
 	}
 
-	usb_set_intfdata(intf, data);
+	usb_set_intfdata(intf, bfusb);
 
 	return 0;
 
@@ -741,7 +740,7 @@
 	release_firmware(firmware);
 
 error:
-	kfree(data);
+	kfree(bfusb);
 
 done:
 	return -EIO;
@@ -749,8 +748,8 @@
 
 static void bfusb_disconnect(struct usb_interface *intf)
 {
-	struct bfusb_data *data = usb_get_intfdata(intf);
-	struct hci_dev *hdev = data->hdev;
+	struct bfusb *bfusb = usb_get_intfdata(intf);
+	struct hci_dev *hdev = bfusb->hdev;
 
 	BT_DBG("intf %p", intf);
 
@@ -780,8 +779,7 @@
 
 	BT_INFO("BlueFRITZ! USB driver ver %s", VERSION);
 
-	err = usb_register(&bfusb_driver);
-	if (err < 0)
+	if ((err = usb_register(&bfusb_driver)) < 0)
 		BT_ERR("Failed to register BlueFRITZ! USB driver");
 
 	return err;
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/drivers/bluetooth/hci_ldisc.c linux-2.6.18-my-bt/drivers/bluetooth/hci_ldisc.c
--- linux-2.6.18-mh1/drivers/bluetooth/hci_ldisc.c	2006-09-23 19:59:12.000000000 -0700
+++ linux-2.6.18-my-bt/drivers/bluetooth/hci_ldisc.c	2006-09-23 22:53:14.000000000 -0700
@@ -241,11 +241,15 @@
 
 static void hci_uart_destruct(struct hci_dev *hdev)
 {
+	struct hci_uart *hu;
+
 	if (!hdev)
 		return;
 
 	BT_DBG("%s", hdev->name);
-	kfree(hdev->driver_data);
+
+	hu = (struct hci_uart *) hdev->driver_data;
+	kfree(hu);
 }
 
 /* ------ LDISC part ------ */
@@ -268,7 +272,7 @@
 		return -EEXIST;
 
 	if (!(hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
-		BT_ERR("Can't allocate control structure");
+		BT_ERR("Can't allocate controll structure");
 		return -ENFILE;
 	}
 
@@ -356,7 +360,7 @@
  *     
  * Return Value:    None
  */
-static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
+static void hci_uart_tty_receive(struct tty_struct *tty, const __u8 *data, char *flags, int count)
 {
 	struct hci_uart *hu = (void *)tty->disc_data;
 
@@ -371,8 +375,7 @@
 	hu->hdev->stat.byte_rx += count;
 	spin_unlock(&hu->rx_lock);
 
-	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags) &&
-					tty->driver->unthrottle)
+	if (test_and_clear_bit(TTY_THROTTLED,&tty->flags) && tty->driver->unthrottle)
 		tty->driver->unthrottle(tty);
 }
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/drivers/bluetooth/hci_usb.c linux-2.6.18-my-bt/drivers/bluetooth/hci_usb.c
--- linux-2.6.18-mh1/drivers/bluetooth/hci_usb.c	2006-09-23 19:59:11.000000000 -0700
+++ linux-2.6.18-my-bt/drivers/bluetooth/hci_usb.c	2006-09-23 22:53:13.000000000 -0700
@@ -96,9 +96,6 @@
 	/* Ericsson with non-standard id */
 	{ USB_DEVICE(0x0bdb, 0x1002) },
 
-	/* Canyon CN-BTU1 with HID interfaces */
-	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = HCI_RESET },
-
 	{ }	/* Terminating entry */
 };
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/drivers/bluetooth/hci_vhci.c linux-2.6.18-my-bt/drivers/bluetooth/hci_vhci.c
--- linux-2.6.18-mh1/drivers/bluetooth/hci_vhci.c	2006-09-23 19:59:12.000000000 -0700
+++ linux-2.6.18-my-bt/drivers/bluetooth/hci_vhci.c	2006-09-23 22:53:14.000000000 -0700
@@ -2,9 +2,9 @@
  *
  *  Bluetooth virtual HCI driver
  *
- *  Copyright (C) 2000-2001  Qualcomm Incorporated
- *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
- *  Copyright (C) 2004-2006  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2000-2001 Qualcomm Incorporated
+ *  Copyright (C) 2002-2003 Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2004-2005 Marcel Holtmann <marcel@holtmann.org>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -72,21 +72,21 @@
 
 static int vhci_close_dev(struct hci_dev *hdev)
 {
-	struct vhci_data *data = hdev->driver_data;
+	struct vhci_data *vhci = hdev->driver_data;
 
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
-	skb_queue_purge(&data->readq);
+	skb_queue_purge(&vhci->readq);
 
 	return 0;
 }
 
 static int vhci_flush(struct hci_dev *hdev)
 {
-	struct vhci_data *data = hdev->driver_data;
+	struct vhci_data *vhci = hdev->driver_data;
 
-	skb_queue_purge(&data->readq);
+	skb_queue_purge(&vhci->readq);
 
 	return 0;
 }
@@ -94,7 +94,7 @@
 static int vhci_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev* hdev = (struct hci_dev *) skb->dev;
-	struct vhci_data *data;
+	struct vhci_data *vhci;
 
 	if (!hdev) {
 		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
@@ -104,15 +104,15 @@
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	data = hdev->driver_data;
+	vhci = hdev->driver_data;
 
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
-	skb_queue_tail(&data->readq, skb);
+	skb_queue_tail(&vhci->readq, skb);
 
-	if (data->flags & VHCI_FASYNC)
-		kill_fasync(&data->fasync, SIGIO, POLL_IN);
+	if (vhci->flags & VHCI_FASYNC)
+		kill_fasync(&vhci->fasync, SIGIO, POLL_IN);
 
-	wake_up_interruptible(&data->read_wait);
+	wake_up_interruptible(&vhci->read_wait);
 
 	return 0;
 }
@@ -122,7 +122,7 @@
 	kfree(hdev->driver_data);
 }
 
-static inline ssize_t vhci_get_user(struct vhci_data *data,
+static inline ssize_t vhci_get_user(struct vhci_data *vhci,
 					const char __user *buf, size_t count)
 {
 	struct sk_buff *skb;
@@ -139,7 +139,7 @@
 		return -EFAULT;
 	}
 
-	skb->dev = (void *) data->hdev;
+	skb->dev = (void *) vhci->hdev;
 	bt_cb(skb)->pkt_type = *((__u8 *) skb->data);
 	skb_pull(skb, 1);
 
@@ -148,7 +148,7 @@
 	return count;
 }
 
-static inline ssize_t vhci_put_user(struct vhci_data *data,
+static inline ssize_t vhci_put_user(struct vhci_data *vhci,
 			struct sk_buff *skb, char __user *buf, int count)
 {
 	char __user *ptr = buf;
@@ -161,43 +161,42 @@
 
 	total += len;
 
-	data->hdev->stat.byte_tx += len;
+	vhci->hdev->stat.byte_tx += len;
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
-		data->hdev->stat.cmd_tx++;
+		vhci->hdev->stat.cmd_tx++;
 		break;
 
 	case HCI_ACLDATA_PKT:
-		data->hdev->stat.acl_tx++;
+		vhci->hdev->stat.acl_tx++;
 		break;
 
 	case HCI_SCODATA_PKT:
-		data->hdev->stat.cmd_tx++;
+		vhci->hdev->stat.cmd_tx++;
 		break;
 	};
 
 	return total;
 }
 
-static loff_t vhci_llseek(struct file *file, loff_t offset, int origin)
+static loff_t vhci_llseek(struct file * file, loff_t offset, int origin)
 {
 	return -ESPIPE;
 }
 
-static ssize_t vhci_read(struct file *file,
-				char __user *buf, size_t count, loff_t *pos)
+static ssize_t vhci_read(struct file * file, char __user * buf, size_t count, loff_t *pos)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *vhci = file->private_data;
 	struct sk_buff *skb;
 	ssize_t ret = 0;
 
-	add_wait_queue(&data->read_wait, &wait);
+	add_wait_queue(&vhci->read_wait, &wait);
 	while (count) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		skb = skb_dequeue(&data->readq);
+		skb = skb_dequeue(&vhci->readq);
 		if (!skb) {
 			if (file->f_flags & O_NONBLOCK) {
 				ret = -EAGAIN;
@@ -214,7 +213,7 @@
 		}
 
 		if (access_ok(VERIFY_WRITE, buf, count))
-			ret = vhci_put_user(data, skb, buf, count);
+			ret = vhci_put_user(vhci, skb, buf, count);
 		else
 			ret = -EFAULT;
 
@@ -222,7 +221,7 @@
 		break;
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&data->read_wait, &wait);
+	remove_wait_queue(&vhci->read_wait, &wait);
 
 	return ret;
 }
@@ -230,21 +229,21 @@
 static ssize_t vhci_write(struct file *file,
 			const char __user *buf, size_t count, loff_t *pos)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *vhci = file->private_data;
 
 	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
-	return vhci_get_user(data, buf, count);
+	return vhci_get_user(vhci, buf, count);
 }
 
 static unsigned int vhci_poll(struct file *file, poll_table *wait)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *vhci = file->private_data;
 
-	poll_wait(file, &data->read_wait, wait);
+	poll_wait(file, &vhci->read_wait, wait);
 
-	if (!skb_queue_empty(&data->readq))
+	if (!skb_queue_empty(&vhci->readq))
 		return POLLIN | POLLRDNORM;
 
 	return POLLOUT | POLLWRNORM;
@@ -258,26 +257,26 @@
 
 static int vhci_open(struct inode *inode, struct file *file)
 {
-	struct vhci_data *data;
+	struct vhci_data *vhci;
 	struct hci_dev *hdev;
 
-	data = kzalloc(sizeof(struct vhci_data), GFP_KERNEL);
-	if (!data)
+	vhci = kzalloc(sizeof(struct vhci_data), GFP_KERNEL);
+	if (!vhci)
 		return -ENOMEM;
 
-	skb_queue_head_init(&data->readq);
-	init_waitqueue_head(&data->read_wait);
+	skb_queue_head_init(&vhci->readq);
+	init_waitqueue_head(&vhci->read_wait);
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
-		kfree(data);
+		kfree(vhci);
 		return -ENOMEM;
 	}
 
-	data->hdev = hdev;
+	vhci->hdev = hdev;
 
-	hdev->type = HCI_VIRTUAL;
-	hdev->driver_data = data;
+	hdev->type = HCI_VHCI;
+	hdev->driver_data = vhci;
 
 	hdev->open     = vhci_open_dev;
 	hdev->close    = vhci_close_dev;
@@ -289,20 +288,20 @@
 
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
-		kfree(data);
+		kfree(vhci);
 		hci_free_dev(hdev);
 		return -EBUSY;
 	}
 
-	file->private_data = data;
+	file->private_data = vhci;
 
 	return nonseekable_open(inode, file);
 }
 
 static int vhci_release(struct inode *inode, struct file *file)
 {
-	struct vhci_data *data = file->private_data;
-	struct hci_dev *hdev = data->hdev;
+	struct vhci_data *vhci = file->private_data;
+	struct hci_dev *hdev = vhci->hdev;
 
 	if (hci_unregister_dev(hdev) < 0) {
 		BT_ERR("Can't unregister HCI device %s", hdev->name);
@@ -317,17 +316,17 @@
 
 static int vhci_fasync(int fd, struct file *file, int on)
 {
-	struct vhci_data *data = file->private_data;
+	struct vhci_data *vhci = file->private_data;
 	int err;
 
-	err = fasync_helper(fd, file, on, &data->fasync);
+	err = fasync_helper(fd, file, on, &vhci->fasync);
 	if (err < 0)
 		return err;
 
 	if (on)
-		data->flags |= VHCI_FASYNC;
+		vhci->flags |= VHCI_FASYNC;
 	else
-		data->flags &= ~VHCI_FASYNC;
+		vhci->flags &= ~VHCI_FASYNC;
 
 	return 0;
 }

diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/include/net/bluetooth/hci_core.h linux-2.6.18-my-bt/include/net/bluetooth/hci_core.h
--- linux-2.6.18-mh1/include/net/bluetooth/hci_core.h	2006-09-23 20:00:59.000000000 -0700
+++ linux-2.6.18-my-bt/include/net/bluetooth/hci_core.h	2006-09-23 22:54:33.000000000 -0700
@@ -165,10 +165,6 @@
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
 
-	struct work_struct work;
-
-	struct device	dev;
-
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
@@ -416,8 +412,6 @@
 
 int hci_register_sysfs(struct hci_dev *hdev);
 void hci_unregister_sysfs(struct hci_dev *hdev);
-void hci_conn_add_sysfs(struct hci_conn *conn);
-void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define SET_HCIDEV_DEV(hdev, pdev) ((hdev)->parent = (pdev))
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/include/net/bluetooth/hci.h linux-2.6.18-my-bt/include/net/bluetooth/hci.h
--- linux-2.6.18-mh1/include/net/bluetooth/hci.h	2006-09-23 20:00:59.000000000 -0700
+++ linux-2.6.18-my-bt/include/net/bluetooth/hci.h	2006-09-23 22:54:33.000000000 -0700
@@ -44,13 +44,12 @@
 #define HCI_NOTIFY_VOICE_SETTING	3
 
 /* HCI device types */
-#define HCI_VIRTUAL	0
+#define HCI_VHCI	0
 #define HCI_USB		1
 #define HCI_PCCARD	2
 #define HCI_UART	3
 #define HCI_RS232	4
 #define HCI_PCI		5
-#define HCI_SDIO	6
 
 /* HCI device quirks */
 enum {
@@ -340,8 +339,6 @@
 
 #define OCF_INQUIRY_CANCEL	0x0002
 
-#define OCF_EXIT_PERIODIC_INQ	0x0004
-
 #define OCF_LINK_KEY_REPLY	0x000B
 struct hci_cp_link_key_reply {
 	bdaddr_t bdaddr;
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/include/net/bluetooth/l2cap.h linux-2.6.18-my-bt/include/net/bluetooth/l2cap.h
--- linux-2.6.18-mh1/include/net/bluetooth/l2cap.h	2006-09-23 20:00:59.000000000 -0700
+++ linux-2.6.18-my-bt/include/net/bluetooth/l2cap.h	2006-09-23 23:00:22.000000000 -0700
@@ -27,19 +27,7 @@
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU	672
-#define L2CAP_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
-#define L2CAP_DEFAULT_TXW 	32
-#define L2CAP_MIN_TXW		1
-#define L2CAP_MAX_TXW		32
-#define L2CAP_DEFAULT_MAXT 	32
-#define L2CAP_DEFAULT_RETTO 	1000
-#define L2CAP_DEFAULT_MONTO 	1000
-#define L2CAP_DEFAULT_MPS 	65531
-#define L2CAP_MAX_MPS		65531
-
-/* maximum possible options for one request/response */
-#define L2CAP_MAX_OPTS 		128
 
 #define L2CAP_CONN_TIMEOUT	(HZ * 40)
 
@@ -59,10 +47,6 @@
 	__u8  mode;
 };
 
-#define L2CAP_MODE_BASIC	0x00
-#define L2CAP_MODE_RET		0x01
-#define L2CAP_MODE_FLOW		0x02
-
 #define L2CAP_CONNINFO	0x02
 struct l2cap_conninfo {
 	__u16 hci_handle;
@@ -106,14 +90,8 @@
 
 struct l2cap_cmd_rej {
 	__le16     reason;
-	__le16     data[0];
 } __attribute__ ((packed));
 
-/* command reject reasons */
-#define L2CAP_CMD_NOT_UNDERSTOOD 	0x0000
-#define L2CAP_MTU_EXCEEDED 		0x0001
-#define L2CAP_INVALID_CID 		0x0002
-
 struct l2cap_conn_req {
 	__le16     psm;
 	__le16     scid;
@@ -151,10 +129,8 @@
 	__u8       data[0];
 } __attribute__ ((packed));
 
-#define L2CAP_CONF_SUCCESS	0x0000
-#define L2CAP_CONF_UNACCEPT	0x0001
-#define L2CAP_CONF_REJ		0x0002
-#define L2CAP_CONF_UNKNOWN	0x0003
+#define L2CAP_CONF_SUCCESS	0x00
+#define L2CAP_CONF_UNACCEPT	0x01
 
 struct l2cap_conf_opt {
 	__u8       type;
@@ -170,15 +146,6 @@
 
 #define L2CAP_CONF_MAX_SIZE	22
 
-struct l2cap_conf_rfc {
-	__u8	mode;
-	__u8	txw;
-	__u8	maxt;
-	__le16	ret_to;
-	__le16	mon_to;
-	__le16	mps;
-} __attribute__ ((packed));
-
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
@@ -191,6 +158,7 @@
 
 struct l2cap_info_req {
 	__le16      type;
+	__u8        data[0];
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
@@ -200,17 +168,12 @@
 } __attribute__ ((packed));
 
 /* info type */
-#define L2CAP_IT_CL_MTU		0x0001
-#define L2CAP_IT_FEAT_MASK	0x0002
-
-/* bits for extended features */
-#define L2CAP_EXT_FCM		0x0001
-#define L2CAP_EXT_RTM		0x0002
-#define L2CAP_EXT_QOS		0x0004
+#define L2CAP_IT_CL_MTU     0x0001
+#define L2CAP_IT_FEAT_MASK  0x0002
 
 /* info result */
-#define L2CAP_IR_SUCCESS	0x0000
-#define L2CAP_IR_NOTSUPP	0x0001
+#define L2CAP_IR_SUCCESS    0x0000
+#define L2CAP_IR_NOTSUPP    0x0001
 
 /* ----- L2CAP connections ----- */
 struct l2cap_chan_list {
@@ -250,103 +213,24 @@
 	__u16		imtu;
 	__u16		omtu;
 	__u16		flush_to;
-	__u8		mode;
 
 	__u32		link_mode;
-	/* connectionless MTU size from info response */
-	__u16		info_mtu;
-	/* extended feature mask from info response */
-	__u32		info_ext;
 
-	/* bitmask for current config state */
-	__u16		conf_state;
+	__u8		conf_state;
 	__u8		conf_retry;
 	__u16		conf_mtu;
 
-	/* Configuration Request RFC Options */
-	__u8		conf_mode;
-	__u8		conf_txw;
-	__u8		conf_maxt;
-	__u16		conf_ret_to;
-	__u16		conf_mon_to;
-	__u16		conf_mps;
-
-	/* incoming RFC Options */
-	__u8		itxw;
-	__u8		imaxt;
-	__u16		iret_to;
-	__u16		imon_to;
-	__u16		imps;
-
-	/* outgoing RFC Options */
-	__u8		otxw;
-	__u8		omaxt;
-	__u16		oret_to;
-	__u16		omon_to;
-	__u16		omps;
-
-	/* flow control mode */
-	__u8		tx_seq;
-	__u8		next_txseq;
-	__u8		exp_ackseq;
-	__u8		req_seq;
-	__u8		exp_txseq;
-	__u8		buffer_seq;
-	__u16		sdu_len;
-	struct sk_buff	*sdu;
-
-	__u32			tx_queue_frames;
-	struct sk_buff_head 	tx_queue;
-
 	__u8		ident;
 
-	struct timer_list	ret_timer;
-	struct timer_list	mon_timer;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
 	struct sock		*prev_c;
 };
 
-#define L2CAP_CONF_MAX_RETRIES	2
-
-/* different conf_states */
-#define L2CAP_INFO_REQ_SENT 	0x01
-#define L2CAP_CONF_REQ_SENT 	0x02
-#define L2CAP_CONF_INPUT_DONE	0x04
-#define L2CAP_CONF_OUTPUT_DONE	0x08
-#define L2CAP_CONF_UNACCEPT_MTU	0x10
-#define L2CAP_CONF_UNACCEPT_RFC	0x20
-#define L2CAP_INFO_INPUT_DONE	0x40
-
-/* RFC definitions */
-#define L2CAP_MAX_DATA_LEN	65531
-#define L2CAP_CONTROL_SIZE	2
-#define L2CAP_FCS_SIZE		2
-#define L2CAP_SFRAME_SIZE	8
-
-#define L2CAP_SAR_UNSEGMENTED	0x0000
-#define L2CAP_SAR_START		0x4000
-#define L2CAP_SAR_END		0x8000
-#define L2CAP_SAR_CONTINUE	0xC000
-#define L2CAP_SAR_MASK		0xC000
-#define L2CAP_TXSEQ_MASK	0x007E
-#define L2CAP_REQSEQ_MASK	0x3F00
-
-#define L2CAP_GET_TXSEQ(control)	((__le16_to_cpu(control) \
-			& L2CAP_TXSEQ_MASK) >> 1)
-#define L2CAP_GET_REQSEQ(control)	((__le16_to_cpu(control) \
-			& L2CAP_REQSEQ_MASK) >> 8)
-#define L2CAP_GET_SAR(control)		(__le16_to_cpu(control) & L2CAP_SAR_MASK)
-
-#define L2CAP_SET_TXSEQ(control, txseq) 	control = \
-			(__cpu_to_le16((txseq  << 1) & L2CAP_TXSEQ_MASK)) | \
-			(__cpu_to_le16(control) & ~L2CAP_TXSEQ_MASK)
-#define L2CAP_SET_REQSEQ(control, reqseq) 	control = \
-			(__cpu_to_le16((reqseq << 8) & L2CAP_REQSEQ_MASK)) | \
-			(__cpu_to_le16(control) & ~L2CAP_REQSEQ_MASK)
-#define L2CAP_SET_SAR(control, sar) 		control = \
-			(__cpu_to_le16(sar & L2CAP_SAR_MASK)) |           \
-			(__cpu_to_le16(control) & ~L2CAP_SAR_MASK)
+#define L2CAP_CONF_REQ_SENT    0x01
+#define L2CAP_CONF_INPUT_DONE  0x02
+#define L2CAP_CONF_OUTPUT_DONE 0x04
+#define L2CAP_CONF_MAX_RETRIES 2
 
 void l2cap_load(void);
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/Makefile linux-2.6.18-my-bt/Makefile
--- linux-2.6.18-mh1/Makefile	2006-09-23 19:55:32.000000000 -0700
+++ linux-2.6.18-my-bt/Makefile	2006-09-24 00:24:58.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION = -mh1
+EXTRAVERSION = -mh1aj
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/bnep/bnep.h linux-2.6.18-my-bt/net/bluetooth/bnep/bnep.h
--- linux-2.6.18-mh1/net/bluetooth/bnep/bnep.h	2006-09-23 19:56:07.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/bnep/bnep.h	2006-09-23 23:00:22.000000000 -0700
@@ -86,29 +86,29 @@
 #define BNEP_EXT_HEADER	 0x80
 
 struct bnep_setup_conn_req {
-	__u8  type;
-	__u8  ctrl;
-	__u8  uuid_size;
-	__u8  service[0];
+	__u8   type;
+	__u8   ctrl;
+	__u8   uuid_size;
+	__u8   service[0];
 } __attribute__((packed));
 
 struct bnep_set_filter_req {
-	__u8  type;
-	__u8  ctrl;
-	__u16 len;
-	__u8  list[0];
+	__u8   type;
+	__u8   ctrl;
+	__le16 len;
+	__u8   list[0];
 } __attribute__((packed));
 
 struct bnep_control_rsp {
-	__u8  type;
-	__u8  ctrl;
-	__u16 resp;
+	__u8   type;
+	__u8   ctrl;
+	__le16 resp;
 } __attribute__((packed));
 
 struct bnep_ext_hdr {
-	__u8  type;
-	__u8  len;
-	__u8  data[0];
+	__u8   type;
+	__u8   len;
+	__u8   data[0];
 } __attribute__((packed));
 
 /* BNEP ioctl defines */
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/bnep/core.c linux-2.6.18-my-bt/net/bluetooth/bnep/core.c
--- linux-2.6.18-mh1/net/bluetooth/bnep/core.c	2006-09-23 19:56:06.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/bnep/core.c	2006-09-23 22:46:43.000000000 -0700
@@ -51,7 +51,6 @@
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
 #include "bnep.h"
@@ -516,26 +515,6 @@
 	return 0;
 }
 
-static struct device *bnep_get_device(struct bnep_session *session)
-{
-	bdaddr_t *src = &bt_sk(session->sock->sk)->src;
-	bdaddr_t *dst = &bt_sk(session->sock->sk)->dst;
-	struct hci_dev *hdev;
-	struct hci_conn *conn;
-
-	hdev = hci_get_route(dst, src);
-	if (!hdev)
-		return NULL;
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	if (!conn)
-		return NULL;
-
-	hci_dev_put(hdev);
-
-	return &conn->dev;
-}
-
 int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 {
 	struct net_device *dev;
@@ -555,6 +534,7 @@
 	if (!dev)
 		return -ENOMEM;
 
+
 	down_write(&bnep_session_sem);
 
 	ss = __bnep_get_session(dst);
@@ -571,7 +551,7 @@
 	memcpy(s->eh.h_source, &dst, ETH_ALEN);
 	memcpy(dev->dev_addr, s->eh.h_dest, ETH_ALEN);
 
-	s->dev   = dev;
+	s->dev = dev;
 	s->sock  = sock;
 	s->role  = req->role;
 	s->state = BT_CONNECTED;
@@ -588,8 +568,6 @@
 	bnep_set_default_proto_filter(s);
 #endif
 
-	SET_NETDEV_DEV(dev, bnep_get_device(s));
-
 	err = register_netdev(dev);
 	if (err) {
 		goto failed;
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/hci_conn.c linux-2.6.18-my-bt/net/bluetooth/hci_conn.c
--- linux-2.6.18-mh1/net/bluetooth/hci_conn.c	2006-09-23 19:56:08.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/hci_conn.c	2006-09-23 22:46:43.000000000 -0700
@@ -179,8 +179,6 @@
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
 
-	hci_conn_add_sysfs(conn);
-
 	tasklet_enable(&hdev->tx_task);
 
 	return conn;
@@ -213,8 +211,6 @@
 
 	tasklet_disable(&hdev->tx_task);
 
-	hci_conn_del_sysfs(conn);
-
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
@@ -225,9 +221,7 @@
 
 	hci_dev_put(hdev);
 
-	/* will free via device release */
-	put_device(&conn->dev);
-
+	kfree(conn);
 	return 0;
 }
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/hci_core.c linux-2.6.18-my-bt/net/bluetooth/hci_core.c
--- linux-2.6.18-mh1/net/bluetooth/hci_core.c	2006-09-23 19:56:07.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/hci_core.c	2006-09-23 22:46:43.000000000 -0700
@@ -850,7 +850,7 @@
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
 
-	hdev->idle_timeout = HCI_IDLE_TIMEOUT;
+	hdev->idle_timeout = 0;
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/hci_event.c linux-2.6.18-my-bt/net/bluetooth/hci_event.c
--- linux-2.6.18-mh1/net/bluetooth/hci_event.c	2006-09-23 19:56:06.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/hci_event.c	2006-09-23 22:46:43.000000000 -0700
@@ -62,7 +62,6 @@
 
 	switch (ocf) {
 	case OCF_INQUIRY_CANCEL:
-	case OCF_EXIT_PERIODIC_INQ:
 		status = *((__u8 *) skb->data);
 
 		if (status) {
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/hci_sysfs.c linux-2.6.18-my-bt/net/bluetooth/hci_sysfs.c
--- linux-2.6.18-mh1/net/bluetooth/hci_sysfs.c	2006-09-23 19:56:06.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/hci_sysfs.c	2006-09-23 22:46:43.000000000 -0700
@@ -13,32 +13,16 @@
 #define BT_DBG(D...)
 #endif
 
-static inline char *typetostr(int type)
+static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	switch (type) {
-	case HCI_VIRTUAL:
-		return "VIRTUAL";
-	case HCI_USB:
-		return "USB";
-	case HCI_PCCARD:
-		return "PCCARD";
-	case HCI_UART:
-		return "UART";
-	case HCI_RS232:
-		return "RS232";
-	case HCI_PCI:
-		return "PCI";
-	case HCI_SDIO:
-		return "SDIO";
-	default:
-		return "UNKNOWN";
-	}
+	struct hci_dev *hdev = dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", hdev->name);
 }
 
 static ssize_t show_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", typetostr(hdev->type));
+	return sprintf(buf, "%d\n", hdev->type);
 }
 
 static ssize_t show_address(struct device *dev, struct device_attribute *attr, char *buf)
@@ -49,6 +33,12 @@
 	return sprintf(buf, "%s\n", batostr(&bdaddr));
 }
 
+static ssize_t show_flags(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hci_dev *hdev = dev_get_drvdata(dev);
+	return sprintf(buf, "0x%lx\n", hdev->flags);
+}
+
 static ssize_t show_inquiry_cache(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = dev_get_drvdata(dev);
@@ -151,8 +141,10 @@
 	return count;
 }
 
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
 static DEVICE_ATTR(address, S_IRUGO, show_address, NULL);
+static DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
 static DEVICE_ATTR(inquiry_cache, S_IRUGO, show_inquiry_cache, NULL);
 
 static DEVICE_ATTR(idle_timeout, S_IRUGO | S_IWUSR,
@@ -163,8 +155,10 @@
 				show_sniff_min_interval, store_sniff_min_interval);
 
 static struct device_attribute *bt_attrs[] = {
+	&dev_attr_name,
 	&dev_attr_type,
 	&dev_attr_address,
+	&dev_attr_flags,
 	&dev_attr_inquiry_cache,
 	&dev_attr_idle_timeout,
 	&dev_attr_sniff_max_interval,
@@ -172,32 +166,6 @@
 	NULL
 };
 
-static ssize_t show_conn_type(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct hci_conn *conn = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", conn->type == ACL_LINK ? "ACL" : "SCO");
-}
-
-static ssize_t show_conn_address(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct hci_conn *conn = dev_get_drvdata(dev);
-	bdaddr_t bdaddr;
-	baswap(&bdaddr, &conn->dst);
-	return sprintf(buf, "%s\n", batostr(&bdaddr));
-}
-
-#define CONN_ATTR(_name,_mode,_show,_store) \
-struct device_attribute conn_attr_##_name = __ATTR(_name,_mode,_show,_store)
-
-static CONN_ATTR(type, S_IRUGO, show_conn_type, NULL);
-static CONN_ATTR(address, S_IRUGO, show_conn_address, NULL);
-
-static struct device_attribute *conn_attrs[] = {
-	&conn_attr_type,
-	&conn_attr_address,
-	NULL
-};
-
 struct class *bt_class = NULL;
 EXPORT_SYMBOL_GPL(bt_class);
 
@@ -209,57 +177,8 @@
 
 static void bt_release(struct device *dev)
 {
-	void *data = dev_get_drvdata(dev);
-	kfree(data);
-}
-
-static void add_conn(void *data)
-{
-	struct hci_conn *conn = data;
-	int i;
-
-	device_register(&conn->dev);
-
-	for (i = 0; conn_attrs[i]; i++)
-		device_create_file(&conn->dev, conn_attrs[i]);
-}
-
-void hci_conn_add_sysfs(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	bdaddr_t *ba = &conn->dst;
-
-	BT_DBG("conn %p", conn);
-
-	conn->dev.parent  = &hdev->dev;
-	conn->dev.release = bt_release;
-
-	snprintf(conn->dev.bus_id, BUS_ID_SIZE,
-			"%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
-			conn->type == ACL_LINK ? "acl" : "sco",
-			ba->b[5], ba->b[4], ba->b[3],
-			ba->b[2], ba->b[1], ba->b[0]);
-
-	dev_set_drvdata(&conn->dev, conn);
-
-	INIT_WORK(&conn->work, add_conn, (void *) conn);
-
-	schedule_work(&conn->work);
-}
-
-static void del_conn(void *data)
-{
-	struct hci_conn *conn = data;
-	device_del(&conn->dev);
-}
-
-void hci_conn_del_sysfs(struct hci_conn *conn)
-{
-	BT_DBG("conn %p", conn);
-
-	INIT_WORK(&conn->work, del_conn, (void *) conn);
-
-	schedule_work(&conn->work);
+	struct hci_dev *hdev = dev_get_drvdata(dev);
+	kfree(hdev);
 }
 
 int hci_register_sysfs(struct hci_dev *hdev)
@@ -295,9 +214,11 @@
 
 void hci_unregister_sysfs(struct hci_dev *hdev)
 {
+	struct device *dev = &hdev->dev;
+
 	BT_DBG("%p name %s type %d", hdev, hdev->name, hdev->type);
 
-	device_del(&hdev->dev);
+	device_del(dev);
 }
 
 int __init bt_sysfs_init(void)
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/hidp/core.c linux-2.6.18-my-bt/net/bluetooth/hidp/core.c
--- linux-2.6.18-mh1/net/bluetooth/hidp/core.c	2006-09-23 19:56:07.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/hidp/core.c	2006-09-23 23:00:22.000000000 -0700
@@ -41,7 +41,6 @@
 #include "hid.h"
 
 #include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
 #include "hidp.h"
@@ -573,26 +572,6 @@
 	return 0;
 }
 
-static struct device *hidp_get_device(struct hidp_session *session)
-{
-	bdaddr_t *src = &bt_sk(session->ctrl_sock->sk)->src;
-	bdaddr_t *dst = &bt_sk(session->ctrl_sock->sk)->dst;
-	struct hci_dev *hdev;
-	struct hci_conn *conn;
-
-	hdev = hci_get_route(dst, src);
-	if (!hdev)
-		return NULL;
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	if (!conn)
-		return NULL;
-
-	hci_dev_put(hdev);
-
-	return &conn->dev;
-}
-
 static inline void hidp_setup_input(struct hidp_session *session, struct hidp_connadd_req *req)
 {
 	struct input_dev *input = session->input;
@@ -631,8 +610,6 @@
 		input->relbit[0] |= BIT(REL_WHEEL);
 	}
 
-	input->cdev.dev = hidp_get_device(session);
-
 	input->event = hidp_input_event;
 
 	input_register_device(input);
@@ -660,8 +637,6 @@
 	strncpy(hid->phys, batostr(&src), 64);
 	strncpy(hid->uniq, batostr(&dst), 64);
 
-	hid->dev = hidp_get_device(session);
-
 	hid->send = hid_send_report;
 
 	hid_register_device(hid);
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/l2cap.c linux-2.6.18-my-bt/net/bluetooth/l2cap.c
--- linux-2.6.18-mh1/net/bluetooth/l2cap.c	2006-09-23 19:56:08.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/l2cap.c	2006-09-23 23:00:22.000000000 -0700
@@ -40,20 +40,16 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/device.h>
-#include <linux/crc16.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
-#include <asm/bitops.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
-#define CONFIG_BT_L2CAP_DEBUG
-
 #ifndef CONFIG_BT_L2CAP_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
@@ -70,8 +66,6 @@
 static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
 static void l2cap_sock_kill(struct sock *sk);
-static inline int l2cap_do_send_rfc(struct sock *sk);
-static int l2cap_send_sframe(struct sock *sk, u8 reqseq);
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
@@ -110,52 +104,6 @@
 	sk->sk_timer.data = (unsigned long)sk;
 }
 
-static void l2cap_start_ret_timer(struct sock *sk, u16 timeout)
-{
-	BT_DBG("sk %p timeout %d", sk, timeout);
-	if (timeout <= jiffies) return;
-	mod_timer(&l2cap_pi(sk)->ret_timer, timeout);
-}
-
-static void l2cap_start_mon_timer(struct sock *sk, u16 timeout)
-{
-	BT_DBG("sk %p timeout %d", sk, timeout);
-	if (timeout <= jiffies) return;
-	mod_timer(&l2cap_pi(sk)->mon_timer, timeout);
-}
-
-static void l2cap_retransmission_timer(unsigned long data)
-{
-	struct sock *sk = (struct sock *) data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-
-	BT_DBG("sk %p", sk);
-
-	pi->exp_ackseq = (pi->exp_ackseq + 1) % 64;
-	if (pi->exp_ackseq == pi->next_txseq) {
-		l2cap_start_mon_timer(sk, pi->imon_to * HZ / 1000);
-	} else {
-		l2cap_start_ret_timer(sk, pi->iret_to * HZ / 1000);
-		
-		lock_sock(sk);
-		if (sk->sk_state == BT_CONNECTED)
-			l2cap_do_send_rfc(sk);
-		release_sock(sk);
-	}
-}
-
-static void l2cap_monitor_timer(unsigned long data)
-{
-	struct sock *sk = (struct sock *) data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-
-	BT_DBG("sk %p", sk);
-
-	l2cap_send_sframe(sk, pi->exp_txseq);
-
-	l2cap_start_mon_timer(sk, pi->imon_to * HZ / 1000);
-}
-
 /* ---- L2CAP channels ---- */
 static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
@@ -410,7 +358,8 @@
 	struct sock *sk;
 	struct hlist_node *node;
 	sk_for_each(sk, node, &l2cap_sk_list.head)
-		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+		if (l2cap_pi(sk)->sport == (__le16 __force) psm &&
+				!bacmp(&bt_sk(sk)->src, src))
 			goto found;
 	sk = NULL;
 found:
@@ -429,7 +378,7 @@
 		if (state && sk->sk_state != state)
 			continue;
 
-		if (l2cap_pi(sk)->psm == psm) {
+		if (l2cap_pi(sk)->psm == (__le16 __force) psm) {
 			/* Exact match. */
 			if (!bacmp(&bt_sk(sk)->src, src))
 				break;
@@ -551,38 +500,16 @@
 		sk->sk_type = parent->sk_type;
 		pi->imtu = l2cap_pi(parent)->imtu;
 		pi->omtu = l2cap_pi(parent)->omtu;
-		pi->mode = l2cap_pi(parent)->mode;
 		pi->link_mode = l2cap_pi(parent)->link_mode;
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
-		pi->mode = L2CAP_MODE_BASIC;
 		pi->link_mode = 0;
 	}
 
 	/* Default config options */
 	pi->conf_mtu = L2CAP_DEFAULT_MTU;
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
-	pi->conf_mode = L2CAP_MODE_FLOW;
-	pi->conf_txw = L2CAP_DEFAULT_TXW;
-	pi->conf_maxt = L2CAP_DEFAULT_MAXT;
-	pi->conf_ret_to = L2CAP_DEFAULT_RETTO;
-	pi->conf_mon_to = L2CAP_DEFAULT_MONTO;
-	pi->conf_mps = L2CAP_DEFAULT_MPS;
-
-	pi->next_txseq = 0;
-	pi->exp_ackseq = 0;
-
-	skb_queue_head_init(&pi->tx_queue);
-	pi->tx_queue_frames = 0;
-
-	init_timer(&l2cap_pi(sk)->ret_timer);
-	l2cap_pi(sk)->ret_timer.function = l2cap_retransmission_timer;
-	l2cap_pi(sk)->ret_timer.data = (unsigned long)l2cap_pi(sk);
-
-	init_timer(&l2cap_pi(sk)->mon_timer);
-	l2cap_pi(sk)->mon_timer.function = l2cap_monitor_timer;
-	l2cap_pi(sk)->mon_timer.data = (unsigned long)l2cap_pi(sk);
 }
 
 static struct proto l2cap_proto = {
@@ -666,8 +593,8 @@
 	} else {
 		/* Save source address */
 		bacpy(&bt_sk(sk)->src, &la->l2_bdaddr);
-		l2cap_pi(sk)->psm   = la->l2_psm;
-		l2cap_pi(sk)->sport = la->l2_psm;
+		l2cap_pi(sk)->psm   = (__le16 __force) la->l2_psm;
+		l2cap_pi(sk)->sport = (__le16 __force) la->l2_psm;
 		sk->sk_state = BT_BOUND;
 	}
 
@@ -779,7 +706,7 @@
 
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &la->l2_bdaddr);
-	l2cap_pi(sk)->psm = la->l2_psm;
+	l2cap_pi(sk)->psm = (__le16 __force) la->l2_psm;
 
 	if ((err = l2cap_do_connect(sk)))
 		goto done;
@@ -908,7 +835,7 @@
 	else
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
 
-	la->l2_psm = l2cap_pi(sk)->psm;
+	la->l2_psm = (unsigned short __force) l2cap_pi(sk)->psm;
 	return 0;
 }
 
@@ -940,7 +867,7 @@
 	lh->len = __cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
 	if (sk->sk_type == SOCK_DGRAM)
-		put_unaligned(l2cap_pi(sk)->psm, (u16 *) skb_put(skb, 2));
+		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
 		err = -EFAULT;
@@ -980,164 +907,6 @@
 	return err;
 }
 
-static inline int l2cap_do_send_rfc(struct sock *sk)
-{
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	struct sk_buff *skb;
-	int err = 0;
-	u8 occupied;
-	
-	occupied = (pi->next_txseq - pi->exp_ackseq + 64) % 64;
-
-	BT_DBG("sk %p occ %d frames %d", sk, occupied, pi->tx_queue_frames);
-
-	/* no frames in TxQueue */
-	if (!pi->tx_queue_frames)
-		return -1;
-	
-	if (pi->otxw <= occupied)
-		return -1;
-
-	while ((pi->tx_queue_frames > 0) && (pi->otxw > occupied)) {
-		skb = skb_dequeue(&pi->tx_queue);
-		if (skb == NULL) {
-			goto fail;
-		}
-		if ((err = hci_send_acl(conn->hcon, skb, 0)) < 0)
-			goto fail;
-
-		pi->tx_queue_frames--;
-		occupied++;
-	}
-
-	return 0;
-
-fail:
-	kfree(skb);
-	return -1;
-}
-
-static int l2cap_segment_sdu(struct sock *sk, struct msghdr *msg, int len)
-{
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-	struct sk_buff *skb;
-	int err, hlen, count, sent = 0;
-	struct l2cap_hdr *lh;
-	u16 control = 0, fcs, sar;
-
-	BT_DBG("sk %p len %d", sk, len);
-
-	/* length, cid, control, fcs */
-	hlen = L2CAP_HDR_SIZE + 4;
-
-	/* count reflects the size of the information payload field */
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
-
-	/* one single frame */
-	if (len == count) {
-		skb = bt_skb_send_alloc(sk, hlen + len,
-				msg->msg_flags & MSG_DONTWAIT, &err);
-		if (!skb)
-			return err;
-
-		/* Create L2CAP header */
-		lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-		lh->cid = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		lh->len = __cpu_to_le16(len + 4);
-
-		L2CAP_SET_SAR(control, L2CAP_SAR_UNSEGMENTED);
-		L2CAP_SET_TXSEQ(control, l2cap_pi(sk)->next_txseq);
-		L2CAP_SET_REQSEQ(control, l2cap_pi(sk)->exp_txseq);
-
-		put_unaligned(__cpu_to_le16(control), (u16 *) skb_put(skb, 2));
-
-		if (memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len)) {
-			err = -EFAULT;
-			goto fail;
-		}
-
-		/* calculate fcs over information payload plus
-		 * len, cid and control fields */
-		fcs = crc16(0, skb->data, len + 6);
-
-		put_unaligned(__cpu_to_le16(fcs), (u16 *) skb_put(skb, 2));
-
-		l2cap_pi(sk)->next_txseq = (l2cap_pi(sk)->next_txseq + 1) % 64;
-			
-		skb_queue_tail(&l2cap_pi(sk)->tx_queue, skb);
-		l2cap_pi(sk)->tx_queue_frames++;
-
-		sent = len;
-
-		goto out;
-	}
-
-	sar = L2CAP_SAR_START;
-	hlen  += 2;
-	count -= 2;
-
-	/* build segmented i-frames */
-	while (len) {
-		skb = bt_skb_send_alloc(sk, hlen + count,
-				msg->msg_flags & MSG_DONTWAIT, &err);
-		if (!skb)
-			return err;
-
-		/* Create L2CAP header */
-		lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-		lh->cid = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		lh->len = __cpu_to_le16(count + hlen - L2CAP_HDR_SIZE);
-
-		/* Control and SDU len field */
-		L2CAP_SET_SAR(control, sar);
-		L2CAP_SET_TXSEQ(control, l2cap_pi(sk)->next_txseq);
-		L2CAP_SET_REQSEQ(control, l2cap_pi(sk)->exp_txseq);
-
-		put_unaligned(__cpu_to_le16(control), (u16 *) skb_put(skb, 2));
-
-		if (sar == L2CAP_SAR_START)
-			put_unaligned(__cpu_to_le16(len), (u16 *) skb_put(skb, 2));
-
-		/* Information payload */
-		if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
-			err = -EFAULT;
-			goto fail;
-		}
-
-		/* calculate fcs over information payload plus
-		 * len, cid and control fields (plus sdu len if present) */
-		fcs = crc16(0, skb->data, hlen + count);
-
-		put_unaligned(__cpu_to_le16(fcs), (u16 *) skb_put(skb, 2));
-
-		l2cap_pi(sk)->next_txseq = (l2cap_pi(sk)->next_txseq + 1) % 64;
-			
-		skb_queue_tail(&l2cap_pi(sk)->tx_queue, skb);
-		l2cap_pi(sk)->tx_queue_frames++;
-
-		sent += count;
-		len  -= count;
-
-		if (sar == L2CAP_SAR_START) {
-			hlen  -= 2;
-			count += 2;
-		}
-		
-		if (len <= count)
-			sar = L2CAP_SAR_END;
-		else
-			sar = L2CAP_SAR_CONTINUE;
-	}
-
-out:
-	return sent;
-
-fail:
-	kfree_skb(skb);
-	return err;
-}
-
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
@@ -1158,22 +927,11 @@
 
 	lock_sock(sk);
 
-	if (!(sk->sk_state == BT_CONNECTED)) {
-		err = -ENOTCONN;
-		goto out;
-	}
-
-	if (l2cap_pi(sk)->mode == L2CAP_MODE_FLOW) {
-		err = l2cap_segment_sdu(sk, msg, len);
-		if (err < 0)
-			goto out;
-		if (l2cap_do_send_rfc(sk) < 0)
-			err = -1;
-	} else {
+	if (sk->sk_state == BT_CONNECTED)
 		err = l2cap_do_send(sk, msg, len);
-	}
+	else
+		err = -ENOTCONN;
 
-out:
 	release_sock(sk);
 	return err;
 }
@@ -1237,7 +995,7 @@
 		opts.imtu     = l2cap_pi(sk)->imtu;
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = l2cap_pi(sk)->mode;
+		opts.mode     = 0x00;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -1469,207 +1227,102 @@
 	return NULL;
 }
 
-/**
- * l2cap_check_conf_opt - checks an incoming option for valid parameters
- * @sk: corresponding socket
- * @option: option that's parameters will be checked
- * @return: result code for this request's option
- *
- * All parameters of a particular option from an incoming request will be
- * checked. The result code for this option (e.g. L2CAP_CONF_UNACCEPT) is
- * returned.
- */
-static inline int l2cap_check_conf_opt(struct sock *sk, int option)
+static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
 {
-	int result = L2CAP_CONF_SUCCESS;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_conf_opt *opt = *ptr;
+	int len;
+
+	len = L2CAP_CONF_OPT_SIZE + opt->len;
+	*ptr += len;
 
-	switch (option) {
-	case L2CAP_CONF_MTU:
-		if (pi->conf_mtu < L2CAP_MIN_MTU)
-			result = L2CAP_CONF_UNACCEPT;
+	*type = opt->type;
+	*olen = opt->len;
+
+	switch (opt->len) {
+	case 1:
+		*val = *((__u8 *) opt->val);
 		break;
-	case L2CAP_CONF_FLUSH_TO:
+
+	case 2:
+		*val = __le16_to_cpu(*((__le16 *) opt->val));
 		break;
-	case L2CAP_CONF_QOS:
+
+	case 4:
+		*val = __le32_to_cpu(*((__le32 *) opt->val));
 		break;
-	case L2CAP_CONF_RFC:
-		if (pi->conf_mode == L2CAP_MODE_BASIC) {
-			pi->mode = L2CAP_MODE_BASIC;
-			break;
-		}
-		/* Retransmission Mode not supported yet */
-		if (pi->conf_mode != L2CAP_MODE_FLOW) {
-			pi->conf_mode = L2CAP_MODE_FLOW;
-			result = L2CAP_CONF_UNACCEPT;
-		}
-		if (pi->conf_txw < 1 || pi->conf_txw > 32) {
-			pi->conf_txw = 32;
-			result = L2CAP_CONF_UNACCEPT;
-		}
-		if (pi->conf_maxt < 1) {
-			pi->conf_maxt = 8;
-			result = L2CAP_CONF_UNACCEPT;
-		}
-		if (pi->conf_ret_to < 100) {
-			pi->conf_ret_to = 1000;
-			result = L2CAP_CONF_UNACCEPT;
-		}
-		if (pi->conf_mon_to < 100) {
-			pi->conf_mon_to = 1000;
-			result = L2CAP_CONF_UNACCEPT;
-		}
+
+	default:
+		*val = (unsigned long) opt->val;
 		break;
 	}
 
-	return result;
+	BT_DBG("type 0x%2.2x len %d val 0x%lx", *type, opt->len, *val);
+	return len;
 }
 
-/**
- * l2cap_parse_conf_req - parses a configuration request packet for options
- * @sk: corresponding socket structure
- * @data: conf request data that consists of type, length and option data
- * @len: length of the whole configuration request packet
- * @result: array (128 Bytes) of collected result codes
- *
- * Parses a configuration request that may contain multiple configuration
- * options. Sets the appropriate configuration request parameters from the
- * remote peer if all options are valid and understood. Rejects them if
- * they are malformed and prepares an unknown status for options that we
- * do not support yet.
- */
-static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len, u8 *result)
+static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	int type, hint;
-	u8 *ptr = data;
-	/* bit flag to avoid multiple examination of already parsed options */
-	unsigned long options = 0;
+	int type, hint, olen; 
+	unsigned long val;
+	void *ptr = data;
 
 	BT_DBG("sk %p len %d", sk, len);
 
-	memset(result, 255, L2CAP_MAX_OPTS);
-
-	/* result[0] stays 255 for an empty request */
-	if (len != 0)
-		result[0] = L2CAP_CONF_SUCCESS;
-
 	while (len >= L2CAP_CONF_OPT_SIZE) {
-		u8 req_len = *(u8 *)(ptr + 1);
-
-		/* bail out if req length > packet length */
-		if (len < req_len) return;
-
-		len -= req_len + 2;
-		type = *(u8 *)(ptr + 0);
+		len -= l2cap_get_conf_opt(&ptr, &type, &olen, &val);
 
 		hint  = type & 0x80;
 		type &= 0x7f;
 
 		switch (type) {
-		case 0:
-			result[0] = L2CAP_CONF_REJ;
-			break;
 		case L2CAP_CONF_MTU:
-			if (test_bit(L2CAP_CONF_MTU, &options))
-				break;
-			if (req_len != 2) {
-				result[0] = L2CAP_CONF_REJ;
-				break;
-			}
-			pi->conf_mtu = __le16_to_cpup((__le16 *)(ptr + 2));
-			set_bit(L2CAP_CONF_MTU, &options);
-			result[L2CAP_CONF_MTU] = l2cap_check_conf_opt(sk, L2CAP_CONF_MTU);
-			if (result[L2CAP_CONF_MTU] == L2CAP_CONF_UNACCEPT)
-				result[0] = L2CAP_CONF_UNACCEPT;
-
+			l2cap_pi(sk)->conf_mtu = val;
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
-			if (test_bit(L2CAP_CONF_FLUSH_TO, &options))
-				break;
-			if (req_len != 2) {
-				result[0] = L2CAP_CONF_REJ;
-				break;
-			}
-			pi->flush_to = __le16_to_cpup((__le16 *)(ptr + 2));
-			set_bit(L2CAP_CONF_FLUSH_TO, &options);
-			result[L2CAP_CONF_FLUSH_TO] = l2cap_check_conf_opt(sk, L2CAP_CONF_FLUSH_TO);
-			if (result[L2CAP_CONF_FLUSH_TO] == L2CAP_CONF_UNACCEPT)
-				result[0] = L2CAP_CONF_UNACCEPT;
-
+			l2cap_pi(sk)->flush_to = val;
 			break;
 
-		case L2CAP_CONF_RFC:
-			if (test_bit(L2CAP_CONF_RFC, &options))
-				break;
-			if (req_len != 9) {
-				result[0] = L2CAP_CONF_REJ;
-				break;
-			}
-			pi->conf_mode = *(__u8 *)(ptr + 2);
-			pi->conf_txw  = *(__u8 *)(ptr + 3);
-			pi->conf_maxt = *(__u8 *)(ptr + 4);
-			pi->conf_ret_to = __le16_to_cpup((__le16 *)(ptr + 5));
-			pi->conf_mon_to = __le16_to_cpup((__le16 *)(ptr + 7));
-			pi->conf_mps    = __le16_to_cpup((__le16 *)(ptr + 9));
-			set_bit(L2CAP_CONF_RFC, &options);
-			result[L2CAP_CONF_RFC] = l2cap_check_conf_opt(sk, L2CAP_CONF_RFC);
-			if (result[L2CAP_CONF_RFC] == L2CAP_CONF_UNACCEPT)
-				result[0] = L2CAP_CONF_UNACCEPT;
-
+		case L2CAP_CONF_QOS:
 			break;
 
 		default:
-			result[0] = L2CAP_CONF_UNKNOWN;
-			result[type] = L2CAP_CONF_UNKNOWN;
-			/* TODO: hints are not supported yet */
 			if (hint)
 				break;
-		}
 
-		/* go to start of (possible) next request */
-		ptr += req_len + L2CAP_CONF_OPT_SIZE;
+			/* FIXME: Reject unknown option */
+			break;
+		}
 	}
 }
 
-/**
- * l2cap_add_conf_opt - adds a configuration option to a rsp or req
- * @ptr: pointer to location where all options are finally stored
- * @data: data for one option (type, len, and all parameters)
- * @type: option type
- * @len: option length
- *
- * Adds a complete configuration parameter option to a configuration
- * response or a configuration request
- */
-static void l2cap_add_conf_opt(void **ptr, void *data, u8 type, u8 len)
+static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
 
-	BT_DBG("type 0x%2.2x len %d", type, len);
+	BT_DBG("type 0x%2.2x len %d val 0x%lx", type, len, val);
 
 	opt->type = type;
 	opt->len  = len;
 
-	switch (type) {
-	case L2CAP_CONF_MTU:
-		*((__le16 *) opt->val) = cpu_to_le16(*(__le16 *) data);
+	switch (len) {
+	case 1:
+		*((__u8 *) opt->val)  = val;
 		break;
-	case L2CAP_CONF_RFC: {
-		struct l2cap_conf_rfc *tmp = (struct l2cap_conf_rfc *) data;
-		struct l2cap_conf_rfc *rfc = (struct l2cap_conf_rfc *) opt->val;
-		rfc->mode   = tmp->mode;
-		rfc->txw    = tmp->txw;
-		rfc->maxt   = tmp->maxt;
-		rfc->ret_to = tmp->ret_to;
-		rfc->mon_to = tmp->mon_to;
-		rfc->mps    = tmp->mps;
+
+	case 2:
+		*((__le16 *) opt->val) = __cpu_to_le16(val);
+		break;
+
+	case 4:
+		*((__le32 *) opt->val) = __cpu_to_le32(val);
+		break;
+
+	default:
+		memcpy(opt->val, (void *) val, len);
 		break;
-	}
 	}
 
-	/* increase pointer for next (possible) option */
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
@@ -1677,193 +1330,59 @@
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
-	void *opts = req->data;
+	void *ptr = req->data;
 
 	BT_DBG("sk %p", sk);
 
-	if ((pi->conf_state & L2CAP_CONF_UNACCEPT_MTU) ||
-			(pi->imtu != L2CAP_DEFAULT_MTU)) {
-		l2cap_add_conf_opt(&opts, &(pi->conf_mtu), L2CAP_CONF_MTU, 2);
-		/* clear bit in conf_state */
-		pi->conf_state &= (~L2CAP_CONF_UNACCEPT_MTU);
-	}
-
-	/* either we got unacceptable rfc options in former response
-	 * or we discovered support for rfc in an information request */
-	if ((pi->conf_state & L2CAP_CONF_UNACCEPT_RFC) ||
-			(pi->info_ext & L2CAP_EXT_FCM)) {
-		struct l2cap_conf_rfc rfc;
-		rfc.mode = pi->conf_mode;
-		rfc.txw  = pi->conf_txw;
-		rfc.maxt = pi->conf_maxt;
-		rfc.ret_to = pi->conf_ret_to;
-		rfc.mon_to = pi->conf_mon_to;
-		rfc.mps = pi->conf_mps;
-		l2cap_add_conf_opt(&opts, &(pi->conf_mtu), L2CAP_CONF_MTU, 2);
-		l2cap_add_conf_opt(&opts, &rfc, L2CAP_CONF_RFC, 9);
-		/* clear bit in conf_state */
-		pi->conf_state &= (~L2CAP_CONF_UNACCEPT_RFC);
-	}
+	if (pi->imtu != L2CAP_DEFAULT_MTU)
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
+
+	/* FIXME: Need actual value of the flush timeout */
+	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
+	//   l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2, pi->flush_to);
 
 	req->dcid  = __cpu_to_le16(pi->dcid);
 	req->flags = __cpu_to_le16(0);
 
-	return opts - data;
+	return ptr - data;
 }
 
-/**
- * l2cap_build_conf_rsp - builds a configuration response
- * @sk: corresponding socket
- * @data: data portion of rsp packet (scid, flags, result, config)
- * @complete: indicates whether C flag is set (0 == incomplete)
- * @result: pointer to collected result codes of result[128]
- *
- * Building a configuration response on base of the collected result codes.
- * The fundamental result code result[0] delegates the action that is taken.
- * For each result[i] that is set appropriately the response packet will be
- * built.
- * Returns the length of the data field in octets of the command only (does
- * not cover the Code, Identifier, and Length field): scid + flags + result +
- * configuration options.
- */
-static int l2cap_build_conf_rsp(struct sock *sk, void *data, int complete, u8 *result)
+static inline int l2cap_conf_output(struct sock *sk, void **ptr)
 {
-	struct l2cap_conf_rsp *rsp = data;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	void *opts = rsp->data;
-	u16 flags = 0;
-	int i, len = 0;
-
-	BT_DBG("sk %p complete %d", sk, complete);
+	int result = 0;
 
-	switch (result[0]) {
-	/* 255 represents the case for an empty request */
-	case 255:
+	/* Configure output options and let the other side know
+	 * which ones we don't like. */
+	if (pi->conf_mtu < pi->omtu) {
+		l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
+		result = L2CAP_CONF_UNACCEPT;
+	} else {
 		pi->omtu = pi->conf_mtu;
-		result[0] = L2CAP_CONF_SUCCESS;
-		break;
-
-	case L2CAP_CONF_SUCCESS:
-		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
-			if (result[i] == L2CAP_CONF_SUCCESS) {
-				switch (i) {
-				case L2CAP_CONF_MTU:
-					pi->omtu = pi->conf_mtu;
-					len = 2;
-					l2cap_add_conf_opt(&opts, &(pi->omtu), i, len);
-					break;
-				case L2CAP_CONF_RFC: {
-					struct l2cap_conf_rfc params;
-					struct l2cap_conf_rfc *rfc = &params;
-					pi->mode = pi->conf_mode;
-					pi->otxw  = pi->conf_txw;
-					pi->omaxt = pi->conf_maxt;
-					pi->oret_to = pi->conf_ret_to;
-					pi->omon_to = pi->conf_mon_to;
-					pi->omps = pi->conf_mps;
-					len = 9;
-					rfc->mode = pi->mode;
-					rfc->txw  = pi->otxw;
-					rfc->maxt = pi->omaxt;
-					rfc->ret_to = pi->oret_to;
-					rfc->mon_to = pi->omon_to;
-					rfc->mps = pi->omps;
-					l2cap_add_conf_opt(&opts, rfc, i, len);
-					break;
-				}
-				}
-			}
-		}
-		break;
-
-	case L2CAP_CONF_UNACCEPT:
-		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
-			if (result[i] == L2CAP_CONF_UNACCEPT) {
-				switch (i) {
-				case L2CAP_CONF_MTU: {
-					__le16 mtu = L2CAP_DEFAULT_MTU;
-					len = 2;
-					l2cap_add_conf_opt(&opts, &mtu, i, len);
-					break;
-				}
-				case L2CAP_CONF_RFC: {
-					struct l2cap_conf_rfc params;
-					struct l2cap_conf_rfc *rfc = &params;
-					rfc->mode = pi->conf_mode;
-					rfc->txw  = pi->conf_txw;
-					rfc->maxt = pi->conf_maxt;
-					rfc->ret_to = pi->conf_ret_to;
-					rfc->mon_to = pi->conf_mon_to;
-					rfc->mps = pi->conf_mps;
-					len = 9;
-					l2cap_add_conf_opt(&opts, rfc, i, len);
-					break;
-				}
-				}
-			}
-		}
-		break;
-
-	case L2CAP_CONF_REJ:
-		/* send plain reject response */
-		l2cap_add_conf_opt(&opts, NULL, 0, 0);
-		break;
-
-	case L2CAP_CONF_UNKNOWN:
-		for (i = 1; i < L2CAP_MAX_OPTS; ++i) {
-			if (result[i] == L2CAP_CONF_UNKNOWN) {
-				l2cap_add_conf_opt(&opts, NULL, i, 0);
-			}
-		}
-		break;
 	}
 
-	rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-	rsp->result = __cpu_to_le16(result[0] == 255 ? 0 : result[0]);
-	rsp->flags  = __cpu_to_le16(flags);
-
-	/* return length of actual data */
-	return opts - data;
-}
-
-static int l2cap_build_info_req(void *data)
-{
-	struct l2cap_info_req *info = data;
-	u8 len = 2;
-
-	info->type = __cpu_to_le16(L2CAP_IT_FEAT_MASK);
-
-	return len;
+	BT_DBG("sk %p result %d", sk, result);
+	return result;
 }
 
-static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
+static int l2cap_build_conf_rsp(struct sock *sk, void *data, int *result)
 {
-	struct l2cap_cmd_rej *rej = (struct l2cap_cmd_rej *) data;
-	u16 reason;
-	u8 len; /* depends on reason code */
-	__le16 *ptr = rej->data;
+	struct l2cap_conf_rsp *rsp = data;
+	void *ptr = rsp->data;
+	u16 flags = 0;
 
-	reason = __le16_to_cpu(rej->reason);
+	BT_DBG("sk %p complete %d", sk, result ? 1 : 0);
 
-	BT_DBG("reason 0x%4.4x", reason);
+	if (result)
+		*result = l2cap_conf_output(sk, &ptr);
+	else
+		flags = 0x0001;
 
-	switch (reason) {
-	case L2CAP_CMD_NOT_UNDERSTOOD:
-		len = 0;
-		break;
-	case L2CAP_MTU_EXCEEDED:
-		len = 2;
-		BT_DBG("max acceptable signalling MTU 0x%02X", ptr[0]);
-		break;
-	case L2CAP_INVALID_CID:
-		len = 4;
-		BT_DBG("invalid channel 0x%04X 0x%04X", ptr[0], ptr[1]);
-		break;
-	default:
-		return reason;
-	}
+	rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
+	rsp->result = __cpu_to_le16(result ? *result : 0);
+	rsp->flags  = __cpu_to_le16(flags);
 
-	return 0;
+	return ptr - data;
 }
 
 static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
@@ -1875,12 +1394,12 @@
 	int result = 0, status = 0;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
-	u16 psm  = req->psm;
+	__le16 psm  = req->psm;
 
 	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
 
 	/* Check if we have socket listening on psm */
-	parent = l2cap_get_sock_by_psm(BT_LISTEN, psm, conn->src);
+	parent = l2cap_get_sock_by_psm(BT_LISTEN, (u16 __force) psm, conn->src);
 	if (!parent) {
 		result = L2CAP_CR_BAD_PSM;
 		goto sendresp;
@@ -1959,7 +1478,7 @@
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
 	struct sock *sk;
-	u16 info;
+	u8 req[128];
 
 	scid   = __le16_to_cpu(rsp->scid);
 	dcid   = __le16_to_cpu(rsp->dcid);
@@ -1979,12 +1498,12 @@
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		sk->sk_state = BT_CONFIG;
-		l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+		l2cap_pi(sk)->ident = 0;
 		l2cap_pi(sk)->dcid = dcid;
-		/* send information request first */
-		l2cap_pi(sk)->conf_state |= L2CAP_INFO_REQ_SENT;
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_INFO_REQ,
-					l2cap_build_info_req(&info), &info);
+		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+					l2cap_build_conf_req(sk, req), req);
 		break;
 
 	case L2CAP_CR_PEND:
@@ -2002,13 +1521,10 @@
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
-	u16 dcid, flags;
-	u8 rsp[128];
+	u16 dcid, flags, cmd_len = __le16_to_cpu(cmd->len);
+	u8 rsp[64];
 	struct sock *sk;
-	/* collected result codes for theor. max 128 possible options
-	 * result[0] indicates the general result code for all options */
-	u8 result[L2CAP_MAX_OPTS];
-	int temp_len;
+	int result;
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -2018,41 +1534,32 @@
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
 		return -ENOENT;
 
-	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req), result);
+	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req));
 
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-				l2cap_build_conf_rsp(sk, rsp, 0, NULL), rsp);
+				l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
 		goto unlock;
 	}
 
 	/* Complete config. */
-	temp_len = l2cap_build_conf_rsp(sk, rsp, 1, result);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-			temp_len, rsp);
+			l2cap_build_conf_rsp(sk, rsp, &result), rsp);
 
-	if (result[0])
+	if (result)
 		goto unlock;
 
 	/* Output config done */
 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_OUTPUT_DONE;
-	l2cap_pi(sk)->ident = l2cap_get_ident(conn);
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
 		sk->sk_state = BT_CONNECTED;
 		l2cap_chan_ready(sk);
-	} /* don't send conf req if we still await an information rsp */
-	else if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
-		  (l2cap_pi(sk)->conf_state & L2CAP_INFO_INPUT_DONE)) {
-		u8 req[128];
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_CONF_REQ,
+	} else if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
+		u8 req[64];
+		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(sk, req), req);
-	} /* send information request */
-	else {
-		u16 info;
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_INFO_REQ,
-					l2cap_build_info_req(&info), &info);
 	}
 
 unlock:
@@ -2062,14 +1569,9 @@
 
 static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
-	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *) data;
-	u16 scid, flags, result, len;
+	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
+	u16 scid, flags, result;
 	struct sock *sk;
-	struct l2cap_pinfo *pi;
-	u8 type;
-	u8 *ptr = rsp->data;
-	/* length of all options in config data field */
-	len = __le16_to_cpu(cmd->len) - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
@@ -2079,96 +1581,23 @@
 
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, scid)))
 		return 0;
-	pi = l2cap_pi(sk);
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
-		while (len >= L2CAP_CONF_OPT_SIZE) {
-			u8 rsp_len = *(u8 *)(ptr + 1);
-			/* bail out if rsp len > packet len */
-			if (len < rsp_len) return 0;
-
-			len -= rsp_len + 2;
-			type = *(u8 *)(ptr + 0);
-
-			switch (type) {
-			case L2CAP_CONF_MTU:
-				pi->imtu = *(__le16 *)(ptr + 2);
-				break;
-			case L2CAP_CONF_RFC:
-				pi->mode = *(u8 *)(ptr + 2);
-				pi->itxw  = *(u8 *)(ptr + 3);
-				pi->imaxt = *(u8 *)(ptr + 4);
-				pi->iret_to = __le16_to_cpup((__le16 *)(ptr + 5));
-				pi->imon_to = __le16_to_cpup((__le16 *)(ptr + 7));
-				pi->imps    = __le16_to_cpup((__le16 *)(ptr + 9));
-				break;
-			}
-
-			/* go to start of (possible) next request */
-			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
-		}
 		break;
 
-	case L2CAP_CONF_UNACCEPT: {
-		u8 req[128];
-		while (len >= L2CAP_CONF_OPT_SIZE) {
-			u8 rsp_len = *(u8 *)(ptr + 1);
-			/* bail out if rsp len > packet len */
-			if (len < rsp_len) return 0;
-
-			len -= rsp_len + 2;
-			type = *(u8 *)(ptr + 0);
-
-			switch (type) {
-			case L2CAP_CONF_MTU:
-				pi->conf_mtu = *(__le16 *)(ptr + 2);
-				/* add MTU option to new request */
-				pi->conf_state |= L2CAP_CONF_UNACCEPT_MTU;
-				break;
-			case L2CAP_CONF_RFC:
-				pi->conf_mode = *(u8 *)(ptr + 2);
-				pi->conf_txw  = *(u8 *)(ptr + 3);
-				pi->conf_maxt = *(u8 *)(ptr + 4);
-				pi->conf_ret_to = __le16_to_cpup((__le16 *)(ptr + 5));
-				pi->conf_mon_to = __le16_to_cpup((__le16 *)(ptr + 7));
-				pi->conf_mps    = __le16_to_cpup((__le16 *)(ptr + 9));
-				/* add RFC option to new request */
-				pi->conf_state |= L2CAP_CONF_UNACCEPT_RFC;
-				break;
-			}
-
-			/* go to start of (possible) next request */
-			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
-		}
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-				l2cap_build_conf_req(sk, req), req);
-		goto done;
-	}
-
-	case L2CAP_CONF_UNKNOWN: {
-		u8 req[128];
-		while (len >= L2CAP_CONF_OPT_SIZE) {
-			u8 rsp_len = *(u8 *)(ptr + 1);
-			/* bail out if rsp len > packet len */
-			if (len < rsp_len) return 0;
-
-			len -= rsp_len + 2;
-			type = *(u8 *)(ptr + 0);
-
-			switch (type) {
-			case L2CAP_CONF_RFC:
-				pi->conf_mode = L2CAP_MODE_BASIC;
-				break;
-			}
-
-			/* go to start of (possible) next request */
-			ptr += rsp_len + L2CAP_CONF_OPT_SIZE;
+	case L2CAP_CONF_UNACCEPT:
+		if (++l2cap_pi(sk)->conf_retry < L2CAP_CONF_MAX_RETRIES) {
+			char req[128];
+			/* It does not make sense to adjust L2CAP parameters
+			 * that are currently defined in the spec. We simply
+			 * resend config request that we sent earlier. It is
+			 * stupid, but it helps qualification testing which
+			 * expects at least some response from us. */
+			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+						l2cap_build_conf_req(sk, req), req);
+			goto done;
 		}
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-				l2cap_build_conf_req(sk, req), req);
-		goto done;
-	}
 
 	default: 
 		sk->sk_state = BT_DISCONN;
@@ -2253,8 +1682,6 @@
 {
 	struct l2cap_info_req *req = (struct l2cap_info_req *) data;
 	struct l2cap_info_rsp rsp;
-	/* length of data field in information response */
-	u8 len_data;
 	u16 type;
 
 	type = __le16_to_cpu(req->type);
@@ -2262,26 +1689,8 @@
 	BT_DBG("type 0x%4.4x", type);
 
 	rsp.type   = __cpu_to_le16(type);
-	switch (type) {
-	case L2CAP_IT_CL_MTU:
-		len_data = 2;
-		rsp.result = __cpu_to_le16(L2CAP_IR_SUCCESS);
-		*(__le16 *)(rsp.data) = __cpu_to_le16(L2CAP_DEFAULT_MTU);
-		break;
-	case L2CAP_IT_FEAT_MASK:
-		len_data = 4;
-		rsp.result = __cpu_to_le16(L2CAP_IR_SUCCESS);
-		/* currently only Flow Control Mode supported */
-		*(__le32 *)(rsp.data) = __cpu_to_le32(L2CAP_EXT_FCM);
-		break;
-	default:
-		len_data = 0;
-		rsp.result = __cpu_to_le16(L2CAP_IR_NOTSUPP);
-		break;
-	}
-
-	/* send information response */
-	l2cap_send_cmd(conn, cmd->ident, L2CAP_INFO_RSP, sizeof(rsp) + len_data, &rsp);
+	rsp.result = __cpu_to_le16(L2CAP_IR_NOTSUPP);
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_INFO_RSP, sizeof(rsp), &rsp);
 
 	return 0;
 }
@@ -2290,40 +1699,11 @@
 {
 	struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) data;
 	u16 type, result;
-	struct sock *sk;
-	u8 req[128];
-	u8 *ptr = rsp->data;
 
 	type   = __le16_to_cpu(rsp->type);
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("type 0x%4.4x result 0x%2.2x ident %d", type, result, cmd->ident);
-
-	if (!(sk = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident)))
-		return 0;
-
-	if (result == L2CAP_IR_SUCCESS) {
-		switch (type) {
-		case L2CAP_IT_CL_MTU:
-			l2cap_pi(sk)->info_mtu = __le16_to_cpup((__le16 *) ptr);
-			break;
-		case L2CAP_IT_FEAT_MASK:
-			if (*ptr & L2CAP_EXT_FCM)
-				l2cap_pi(sk)->info_ext |= L2CAP_EXT_FCM;
-			break;
-		}
-	} else {
-		l2cap_pi(sk)->conf_mode = L2CAP_MODE_BASIC;
-	}
-
-	l2cap_pi(sk)->conf_state |= L2CAP_INFO_INPUT_DONE;
-
-	/* build configuration request */
-	l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-			l2cap_build_conf_req(sk, req), req);
-
-	bh_unlock_sock(sk);
+	BT_DBG("type 0x%4.4x result 0x%2.2x", type, result);
 
 	return 0;
 }
@@ -2333,6 +1713,7 @@
 	u8 *data = skb->data;
 	int len = skb->len;
 	struct l2cap_cmd_hdr cmd;
+	u16 cmd_len;
 	int err = 0;
 
 	l2cap_raw_recv(conn, skb);
@@ -2342,18 +1723,18 @@
 		data += L2CAP_CMD_HDR_SIZE;
 		len  -= L2CAP_CMD_HDR_SIZE;
 
-		cmd.len = __le16_to_cpu(cmd.len);
+		cmd_len = __le16_to_cpu(cmd.len);
 
-		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd.len, cmd.ident);
+		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd_len, cmd.ident);
 
-		if (cmd.len > len || !cmd.ident) {
+		if (cmd_len > len || !cmd.ident) {
 			BT_DBG("corrupted command");
 			break;
 		}
 
 		switch (cmd.code) {
 		case L2CAP_COMMAND_REJ:
-			err = l2cap_command_rej(conn, &cmd, data);
+			/* FIXME: We should process this */
 			break;
 
 		case L2CAP_CONN_REQ:
@@ -2381,7 +1762,7 @@
 			break;
 
 		case L2CAP_ECHO_REQ:
-			l2cap_send_cmd(conn, cmd.ident, L2CAP_ECHO_RSP, cmd.len, data);
+			l2cap_send_cmd(conn, cmd.ident, L2CAP_ECHO_RSP, cmd_len, data);
 			break;
 
 		case L2CAP_ECHO_RSP:
@@ -2410,245 +1791,13 @@
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 		}
 
-		data += cmd.len;
-		len  -= cmd.len;
+		data += cmd_len;
+		len  -= cmd_len;
 	}
 
 	kfree_skb(skb);
 }
 
-static int l2cap_send_sframe(struct sock *sk, u8 reqseq)
-{
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-	struct sk_buff *skb = NULL;
-	struct l2cap_hdr *lh;
-	__le16 *control, *fcs;
-	int err = 0;
-
-	BT_DBG("sk %p reqseq %d", sk, reqseq);
-
-	skb = bt_skb_send_alloc(sk, L2CAP_SFRAME_SIZE, MSG_DONTWAIT, &err);
-	if (!skb)
-		return err;
-
-	/* Create L2CAP header */
-	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->cid = __cpu_to_le16(l2cap_pi(sk)->dcid);
-	lh->len = __cpu_to_le16(4);
-	
-	/* Create control field */
-	control  = (__le16 *) skb_put(skb, 2);
-	*control = __cpu_to_le16((reqseq << 8) | 1);
-
-	fcs  = (__le16 *) skb_put(skb, 2);
-	*fcs = __cpu_to_le16(crc16(0, skb->data, 6));
-
-	if ((err = hci_send_acl(conn->hcon, skb, 0)) < 0)
-		goto fail;
-
-	l2cap_start_mon_timer(sk, l2cap_pi(sk)->imon_to * HZ / 1000);
-
-	return err;
-
-fail:
-	kfree_skb(skb);
-	return err;
-}
-
-static int l2cap_invalid_frame_detection(struct sock *sk, struct sk_buff *skb)
-{
-	int err = 0;
-	u16 len, cid, control, sdu_len, fcs;
-
-	/* value of length field in frame */
-	len = get_unaligned((u16 *) skb->data);
-	cid = get_unaligned((u16 *) (skb->data + 2));
-
-	if (len != (skb->len - L2CAP_HDR_SIZE))
-		err = -1;
-
-	/* contains an unknown (reserved) cid */
-	if (cid < 0x003F)
-		err = -2;
-
-	/* contains an fcs error */
-	fcs = get_unaligned((u16 *) (skb->tail - 2));
-	if (unlikely(fcs != crc16(0, skb->data, skb->len - 2)))
-		err = -3;
-
-	/* contains a length > max possible mps */
-	if (len > L2CAP_MAX_DATA_LEN)
-		err = -4;
-
-	control = get_unaligned((u16 *) (skb->data + L2CAP_HDR_SIZE));
-	sdu_len = get_unaligned((u16 *) (skb->data + L2CAP_HDR_SIZE + L2CAP_CONTROL_SIZE));
-
-	if (control & 0x01) {
-		/* s-frame with length != 4 */
-		if (len != 4) err = -8;
-	} else {
-		/* i-frame that has fewer than 8 octets */
-		if (skb->len < 8)
-			err = -5;
-		if ((L2CAP_SAR_MASK & control) == L2CAP_SAR_START) {
-			/* contains a length > max possible mps (with SAR) */
-			if (len > L2CAP_MAX_DATA_LEN - 2)
-				err = -4;
-			/* i-frame with SAR=01 with < 10 octets */
-			if (skb->len < 10)
-				err = -6;
-			/* requested sdu len is bigger than configured mps */
-			if (sdu_len > l2cap_pi(sk)->imps)
-				err = -7;
-		}
-	}
-
-	BT_DBG("err %d", err);
-
-	return err;
-}
-
-static int l2cap_process_txseq(struct sock *sk, struct sk_buff *skb, u16 control)
-{
-	int err = 0;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u8 txseq = L2CAP_GET_TXSEQ(control);
-
-	if (txseq == pi->exp_txseq) {
-		pi->exp_txseq = (pi->exp_txseq + 1) % 64;
-	} else if (((txseq - pi->buffer_seq + 64) % 64) < pi->itxw) {
-		/* out-of-sequence i-frame */
-		pi->exp_txseq = (txseq + 1) % 64;
-	} else if ((txseq >= pi->buffer_seq) && (txseq <= pi->exp_txseq - 1)) {
-		/* duplicated i-frame */
-		err = -1;
-	} else {
-		/* invalid txseq */
-		err = -2;
-	}
-
-	BT_DBG("err %d", err);
-
-	return err;
-}
-
-static int l2cap_process_reqseq(struct sock *sk, struct sk_buff *skb, u16 control)
-{
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	u8 reqseq = L2CAP_GET_REQSEQ(control);
-
-	BT_DBG("sk %p reqseq %d", sk, reqseq);
-
-	/* accept only i-frame or s-frame with S bits set to 00 (RR) */
-	if (!(((control & 0x01) == 0x00) || ((control & 0x0F) == 0x01)))
-		return -1;
-
-	/* reqseq sequence error */
-	if (!((reqseq - pi->exp_ackseq + 64) % 64 <=
-	      (pi->next_txseq - pi->exp_ackseq + 64) % 64)) {
-		/* close channel -> send disconnect request */
-		struct l2cap_disconn_req req;
-		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-		sk->sk_state = BT_DISCONN;
-		sk->sk_err   = ECONNRESET;
-		l2cap_sock_set_timer(sk, HZ * 5);
-		req.dcid = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
-		l2cap_send_cmd(conn, l2cap_get_ident(conn),
-				L2CAP_DISCONN_REQ, sizeof(req), &req);
-		return -2;
-	}
-
-	pi->exp_ackseq = reqseq;
-
-	/*
-	if (reqseq != pi->next_txseq)
-		l2cap_start_ret_timer(sk, pi->iret_to * HZ / 1000);
-	else
-		l2cap_start_mon_timer(sk, pi->imon_to * HZ / 1000);
-	*/
-	/* FIXME: transmit any I-Frames awaiting transmission */
-
-	return 0;
-}
-
-static int l2cap_reassembly(struct sock *sk, struct sk_buff *skb, u16 control)
-{
-	u16 sdu_len = 0;
-
-	BT_DBG("sk %p control %04X", sk, control);
-
-	/* remove header, control and fcs from i-frame */
-	skb_pull(skb, L2CAP_HDR_SIZE + L2CAP_CONTROL_SIZE);
-	skb_trim(skb, skb->len - L2CAP_FCS_SIZE);
-
-	switch (L2CAP_GET_SAR(control)) {
-	case L2CAP_SAR_UNSEGMENTED:
-		l2cap_pi(sk)->buffer_seq = l2cap_pi(sk)->exp_txseq;
-		if (sock_queue_rcv_skb(sk, skb))
-			return -1;
-		if (l2cap_send_sframe(sk, l2cap_pi(sk)->buffer_seq))
-			return -6;
-		break;
-		
-	case L2CAP_SAR_START:
-		sdu_len = get_unaligned((u16 *) skb->data);
-		/* remove sdu len field */
-		skb_pull(skb, 2);
-
-		/* in case a SAR_END frame got lost make sure to free the
-		 * allocated buffer space of the last sdu */
-		kfree_skb(l2cap_pi(sk)->sdu);
-		l2cap_pi(sk)->sdu = NULL;
-		l2cap_pi(sk)->sdu_len = 0;
-			
-		/* allocate skb for complete new sdu */
-		if (!(l2cap_pi(sk)->sdu = bt_skb_alloc(sdu_len, GFP_ATOMIC)))
-			return -2;
-
-		memcpy(skb_put(l2cap_pi(sk)->sdu, skb->len), skb->data, skb->len);
-		l2cap_pi(sk)->sdu_len = sdu_len - skb->len;
-		l2cap_pi(sk)->buffer_seq = l2cap_pi(sk)->exp_txseq;
-		if (l2cap_send_sframe(sk, l2cap_pi(sk)->buffer_seq))
-			return -6;
-		break;
-		
-	default:
-		/* continuation or end of sdu frame */
-		if (!l2cap_pi(sk)->sdu_len) {
-			BT_ERR("Unexpected continuation frame (len %d)", skb->len);
-			return -3;
-		}
-
-		if (skb->len > l2cap_pi(sk)->sdu_len) {
-			BT_ERR("Fragment is too long (len %d, expected %d)",
-					skb->len, l2cap_pi(sk)->sdu_len);
-			kfree_skb(l2cap_pi(sk)->sdu);
-			l2cap_pi(sk)->sdu = NULL;
-			l2cap_pi(sk)->sdu_len = 0;
-			return -4;
-		}
-
-		memcpy(skb_put(l2cap_pi(sk)->sdu, skb->len), skb->data, skb->len);
-		l2cap_pi(sk)->sdu_len -= skb->len;
-		l2cap_pi(sk)->buffer_seq = l2cap_pi(sk)->exp_txseq;
-		if (l2cap_send_sframe(sk, l2cap_pi(sk)->buffer_seq))
-			return -6;
-
-		/* last frame for sdu */
-		if ((L2CAP_GET_SAR(control) == L2CAP_SAR_END) && 
-				(l2cap_pi(sk)->sdu_len == 0)) {
-			if (sock_queue_rcv_skb(sk, l2cap_pi(sk)->sdu))
-				return -1;
-			kfree_skb(l2cap_pi(sk)->sdu);
-			l2cap_pi(sk)->sdu = NULL;
-			l2cap_pi(sk)->sdu_len = 0;
-		}
-	}
-
-	return 0;
-}
-
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct sock *sk;
@@ -2659,44 +1808,19 @@
 		goto drop;
 	}
 
-	BT_DBG("sk %p len %d mode 0x%02X", sk, skb->len, l2cap_pi(sk)->mode);
+	BT_DBG("sk %p, len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	/* s-frame or i-frame */
-	if (l2cap_pi(sk)->mode == L2CAP_MODE_FLOW) {
-		u16 control;
-
-		if (l2cap_invalid_frame_detection(sk, skb))
-			goto drop;
-
-		control = get_unaligned((u16 *) (skb->data + L2CAP_HDR_SIZE));
-
-		if (control & 0x01) {
-			/* process s-frame */
-			if (l2cap_process_reqseq(sk, skb, control))
-				goto drop;
-		} else {
-			/* process i-frame */
-			if (l2cap_process_txseq(sk, skb, control))
-				goto drop;
-			if (l2cap_process_reqseq(sk, skb, control))
-				goto drop;
-			if (l2cap_reassembly(sk, skb, control))
-				goto drop;
-		}
-
-		goto done;
-	}
-
-	skb_pull(skb, L2CAP_HDR_SIZE);
-
-	/* b-frame with too large information payload */
 	if (l2cap_pi(sk)->imtu < skb->len)
 		goto drop;
 
-	/* ordinary b-frame */
+	/* If socket recv buffers overflows we drop data here
+	 * which is *bad* because L2CAP has to be reliable.
+	 * But we don't have any other choice. L2CAP doesn't
+	 * provide flow control mechanism. */
+
 	if (!sock_queue_rcv_skb(sk, skb))
 		goto done;
 
@@ -2742,6 +1866,7 @@
 	struct l2cap_hdr *lh = (void *) skb->data;
 	u16 cid, psm, len;
 
+	skb_pull(skb, L2CAP_HDR_SIZE);
 	cid = __le16_to_cpu(lh->cid);
 	len = __le16_to_cpu(lh->len);
 
@@ -2749,12 +1874,10 @@
 
 	switch (cid) {
 	case 0x0001:
-		skb_pull(skb, L2CAP_HDR_SIZE);
 		l2cap_sig_channel(conn, skb);
 		break;
 
 	case 0x0002:
-		skb_pull(skb, L2CAP_HDR_SIZE);
 		psm = get_unaligned((u16 *) skb->data);
 		skb_pull(skb, 2);
 		l2cap_conless_channel(conn, psm, skb);
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.18-mh1/net/bluetooth/rfcomm/tty.c linux-2.6.18-my-bt/net/bluetooth/rfcomm/tty.c
--- linux-2.6.18-mh1/net/bluetooth/rfcomm/tty.c	2006-09-23 19:56:08.000000000 -0700
+++ linux-2.6.18-my-bt/net/bluetooth/rfcomm/tty.c	2006-09-23 22:46:43.000000000 -0700
@@ -38,7 +38,6 @@
 #include <linux/skbuff.h>
 
 #include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/rfcomm.h>
 
 #ifndef CONFIG_BT_RFCOMM_DEBUG
@@ -162,24 +161,6 @@
 	return dev;
 }
 
-static struct device *rfcomm_get_device(struct rfcomm_dev *dev)
-{
-	struct hci_dev *hdev;
-	struct hci_conn *conn;
-
-	hdev = hci_get_route(&dev->dst, &dev->src);
-	if (!hdev)
-		return NULL;
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &dev->dst);
-	if (!conn)
-		return NULL;
-
-	hci_dev_put(hdev);
-
-	return &conn->dev;
-}
-
 static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 {
 	struct rfcomm_dev *dev;
@@ -263,7 +244,7 @@
 		return err;
 	}
 
-	tty_register_device(rfcomm_tty_driver, dev->id, rfcomm_get_device(dev));
+	tty_register_device(rfcomm_tty_driver, dev->id, NULL);
 
 	return dev->id;
 }


--------------050707010609040808060504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050707010609040808060504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------050707010609040808060504--
