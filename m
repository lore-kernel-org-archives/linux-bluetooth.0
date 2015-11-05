Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: root <root@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Use new hci_skb_pkt_* wrappers for drivers
Date: Thu,  5 Nov 2015 07:33:56 +0100
Message-Id: <1446705236-2062-1-git-send-email-root@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

The new hci_skb_pkt_* wrappers are mainly intented for drivers to
require less knowledge about bt_cb(sbk) handling. So after converting
the core packet handling, convert all drivers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c       |  9 ++++----
 drivers/bluetooth/bluecard_cs.c | 25 ++++++++++-----------
 drivers/bluetooth/bpa10x.c      |  4 ++--
 drivers/bluetooth/bt3c_cs.c     | 11 +++++-----
 drivers/bluetooth/btmrvl_main.c |  8 +++----
 drivers/bluetooth/btmrvl_sdio.c |  4 ++--
 drivers/bluetooth/btsdio.c      |  6 +++---
 drivers/bluetooth/btuart_cs.c   | 11 +++++-----
 drivers/bluetooth/btusb.c       | 48 ++++++++++++++++++++---------------------
 drivers/bluetooth/btwilink.c    |  8 +++----
 drivers/bluetooth/dtl1_cs.c     | 11 +++++-----
 drivers/bluetooth/hci_ath.c     |  6 +++---
 drivers/bluetooth/hci_bcm.c     |  2 +-
 drivers/bluetooth/hci_bcsp.c    | 25 ++++++++++++---------
 drivers/bluetooth/hci_h4.c      | 16 +++++++-------
 drivers/bluetooth/hci_h5.c      | 14 ++++++------
 drivers/bluetooth/hci_intel.c   | 14 ++++++------
 drivers/bluetooth/hci_ldisc.c   |  5 +++--
 drivers/bluetooth/hci_ll.c      |  4 ++--
 drivers/bluetooth/hci_qca.c     |  4 ++--
 drivers/bluetooth/hci_vhci.c    |  8 +++----
 21 files changed, 127 insertions(+), 116 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 616ec2ac1b22..72d8bfabef09 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -324,7 +324,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 			return -ENOMEM;
 		}
 
-		bt_cb(skb)->pkt_type = pkt_type;
+		hci_skb_pkt_type(skb) = pkt_type;
 
 		data->reassembly = skb;
 	} else {
@@ -469,9 +469,10 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	unsigned char buf[3];
 	int sent = 0, size, count;
 
-	BT_DBG("hdev %p skb %p type %d len %d", hdev, skb, bt_cb(skb)->pkt_type, skb->len);
+	BT_DBG("hdev %p skb %p type %d len %d", hdev, skb,
+	       hci_skb_pkt_type(skb), skb->len);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		break;
@@ -484,7 +485,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
 	count = skb->len;
 
diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 36fa1c958c74..c0b3b5576992 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -261,7 +261,7 @@ static void bluecard_write_wakeup(struct bluecard_info *info)
 		if (!skb)
 			break;
 
-		if (bt_cb(skb)->pkt_type & 0x80) {
+		if (hci_skb_pkt_type(skb) & 0x80) {
 			/* Disable RTS */
 			info->ctrl_reg |= REG_CONTROL_RTS;
 			outb(info->ctrl_reg, iobase + REG_CONTROL);
@@ -279,13 +279,13 @@ static void bluecard_write_wakeup(struct bluecard_info *info)
 		/* Mark the buffer as dirty */
 		clear_bit(ready_bit, &(info->tx_state));
 
-		if (bt_cb(skb)->pkt_type & 0x80) {
+		if (hci_skb_pkt_type(skb) & 0x80) {
 			DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 			DEFINE_WAIT(wait);
 
 			unsigned char baud_reg;
 
-			switch (bt_cb(skb)->pkt_type) {
+			switch (hci_skb_pkt_type(skb)) {
 			case PKT_BAUD_RATE_460800:
 				baud_reg = REG_CONTROL_BAUD_RATE_460800;
 				break;
@@ -402,9 +402,9 @@ static void bluecard_receive(struct bluecard_info *info,
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			bt_cb(info->rx_skb)->pkt_type = buf[i];
+			hci_skb_pkt_type(info->rx_skb) = buf[i];
 
-			switch (bt_cb(info->rx_skb)->pkt_type) {
+			switch (hci_skb_pkt_type(info->rx_skb)) {
 
 			case 0x00:
 				/* init packet */
@@ -436,7 +436,8 @@ static void bluecard_receive(struct bluecard_info *info,
 
 			default:
 				/* unknown packet */
-				BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
+				BT_ERR("Unknown HCI packet with type 0x%02x received",
+				       hci_skb_pkt_type(info->rx_skb));
 				info->hdev->stat.err_rx++;
 
 				kfree_skb(info->rx_skb);
@@ -578,21 +579,21 @@ static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 	switch (baud) {
 	case 460800:
 		cmd[4] = 0x00;
-		bt_cb(skb)->pkt_type = PKT_BAUD_RATE_460800;
+		hci_skb_pkt_type(skb) = PKT_BAUD_RATE_460800;
 		break;
 	case 230400:
 		cmd[4] = 0x01;
-		bt_cb(skb)->pkt_type = PKT_BAUD_RATE_230400;
+		hci_skb_pkt_type(skb) = PKT_BAUD_RATE_230400;
 		break;
 	case 115200:
 		cmd[4] = 0x02;
-		bt_cb(skb)->pkt_type = PKT_BAUD_RATE_115200;
+		hci_skb_pkt_type(skb) = PKT_BAUD_RATE_115200;
 		break;
 	case 57600:
 		/* Fall through... */
 	default:
 		cmd[4] = 0x03;
-		bt_cb(skb)->pkt_type = PKT_BAUD_RATE_57600;
+		hci_skb_pkt_type(skb) = PKT_BAUD_RATE_57600;
 		break;
 	}
 
@@ -660,7 +661,7 @@ static int bluecard_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct bluecard_info *info = hci_get_drvdata(hdev);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		break;
@@ -673,7 +674,7 @@ static int bluecard_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 	skb_queue_tail(&(info->txq), skb);
 
 	bluecard_write_wakeup(info);
diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 49c397e21b39..fd6b53e9bbf2 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -295,9 +295,9 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -ENOMEM;
 
 	/* Prepend skb with frame type */
-	*skb_push(skb, 1) = bt_cb(skb)->pkt_type;
+	*skb_push(skb, 1) = hci_skb_pkt_type(skb);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		dr = kmalloc(sizeof(*dr), GFP_ATOMIC);
 		if (!dr) {
diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 5803aaed958f..8165ef2fe877 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -246,10 +246,10 @@ static void bt3c_receive(struct bt3c_info *info)
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			bt_cb(info->rx_skb)->pkt_type = inb(iobase + DATA_L);
+			hci_skb_pkt_type(info->rx_skb) = inb(iobase + DATA_L);
 			inb(iobase + DATA_H);
 
-			switch (bt_cb(info->rx_skb)->pkt_type) {
+			switch (hci_skb_pkt_type(info->rx_skb)) {
 
 			case HCI_EVENT_PKT:
 				info->rx_state = RECV_WAIT_EVENT_HEADER;
@@ -268,7 +268,8 @@ static void bt3c_receive(struct bt3c_info *info)
 
 			default:
 				/* Unknown packet */
-				BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
+				BT_ERR("Unknown HCI packet with type 0x%02x received",
+				       hci_skb_pkt_type(info->rx_skb));
 				info->hdev->stat.err_rx++;
 
 				kfree_skb(info->rx_skb);
@@ -411,7 +412,7 @@ static int bt3c_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct bt3c_info *info = hci_get_drvdata(hdev);
 	unsigned long flags;
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		break;
@@ -424,7 +425,7 @@ static int bt3c_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 	skb_queue_tail(&(info->txq), skb);
 
 	spin_lock_irqsave(&(info->lock), flags);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 6af917331962..f2b38c880b11 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -196,7 +196,7 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 	if (len)
 		memcpy(skb_put(skb, len), param, len);
 
-	bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
+	hci_skb_pkt_type(skb) = MRVL_VENDOR_PKT;
 
 	skb_queue_head(&priv->adapter->tx_queue, skb);
 
@@ -387,7 +387,7 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 	skb->data[0] = (skb->len & 0x0000ff);
 	skb->data[1] = (skb->len & 0x00ff00) >> 8;
 	skb->data[2] = (skb->len & 0xff0000) >> 16;
-	skb->data[3] = bt_cb(skb)->pkt_type;
+	skb->data[3] = hci_skb_pkt_type(skb);
 
 	if (priv->hw_host_to_card)
 		ret = priv->hw_host_to_card(priv, skb->data, skb->len);
@@ -434,9 +434,9 @@ static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
-	BT_DBG("type=%d, len=%d", skb->pkt_type, skb->len);
+	BT_DBG("type=%d, len=%d", hci_skb_pkt_type(skb), skb->len);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		break;
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 71ea2a3af293..d3a4acdf98c9 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -698,7 +698,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
 	case HCI_EVENT_PKT:
-		bt_cb(skb)->pkt_type = type;
+		hci_skb_pkt_type(skb) = type;
 		skb_put(skb, buf_len);
 		skb_pull(skb, SDIO_HEADER_LEN);
 
@@ -713,7 +713,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		break;
 
 	case MRVL_VENDOR_PKT:
-		bt_cb(skb)->pkt_type = HCI_VENDOR_PKT;
+		hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 		skb_put(skb, buf_len);
 		skb_pull(skb, SDIO_HEADER_LEN);
 
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 7b624423a7e8..2b05661e3818 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -86,7 +86,7 @@ static int btsdio_tx_packet(struct btsdio_data *data, struct sk_buff *skb)
 	skb->data[0] = (skb->len & 0x0000ff);
 	skb->data[1] = (skb->len & 0x00ff00) >> 8;
 	skb->data[2] = (skb->len & 0xff0000) >> 16;
-	skb->data[3] = bt_cb(skb)->pkt_type;
+	skb->data[3] = hci_skb_pkt_type(skb);
 
 	err = sdio_writesb(data->func, REG_TDAT, skb->data, skb->len);
 	if (err < 0) {
@@ -158,7 +158,7 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	data->hdev->stat.byte_rx += len;
 
-	bt_cb(skb)->pkt_type = hdr[3];
+	hci_skb_pkt_type(skb) = hdr[3];
 
 	err = hci_recv_frame(data->hdev, skb);
 	if (err < 0)
@@ -252,7 +252,7 @@ static int btsdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		break;
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index bb8e4025fb9e..9624b29f8349 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -200,9 +200,9 @@ static void btuart_receive(struct btuart_info *info)
 
 		if (info->rx_state == RECV_WAIT_PACKET_TYPE) {
 
-			bt_cb(info->rx_skb)->pkt_type = inb(iobase + UART_RX);
+			hci_skb_pkt_type(info->rx_skb) = inb(iobase + UART_RX);
 
-			switch (bt_cb(info->rx_skb)->pkt_type) {
+			switch (hci_skb_pkt_type(info->rx_skb)) {
 
 			case HCI_EVENT_PKT:
 				info->rx_state = RECV_WAIT_EVENT_HEADER;
@@ -221,7 +221,8 @@ static void btuart_receive(struct btuart_info *info)
 
 			default:
 				/* Unknown packet */
-				BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
+				BT_ERR("Unknown HCI packet with type 0x%02x received",
+				       hci_skb_pkt_type(info->rx_skb));
 				info->hdev->stat.err_rx++;
 
 				kfree_skb(info->rx_skb);
@@ -424,7 +425,7 @@ static int btuart_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btuart_info *info = hci_get_drvdata(hdev);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		break;
@@ -437,7 +438,7 @@ static int btuart_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 	skb_queue_tail(&(info->txq), skb);
 
 	btuart_write_wakeup(info);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 92f0ee388f9e..806353410eb7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -437,22 +437,22 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 				break;
 			}
 
-			bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
-			bt_cb(skb)->expect = HCI_EVENT_HDR_SIZE;
+			hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+			hci_skb_expect(skb) = HCI_EVENT_HDR_SIZE;
 		}
 
-		len = min_t(uint, bt_cb(skb)->expect, count);
+		len = min_t(uint, hci_skb_expect(skb), count);
 		memcpy(skb_put(skb, len), buffer, len);
 
 		count -= len;
 		buffer += len;
-		bt_cb(skb)->expect -= len;
+		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_EVENT_HDR_SIZE) {
 			/* Complete event header */
-			bt_cb(skb)->expect = hci_event_hdr(skb)->plen;
+			hci_skb_expect(skb) = hci_event_hdr(skb)->plen;
 
-			if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
 
@@ -461,7 +461,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 			}
 		}
 
-		if (bt_cb(skb)->expect == 0) {
+		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
 			data->recv_event(data->hdev, skb);
 			skb = NULL;
@@ -492,24 +492,24 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 				break;
 			}
 
-			bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-			bt_cb(skb)->expect = HCI_ACL_HDR_SIZE;
+			hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
+			hci_skb_expect(skb) = HCI_ACL_HDR_SIZE;
 		}
 
-		len = min_t(uint, bt_cb(skb)->expect, count);
+		len = min_t(uint, hci_skb_expect(skb), count);
 		memcpy(skb_put(skb, len), buffer, len);
 
 		count -= len;
 		buffer += len;
-		bt_cb(skb)->expect -= len;
+		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_ACL_HDR_SIZE) {
 			__le16 dlen = hci_acl_hdr(skb)->dlen;
 
 			/* Complete ACL header */
-			bt_cb(skb)->expect = __le16_to_cpu(dlen);
+			hci_skb_expect(skb) = __le16_to_cpu(dlen);
 
-			if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
 
@@ -518,7 +518,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 			}
 		}
 
-		if (bt_cb(skb)->expect == 0) {
+		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
 			hci_recv_frame(data->hdev, skb);
 			skb = NULL;
@@ -549,22 +549,22 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 				break;
 			}
 
-			bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
-			bt_cb(skb)->expect = HCI_SCO_HDR_SIZE;
+			hci_skb_pkt_type(skb) = HCI_SCODATA_PKT;
+			hci_skb_expect(skb) = HCI_SCO_HDR_SIZE;
 		}
 
-		len = min_t(uint, bt_cb(skb)->expect, count);
+		len = min_t(uint, hci_skb_expect(skb), count);
 		memcpy(skb_put(skb, len), buffer, len);
 
 		count -= len;
 		buffer += len;
-		bt_cb(skb)->expect -= len;
+		hci_skb_expect(skb) -= len;
 
 		if (skb->len == HCI_SCO_HDR_SIZE) {
 			/* Complete SCO header */
-			bt_cb(skb)->expect = hci_sco_hdr(skb)->dlen;
+			hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
 
-			if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
 				kfree_skb(skb);
 				skb = NULL;
 
@@ -573,7 +573,7 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 			}
 		}
 
-		if (bt_cb(skb)->expect == 0) {
+		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
 			hci_recv_frame(data->hdev, skb);
 			skb = NULL;
@@ -1257,7 +1257,7 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		urb = alloc_ctrl_urb(hdev, skb);
 		if (IS_ERR(urb))
@@ -1853,7 +1853,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 
 	*skb_put(skb, 1) = 0x00;
 
-	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 
 	return hci_recv_frame(hdev, skb);
 }
@@ -1945,7 +1945,7 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 			struct hci_command_hdr *cmd = (void *)skb->data;
diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 57eb935aedc7..24a652f9252b 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -249,10 +249,10 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	hst = hci_get_drvdata(hdev);
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
-	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type,
-			skb->len);
+	BT_DBG("%s: type %d len %d", hdev->name, hci_skb_pkt_type(skb),
+	       skb->len);
 
 	/* Insert skb to shared transport layer's transmit queue.
 	 * Freeing skb memory is taken care in shared transport layer,
@@ -268,7 +268,7 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	/* ST accepted our skb. So, Go ahead and do rest */
 	hdev->stat.byte_tx += len;
-	ti_st_tx_complete(hst, bt_cb(skb)->pkt_type);
+	ti_st_tx_complete(hst, hci_skb_pkt_type(skb));
 
 	return 0;
 }
diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 5026f66fac88..6317c6f323bf 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -239,7 +239,7 @@ static void dtl1_receive(struct dtl1_info *info)
 				info->rx_count = nsh->len + (nsh->len & 0x0001);
 				break;
 			case RECV_WAIT_DATA:
-				bt_cb(info->rx_skb)->pkt_type = nsh->type;
+				hci_skb_pkt_type(info->rx_skb) = nsh->type;
 
 				/* remove PAD byte if it exists */
 				if (nsh->len & 0x0001) {
@@ -250,7 +250,7 @@ static void dtl1_receive(struct dtl1_info *info)
 				/* remove NSH */
 				skb_pull(info->rx_skb, NSHL);
 
-				switch (bt_cb(info->rx_skb)->pkt_type) {
+				switch (hci_skb_pkt_type(info->rx_skb)) {
 				case 0x80:
 					/* control data for the Nokia Card */
 					dtl1_control(info, info->rx_skb);
@@ -259,12 +259,13 @@ static void dtl1_receive(struct dtl1_info *info)
 				case 0x83:
 				case 0x84:
 					/* send frame to the HCI layer */
-					bt_cb(info->rx_skb)->pkt_type &= 0x0f;
+					hci_skb_pkt_type(info->rx_skb) &= 0x0f;
 					hci_recv_frame(info->hdev, info->rx_skb);
 					break;
 				default:
 					/* unknown packet */
-					BT_ERR("Unknown HCI packet with type 0x%02x received", bt_cb(info->rx_skb)->pkt_type);
+					BT_ERR("Unknown HCI packet with type 0x%02x received",
+					       hci_skb_pkt_type(info->rx_skb));
 					kfree_skb(info->rx_skb);
 					break;
 				}
@@ -386,7 +387,7 @@ static int dtl1_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct sk_buff *s;
 	struct nsh nsh;
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
 		nsh.type = 0x81;
diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index d776dfd51478..0ccf6bf01ed4 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -205,7 +205,7 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
 	struct ath_struct *ath = hu->priv;
 
-	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
+	if (hci_skb_pkt_type(skb) == HCI_SCODATA_PKT) {
 		kfree_skb(skb);
 		return 0;
 	}
@@ -213,7 +213,7 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	/* Update power management enable flag with parameters of
 	 * HCI sleep enable vendor specific HCI command.
 	 */
-	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+	if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT) {
 		struct hci_command_hdr *hdr = (void *)skb->data;
 
 		if (__le16_to_cpu(hdr->opcode) == HCI_OP_ATH_SLEEP)
@@ -223,7 +223,7 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	BT_DBG("hu %p skb %p", hu, skb);
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
 	skb_queue_tail(&ath->txq, skb);
 	set_bit(HCI_UART_SENDING, &hu->tx_state);
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index cb852cc750b7..3eed35e0207c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -472,7 +472,7 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	bt_dev_dbg(hu->hdev, "hu %p skb %p", hu, skb);
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 	skb_queue_tail(&bcm->txq, skb);
 
 	return 0;
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index d0b615a932d1..064f2fefad62 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -155,7 +155,7 @@ static int bcsp_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		return 0;
 	}
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_ACLDATA_PKT:
 	case HCI_COMMAND_PKT:
 		skb_queue_tail(&bcsp->rel, skb);
@@ -231,7 +231,7 @@ static struct sk_buff *bcsp_prepare_pkt(struct bcsp_struct *bcsp, u8 *data,
 	if (!nskb)
 		return NULL;
 
-	bt_cb(nskb)->pkt_type = pkt_type;
+	hci_skb_pkt_type(nskb) = pkt_type;
 
 	bcsp_slip_msgdelim(nskb);
 
@@ -291,7 +291,10 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 
 	skb = skb_dequeue(&bcsp->unrel);
 	if (skb != NULL) {
-		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);
+		struct sk_buff *nskb;
+
+		nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len,
+					hci_skb_pkt_type(skb));
 		if (nskb) {
 			kfree_skb(skb);
 			return nskb;
@@ -310,8 +313,10 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
 	if (bcsp->unack.qlen < BCSP_TXWINSIZE) {
 		skb = skb_dequeue(&bcsp->rel);
 		if (skb != NULL) {
-			struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len,
-								bt_cb(skb)->pkt_type);
+			struct sk_buff *nskb;
+
+			nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len,
+						hci_skb_pkt_type(skb));
 			if (nskb) {
 				__skb_queue_tail(&bcsp->unack, skb);
 				mod_timer(&bcsp->tbcsp, jiffies + HZ / 4);
@@ -412,7 +417,7 @@ static void bcsp_handle_le_pkt(struct hci_uart *hu)
 		if (!nskb)
 			return;
 		memcpy(skb_put(nskb, 4), conf_rsp_pkt, 4);
-		bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
+		hci_skb_pkt_type(nskb) = BCSP_LE_PKT;
 
 		skb_queue_head(&bcsp->unrel, nskb);
 		hci_uart_tx_wakeup(hu);
@@ -494,14 +499,14 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 	bcsp_pkt_cull(bcsp);
 	if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
 			bcsp->rx_skb->data[0] & 0x80) {
-		bt_cb(bcsp->rx_skb)->pkt_type = HCI_ACLDATA_PKT;
+		hci_skb_pkt_type(bcsp->rx_skb) = HCI_ACLDATA_PKT;
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
 			bcsp->rx_skb->data[0] & 0x80) {
-		bt_cb(bcsp->rx_skb)->pkt_type = HCI_EVENT_PKT;
+		hci_skb_pkt_type(bcsp->rx_skb) = HCI_EVENT_PKT;
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
-		bt_cb(bcsp->rx_skb)->pkt_type = HCI_SCODATA_PKT;
+		hci_skb_pkt_type(bcsp->rx_skb) = HCI_SCODATA_PKT;
 		pass_up = 1;
 	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
 			!(bcsp->rx_skb->data[0] & 0x80)) {
@@ -523,7 +528,7 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
 				hdr.evt = 0xff;
 				hdr.plen = bcsp->rx_skb->len;
 				memcpy(skb_push(bcsp->rx_skb, HCI_EVENT_HDR_SIZE), &hdr, HCI_EVENT_HDR_SIZE);
-				bt_cb(bcsp->rx_skb)->pkt_type = HCI_EVENT_PKT;
+				hci_skb_pkt_type(bcsp->rx_skb) = HCI_EVENT_PKT;
 
 				hci_recv_frame(hu->hdev, bcsp->rx_skb);
 			} else {
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index a6fce48da0fb..635597b6e168 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -108,7 +108,7 @@ static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	BT_DBG("hu %p skb %p", hu, skb);
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 	skb_queue_tail(&h4->txq, skb);
 
 	return 0;
@@ -184,8 +184,8 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 				if (!skb)
 					return ERR_PTR(-ENOMEM);
 
-				bt_cb(skb)->pkt_type = (&pkts[i])->type;
-				bt_cb(skb)->expect = (&pkts[i])->hlen;
+				hci_skb_pkt_type(skb) = (&pkts[i])->type;
+				hci_skb_expect(skb) = (&pkts[i])->hlen;
 				break;
 			}
 
@@ -197,18 +197,18 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			buffer += 1;
 		}
 
-		len = min_t(uint, bt_cb(skb)->expect - skb->len, count);
+		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
 		memcpy(skb_put(skb, len), buffer, len);
 
 		count -= len;
 		buffer += len;
 
 		/* Check for partial packet */
-		if (skb->len < bt_cb(skb)->expect)
+		if (skb->len < hci_skb_expect(skb))
 			continue;
 
 		for (i = 0; i < pkts_count; i++) {
-			if (bt_cb(skb)->pkt_type == (&pkts[i])->type)
+			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
 				break;
 		}
 
@@ -228,7 +228,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			case 1:
 				/* Single octet variable length */
 				dlen = skb->data[(&pkts[i])->loff];
-				bt_cb(skb)->expect += dlen;
+				hci_skb_expect(skb) += dlen;
 
 				if (skb_tailroom(skb) < dlen) {
 					kfree_skb(skb);
@@ -239,7 +239,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 				/* Double octet variable length */
 				dlen = get_unaligned_le16(skb->data +
 							  (&pkts[i])->loff);
-				bt_cb(skb)->expect += dlen;
+				hci_skb_expect(skb) += dlen;
 
 				if (skb_tailroom(skb) < dlen) {
 					kfree_skb(skb);
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index abee2216fdeb..ebefe5eb6b71 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -107,7 +107,7 @@ static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
 	if (!nskb)
 		return;
 
-	bt_cb(nskb)->pkt_type = HCI_3WIRE_LINK_PKT;
+	hci_skb_pkt_type(nskb) = HCI_3WIRE_LINK_PKT;
 
 	memcpy(skb_put(nskb, len), data, len);
 
@@ -360,7 +360,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
 	case HCI_EVENT_PKT:
 	case HCI_ACLDATA_PKT:
 	case HCI_SCODATA_PKT:
-		bt_cb(h5->rx_skb)->pkt_type = H5_HDR_PKT_TYPE(hdr);
+		hci_skb_pkt_type(h5->rx_skb) = H5_HDR_PKT_TYPE(hdr);
 
 		/* Remove Three-wire header */
 		skb_pull(h5->rx_skb, 4);
@@ -562,7 +562,7 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		return 0;
 	}
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_ACLDATA_PKT:
 	case HCI_COMMAND_PKT:
 		skb_queue_tail(&h5->rel, skb);
@@ -573,7 +573,7 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		break;
 
 	default:
-		BT_ERR("Unknown packet type %u", bt_cb(skb)->pkt_type);
+		BT_ERR("Unknown packet type %u", hci_skb_pkt_type(skb));
 		kfree_skb(skb);
 		break;
 	}
@@ -642,7 +642,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
 	if (!nskb)
 		return NULL;
 
-	bt_cb(nskb)->pkt_type = pkt_type;
+	hci_skb_pkt_type(nskb) = pkt_type;
 
 	h5_slip_delim(nskb);
 
@@ -697,7 +697,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 
 	skb = skb_dequeue(&h5->unrel);
 	if (skb) {
-		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
+		nskb = h5_prepare_pkt(hu, hci_skb_pkt_type(skb),
 				      skb->data, skb->len);
 		if (nskb) {
 			kfree_skb(skb);
@@ -715,7 +715,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 
 	skb = skb_dequeue(&h5->rel);
 	if (skb) {
-		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
+		nskb = h5_prepare_pkt(hu, hci_skb_pkt_type(skb),
 				      skb->data, skb->len);
 		if (nskb) {
 			__skb_queue_tail(&h5->unack, skb);
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 4a414a5a3165..69760e2850d9 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -186,7 +186,7 @@ static int intel_lpm_suspend(struct hci_uart *hu)
 	}
 
 	memcpy(skb_put(skb, sizeof(suspend)), suspend, sizeof(suspend));
-	bt_cb(skb)->pkt_type = HCI_LPM_PKT;
+	hci_skb_pkt_type(skb) = HCI_LPM_PKT;
 
 	set_bit(STATE_LPM_TRANSACTION, &intel->flags);
 
@@ -230,7 +230,7 @@ static int intel_lpm_resume(struct hci_uart *hu)
 		return -ENOMEM;
 	}
 
-	bt_cb(skb)->pkt_type = HCI_LPM_WAKE_PKT;
+	hci_skb_pkt_type(skb) = HCI_LPM_WAKE_PKT;
 
 	set_bit(STATE_LPM_TRANSACTION, &intel->flags);
 
@@ -272,7 +272,7 @@ static int intel_lpm_host_wake(struct hci_uart *hu)
 
 	memcpy(skb_put(skb, sizeof(lpm_resume_ack)), lpm_resume_ack,
 	       sizeof(lpm_resume_ack));
-	bt_cb(skb)->pkt_type = HCI_LPM_PKT;
+	hci_skb_pkt_type(skb) = HCI_LPM_PKT;
 
 	/* LPM flow is a priority, enqueue packet at list head */
 	skb_queue_head(&intel->txq, skb);
@@ -467,7 +467,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 
 	*skb_put(skb, 1) = 0x00;
 
-	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 
 	return hci_recv_frame(hdev, skb);
 }
@@ -517,7 +517,7 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	}
 
 	memcpy(skb_put(skb, sizeof(speed_cmd)), speed_cmd, sizeof(speed_cmd));
-	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
 
 	hci_uart_set_flow_control(hu, true);
 
@@ -1126,7 +1126,7 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 		return skb;
 
 	if (test_bit(STATE_BOOTLOADER, &intel->flags) &&
-	    (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT)) {
+	    (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT)) {
 		struct hci_command_hdr *cmd = (void *)skb->data;
 		__u16 opcode = le16_to_cpu(cmd->opcode);
 
@@ -1140,7 +1140,7 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 	}
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
 	return skb;
 }
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 96bcec5598c2..03146d707a95 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -162,7 +162,7 @@ restart:
 			break;
 		}
 
-		hci_uart_tx_complete(hu, bt_cb(skb)->pkt_type);
+		hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 		kfree_skb(skb);
 	}
 
@@ -248,7 +248,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 
-	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
+	BT_DBG("%s: type %d len %d", hdev->name, hci_skb_pkt_type(skb),
+	       skb->len);
 
 	hu->proto->enqueue(hu, skb);
 
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 9ee24b075f79..02692fe30279 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -307,7 +307,7 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	BT_DBG("hu %p skb %p", hu, skb);
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
 	/* lock hcill state */
 	spin_lock_irqsave(&ll->hcill_lock, flags);
@@ -493,7 +493,7 @@ static int ll_recv(struct hci_uart *hu, const void *data, int count)
 			return -ENOMEM;
 		}
 
-		bt_cb(ll->rx_skb)->pkt_type = type;
+		hci_skb_pkt_type(ll->rx_skb) = type;
 	}
 
 	return count;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 77eae64000b3..4d32a7c52dd0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -678,7 +678,7 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	       qca->tx_ibs_state);
 
 	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
 	/* Don't go to sleep in middle of patch download or
 	 * Out-Of-Band(GPIOs control) sleep is selected.
@@ -873,7 +873,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Assign commands to change baudrate and packet type. */
 	memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd));
-	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
 
 	skb_queue_tail(&qca->txq, skb);
 	hci_uart_tx_wakeup(hu);
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index ed888e302bc3..80783dcb7f57 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -80,7 +80,7 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 	skb_queue_tail(&data->readq, skb);
 
 	wake_up_interruptible(&data->read_wait);
@@ -140,7 +140,7 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 		return -EBUSY;
 	}
 
-	bt_cb(skb)->pkt_type = HCI_VENDOR_PKT;
+	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
 
 	*skb_put(skb, 1) = 0xff;
 	*skb_put(skb, 1) = opcode;
@@ -183,7 +183,7 @@ static inline ssize_t vhci_get_user(struct vhci_data *data,
 			return -ENODEV;
 		}
 
-		bt_cb(skb)->pkt_type = pkt_type;
+		hci_skb_pkt_type(skb) = pkt_type;
 
 		ret = hci_recv_frame(data->hdev, skb);
 		break;
@@ -234,7 +234,7 @@ static inline ssize_t vhci_put_user(struct vhci_data *data,
 
 	data->hdev->stat.byte_tx += len;
 
-	switch (bt_cb(skb)->pkt_type) {
+	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
 		data->hdev->stat.cmd_tx++;
 		break;
-- 
2.5.0

