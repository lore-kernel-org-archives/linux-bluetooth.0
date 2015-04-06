Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Provide generic H:4 receive framework
Date: Sun,  5 Apr 2015 23:44:59 -0700
Message-Id: <1428302699-24839-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Future H:4 based UART drivers require custom packet types and custom
receive functions. To support this, extended the h4_recv_buf function
with a packet definition table.

For the default H:4 packets types of ACL data, SCO data and events,
provide helpers to reduce the amount of code duplication.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c  |   9 +++-
 drivers/bluetooth/hci_bcm.c  |   9 +++-
 drivers/bluetooth/hci_h4.c   | 119 ++++++++++++++++++++++---------------------
 drivers/bluetooth/hci_uart.h |  33 +++++++++++-
 4 files changed, 110 insertions(+), 60 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 54af95c95b07..1b3f8647ea2f 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -190,12 +190,19 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&ath->txq);
 }
 
+static const struct h4_recv_pkt ath_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+};
+
 /* Recv data */
 static int ath_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct ath_struct *ath = hu->priv;
 
-	ath->rx_skb = h4_recv_buf(hu->hdev, ath->rx_skb, data, count);
+	ath->rx_skb = h4_recv_buf(hu->hdev, ath->rx_skb, data, count,
+				  ath_recv_pkts, ARRAY_SIZE(ath_recv_pkts));
 	if (IS_ERR(ath->rx_skb)) {
 		int err = PTR_ERR(ath->rx_skb);
 		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index fe1905c4beb2..1ec0b4a5ffa6 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -86,6 +86,12 @@ static int bcm_setup(struct hci_uart *hu)
 	return btbcm_setup_patchram(hu->hdev);
 }
 
+static const struct h4_recv_pkt bcm_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+};
+
 static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct bcm_data *bcm = hu->priv;
@@ -93,7 +99,8 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
-	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count);
+	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
+				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
 	if (IS_ERR(bcm->rx_skb)) {
 		int err = PTR_ERR(bcm->rx_skb);
 		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 07f5f7a21961..f7190f01e135 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -40,6 +40,7 @@
 #include <linux/signal.h>
 #include <linux/ioctl.h>
 #include <linux/skbuff.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -113,6 +114,12 @@ static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
+static const struct h4_recv_pkt h4_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+};
+
 /* Recv data */
 static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
@@ -121,7 +128,8 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
-	h4->rx_skb = h4_recv_buf(hu->hdev, h4->rx_skb, data, count);
+	h4->rx_skb = h4_recv_buf(hu->hdev, h4->rx_skb, data, count,
+				 h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
 	if (IS_ERR(h4->rx_skb)) {
 		int err = PTR_ERR(h4->rx_skb);
 		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
@@ -159,96 +167,93 @@ int __exit h4_deinit(void)
 }
 
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
-			    const unsigned char *buffer, int count)
+			    const unsigned char *buffer, int count,
+			    const struct h4_recv_pkt *pkts, int pkts_count)
 {
 	while (count) {
-		int len;
+		int i, len;
 
 		if (!skb) {
-			switch (buffer[0]) {
-			case HCI_ACLDATA_PKT:
-				skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE,
-						   GFP_ATOMIC);
-				if (!skb)
-					return ERR_PTR(-ENOMEM);
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != (&pkts[i])->type)
+					continue;
 
-				bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-				bt_cb(skb)->expect = HCI_ACL_HDR_SIZE;
-				break;
-			case HCI_SCODATA_PKT:
-				skb = bt_skb_alloc(HCI_MAX_SCO_SIZE,
+				skb = bt_skb_alloc((&pkts[i])->maxlen,
 						   GFP_ATOMIC);
 				if (!skb)
 					return ERR_PTR(-ENOMEM);
 
-				bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
-				bt_cb(skb)->expect = HCI_SCO_HDR_SIZE;
+				bt_cb(skb)->pkt_type = (&pkts[i])->type;
+				bt_cb(skb)->expect = (&pkts[i])->hlen;
 				break;
-			case HCI_EVENT_PKT:
-				skb = bt_skb_alloc(HCI_MAX_EVENT_SIZE,
-						   GFP_ATOMIC);
-				if (!skb)
-					return ERR_PTR(-ENOMEM);
+			}
 
-				bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
-				bt_cb(skb)->expect = HCI_EVENT_HDR_SIZE;
-				break;
-			default:
+			/* Check for invalid packet type */
+			if (!skb)
 				return ERR_PTR(-EILSEQ);
-			}
 
 			count -= 1;
 			buffer += 1;
 		}
 
-		len = min_t(uint, bt_cb(skb)->expect, count);
+		len = min_t(uint, bt_cb(skb)->expect - skb->len, count);
 		memcpy(skb_put(skb, len), buffer, len);
 
 		count -= len;
 		buffer += len;
-		bt_cb(skb)->expect -= len;
 
-		switch (bt_cb(skb)->pkt_type) {
-		case HCI_ACLDATA_PKT:
-			if (skb->len == HCI_ACL_HDR_SIZE) {
-				__le16 dlen = hci_acl_hdr(skb)->dlen;
+		/* Check for partial packet */
+		if (skb->len < bt_cb(skb)->expect)
+			continue;
+
+		for (i = 0; i < pkts_count; i++) {
+			if (bt_cb(skb)->pkt_type == (&pkts[i])->type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
 
-				/* Complete ACL header */
-				bt_cb(skb)->expect = __le16_to_cpu(dlen);
+		if (skb->len == (&pkts[i])->hlen) {
+			u16 dlen;
 
-				if (skb_tailroom(skb) < bt_cb(skb)->expect) {
-					kfree_skb(skb);
-					return ERR_PTR(-EMSGSIZE);
-				}
-			}
-			break;
-		case HCI_SCODATA_PKT:
-			if (skb->len == HCI_SCO_HDR_SIZE) {
-				/* Complete SCO header */
-				bt_cb(skb)->expect = hci_sco_hdr(skb)->dlen;
+			switch ((&pkts[i])->lsize) {
+			case 0:
+				/* No variable data length */
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[(&pkts[i])->loff];
+				bt_cb(skb)->expect += dlen;
 
-				if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+				if (skb_tailroom(skb) < dlen) {
 					kfree_skb(skb);
 					return ERR_PTR(-EMSGSIZE);
 				}
-			}
-			break;
-		case HCI_EVENT_PKT:
-			if (skb->len == HCI_EVENT_HDR_SIZE) {
-				/* Complete event header */
-				bt_cb(skb)->expect = hci_event_hdr(skb)->plen;
+				break;
+			case 2:
+				/* Double octet variable length */
+				dlen = get_unaligned_le16(skb->data +
+							  (&pkts[i])->loff);
+				bt_cb(skb)->expect += dlen;
 
-				if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+				if (skb_tailroom(skb) < dlen) {
 					kfree_skb(skb);
 					return ERR_PTR(-EMSGSIZE);
 				}
+				break;
+			default:
+				/* Unsupported variable length */
+				kfree_skb(skb);
+				return ERR_PTR(-EILSEQ);
 			}
-			break;
-		}
-
-		if (bt_cb(skb)->expect == 0) {
+		} else {
 			/* Complete frame */
-			hci_recv_frame(hdev, skb);
+			(&pkts[i])->recv(hdev, skb);
 			skb = NULL;
 		}
 	}
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index a3108abce5d3..d1fa6263f7c2 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -101,8 +101,39 @@ int hci_uart_init_ready(struct hci_uart *hu);
 int h4_init(void);
 int h4_deinit(void);
 
+struct h4_recv_pkt {
+	u8  type;	/* Packet type */
+	u8  hlen;	/* Header length */
+	u8  loff;	/* Data length offset in header */
+	u8  lsize;	/* Data length field size */
+	u16 maxlen;	/* Max overall packet length */
+	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+#define H4_RECV_ACL \
+	.type = HCI_ACLDATA_PKT, \
+	.hlen = HCI_ACL_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
+#define H4_RECV_SCO \
+	.type = HCI_SCODATA_PKT, \
+	.hlen = HCI_SCO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_SCO_SIZE
+
+#define H4_RECV_EVENT \
+	.type = HCI_EVENT_PKT, \
+	.hlen = HCI_EVENT_HDR_SIZE, \
+	.loff = 1, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
-			    const unsigned char *buffer, int count);
+			    const unsigned char *buffer, int count,
+			    const struct h4_recv_pkt *pkts, int pkts_count);
 #endif
 
 #ifdef CONFIG_BT_HCIUART_BCSP
-- 
2.1.0

