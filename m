Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix packet size informed to the controller
Date: Wed,  9 May 2012 10:12:38 -0300
Message-Id: <1336569159-4710-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

skb->len is the wrong var to tell the size of a packet, skb->len keeps the
size of the overall skb, including its head and fragments, then when
sending the head the wrong size is passed if the we have a framented skb.
We fix this by using skb_datalen(skb) which is the total skb size minus
the fragments size, i.e., the actual head size.

This bug appeared when implementing MSG_MORE support for L2CAP sockets, it
never showed up before because l2cap_skbuff_fromiovec() never accounted skb
size correctly. A following patch will fix this.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 drivers/bluetooth/bluecard_cs.c |    5 +++--
 drivers/bluetooth/bpa10x.c      |    4 ++--
 drivers/bluetooth/bt3c_cs.c     |    4 ++--
 drivers/bluetooth/btusb.c       |    4 ++--
 drivers/bluetooth/btwilink.c    |    2 +-
 drivers/bluetooth/dtl1_cs.c     |   13 +++++++------
 drivers/bluetooth/hci_bcsp.c    |    8 ++++++--
 drivers/bluetooth/hci_ldisc.c   |    7 ++++---
 drivers/bluetooth/hci_vhci.c    |    2 +-
 net/bluetooth/hci_core.c        |    2 +-
 10 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 1fcd923..c64ee02 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -270,7 +270,8 @@ static void bluecard_write_wakeup(bluecard_info_t *info)
 		bluecard_enable_activity_led(info);
 
 		/* Send frame */
-		len = bluecard_write(iobase, offset, skb->data, skb->len);
+		len = bluecard_write(iobase, offset, skb->data,
+				     skb_headlen(skb));
 
 		/* Tell the FPGA to send the data */
 		outb_p(command, iobase + REG_COMMAND);
@@ -321,7 +322,7 @@ static void bluecard_write_wakeup(bluecard_info_t *info)
 			finish_wait(&wq, &wait);
 		}
 
-		if (len == skb->len) {
+		if (len == skb_headlen(skb)) {
 			kfree_skb(skb);
 		} else {
 			skb_pull(skb, len);
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index d894340..c09f29f 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -398,8 +398,8 @@ static int bpa10x_send_frame(struct sk_buff *skb)
 	case HCI_ACLDATA_PKT:
 		pipe = usb_sndbulkpipe(data->udev, 0x02);
 
-		usb_fill_bulk_urb(urb, data->udev, pipe,
-				skb->data, skb->len, bpa10x_tx_complete, skb);
+		usb_fill_bulk_urb(urb, data->udev, pipe, skb->data,
+				  skb_headlen(skb), bpa10x_tx_complete, skb);
 
 		hdev->stat.acl_tx++;
 		break;
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 308c859..b19d134 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -200,9 +200,9 @@ static void bt3c_write_wakeup(bt3c_info_t *info)
 		}
 
 		/* Send frame */
-		len = bt3c_write(iobase, 256, skb->data, skb->len);
+		len = bt3c_write(iobase, 256, skb->data, skb_headlen(skb));
 
-		if (len != skb->len) {
+		if (len != skb_headlen(skb)) {
 			BT_ERR("Very strange");
 		}
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cb480f1..0e3ec17 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -739,8 +739,8 @@ static int btusb_send_frame(struct sk_buff *skb)
 		pipe = usb_sndbulkpipe(data->udev,
 					data->bulk_tx_ep->bEndpointAddress);
 
-		usb_fill_bulk_urb(urb, data->udev, pipe,
-				skb->data, skb->len, btusb_tx_complete, skb);
+		usb_fill_bulk_urb(urb, data->udev, pipe, skb->data,
+				  skb_headlen(skb), btusb_tx_complete, skb);
 
 		hdev->stat.acl_tx++;
 		break;
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 8869469..3929eff 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -270,7 +270,7 @@ static int ti_st_send_frame(struct sk_buff *skb)
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 
 	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type,
-			skb->len);
+	       skb_headlen(skb));
 
 	/* Insert skb to shared transport layer's transmit queue.
 	 * Freeing skb memory is taken care in shared transport layer,
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 6e8d961..92e520c 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -157,9 +157,9 @@ static void dtl1_write_wakeup(dtl1_info_t *info)
 			break;
 
 		/* Send frame */
-		len = dtl1_write(iobase, 32, skb->data, skb->len);
+		len = dtl1_write(iobase, 32, skb->data, skb_headlen(skb));
 
-		if (len == skb->len) {
+		if (len == skb_headlen(skb)) {
 			set_bit(XMIT_WAITING, &(info->tx_state));
 			kfree_skb(skb);
 		} else {
@@ -389,6 +389,7 @@ static int dtl1_hci_send_frame(struct sk_buff *skb)
 	struct hci_dev *hdev = (struct hci_dev *)(skb->dev);
 	struct sk_buff *s;
 	nsh_t nsh;
+	int len = skb_headlen(skb);
 
 	if (!hdev) {
 		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
@@ -415,15 +416,15 @@ static int dtl1_hci_send_frame(struct sk_buff *skb)
 	};
 
 	nsh.zero = 0;
-	nsh.len = skb->len;
+	nsh.len = len;
 
-	s = bt_skb_alloc(NSHL + skb->len + 1, GFP_ATOMIC);
+	s = bt_skb_alloc(NSHL + len + 1, GFP_ATOMIC);
 	if (!s)
 		return -ENOMEM;
 
 	skb_reserve(s, NSHL);
-	skb_copy_from_linear_data(skb, skb_put(s, skb->len), skb->len);
-	if (skb->len & 0x0001)
+	skb_copy_from_linear_data(skb, skb_put(s, len), len);
+	if (len & 0x0001)
 		*skb_put(s, 1) = 0;	/* PAD */
 
 	/* Prepend skb with Nokia frame header and queue */
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 661a8dc..64a69fa 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -292,7 +292,9 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	   since they have priority */
 
 	if ((skb = skb_dequeue(&bcsp->unrel)) != NULL) {
-		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
+		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data,
+							skb_headlen(skb),
+							bt_cb(skb)->pkt_type);
 		if (nskb) {
 			kfree_skb(skb);
 			return nskb;
@@ -309,7 +311,9 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
 	if (bcsp->unack.qlen < BCSP_TXWINSIZE && (skb = skb_dequeue(&bcsp->rel)) != NULL) {
-		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
+		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data,
+							skb_headlen(skb),
+							bt_cb(skb)->pkt_type);
 		if (nskb) {
 			__skb_queue_tail(&bcsp->unack, skb);
 			mod_timer(&bcsp->tbcsp, jiffies + HZ / 4);
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e564579..f6d551d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -136,11 +136,11 @@ restart:
 		int len;
 
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-		len = tty->ops->write(tty, skb->data, skb->len);
+		len = tty->ops->write(tty, skb->data, skb_headlen(skb));
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
-		if (skb->len) {
+		if (skb_headlen(skb)) {
 			hu->tx_skb = skb;
 			break;
 		}
@@ -220,7 +220,8 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 
 	hu = hci_get_drvdata(hdev);
 
-	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
+	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type,
+	       skb_headlen(skb));
 
 	hu->proto->enqueue(hu, skb);
 
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 3f72595..1381511 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -135,7 +135,7 @@ static inline ssize_t vhci_put_user(struct vhci_data *data,
 	char __user *ptr = buf;
 	int len, total = 0;
 
-	len = min_t(unsigned int, skb->len, count);
+	len = min_t(unsigned int, skb_headlen(skb), count);
 
 	if (copy_to_user(ptr, skb->data, len))
 		return -EFAULT;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a492b374..f8d5b8d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2147,7 +2147,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 {
 	struct hci_acl_hdr *hdr;
-	int len = skb->len;
+	int len = skb_headlen(skb);
 
 	skb_push(skb, HCI_ACL_HDR_SIZE);
 	skb_reset_transport_header(skb);
-- 
1.7.10.1

