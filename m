Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/17] Bluetooth: Add basic state tracking to Three-wire UART driver
Date: Wed, 27 Jun 2012 14:25:52 +0300
Message-Id: <1340796367-10321-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds basic state tracking and socket buffer handling to the
Three-wire UART (H5) HCI driver.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |   98 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6353d00..c610ba3 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -30,14 +30,50 @@
 
 #include "hci_uart.h"
 
+#define H5_TXWINSIZE 4
+
+struct h5 {
+	struct sk_buff_head unack;	/* Unack'ed packets queue */
+	struct sk_buff_head rel;	/* Reliable packets queue */
+	struct sk_buff_head unrel;	/* Unreliable packets queue */
+
+	struct sk_buff *rx_skb;
+
+	bool txack_req;
+
+	u8 msgq_txseq;
+};
+
 static int h5_open(struct hci_uart *hu)
 {
-	return -ENOSYS;
+	struct h5 *h5;
+
+	BT_DBG("hu %p", hu);
+
+	h5 = kzalloc(sizeof(*h5), GFP_KERNEL);
+	if (!h5)
+		return -ENOMEM;
+
+	hu->priv = h5;
+
+	skb_queue_head_init(&h5->unack);
+	skb_queue_head_init(&h5->rel);
+	skb_queue_head_init(&h5->unrel);
+
+	return 0;
 }
 
 static int h5_close(struct hci_uart *hu)
 {
-	return -ENOSYS;
+	struct h5 *h5 = hu->priv;
+
+	skb_queue_purge(&h5->unack);
+	skb_queue_purge(&h5->rel);
+	skb_queue_purge(&h5->unrel);
+
+	kfree(h5);
+
+	return 0;
 }
 
 static int h5_recv(struct hci_uart *hu, void *data, int count)
@@ -47,17 +83,71 @@ static int h5_recv(struct hci_uart *hu, void *data, int count)
 
 static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
-	return -ENOSYS;
+	struct h5 *h5 = hu->priv;
+
+	if (skb->len > 0xfff) {
+		BT_ERR("Packet too long (%u bytes)", skb->len);
+		kfree_skb(skb);
+		return 0;
+	}
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_ACLDATA_PKT:
+	case HCI_COMMAND_PKT:
+		skb_queue_tail(&h5->rel, skb);
+		break;
+
+	case HCI_SCODATA_PKT:
+		skb_queue_tail(&h5->unrel, skb);
+		break;
+
+	default:
+		BT_ERR("Unknown packet type %u", bt_cb(skb)->pkt_type);
+		kfree_skb(skb);
+		break;
+	}
+
+	return 0;
+}
+
+static struct sk_buff *h5_prepare_pkt(struct h5 *h5, struct sk_buff *skb)
+{
+	h5->txack_req = false;
+	return NULL;
+}
+
+static struct sk_buff *h5_prepare_ack(struct h5 *h5)
+{
+	h5->txack_req = false;
+	return NULL;
 }
 
 static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 {
+	struct h5 *h5 = hu->priv;
+	struct sk_buff *skb, *nskb;
+
+	if ((skb = skb_dequeue(&h5->unrel)) != NULL) {
+		nskb = h5_prepare_pkt(h5, skb);
+		if (nskb) {
+			kfree_skb(skb);
+			return nskb;
+		}
+
+		skb_queue_head(&h5->unrel, skb);
+		BT_ERR("Could not dequeue pkt because alloc_skb failed");
+	}
+
+	if (h5->txack_req)
+		return h5_prepare_ack(h5);
+
 	return NULL;
 }
 
 static int h5_flush(struct hci_uart *hu)
 {
-	return -ENOSYS;
+	BT_DBG("hu %p", hu);
+	return 0;
 }
 
 static struct hci_uart_proto h5p = {
-- 
1.7.10.4

