Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_uart: Reorder Atheros specific driver callbacks
Date: Sat, 11 Apr 2015 05:35:37 -0700
Message-Id: <1428755738-22030-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The driver callbacks in the Atheros support were all in a random order
and did not help readability of this driver. So reorder them to make
them aligned with what other Bluetooth UART drivers do. This patch is
not changing any actual code.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c | 66 +++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 1b3f8647ea2f..42f13d0b437f 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -95,7 +95,6 @@ static void ath_hci_uart_work(struct work_struct *work)
 	hci_uart_tx_wakeup(hu);
 }
 
-/* Initialize protocol */
 static int ath_open(struct hci_uart *hu)
 {
 	struct ath_struct *ath;
@@ -116,8 +115,7 @@ static int ath_open(struct hci_uart *hu)
 	return 0;
 }
 
-/* Flush protocol data */
-static int ath_flush(struct hci_uart *hu)
+static int ath_close(struct hci_uart *hu)
 {
 	struct ath_struct *ath = hu->priv;
 
@@ -125,11 +123,17 @@ static int ath_flush(struct hci_uart *hu)
 
 	skb_queue_purge(&ath->txq);
 
+	kfree_skb(ath->rx_skb);
+
+	cancel_work_sync(&ath->ctxtsw);
+
+	hu->priv = NULL;
+	kfree(ath);
+
 	return 0;
 }
 
-/* Close protocol */
-static int ath_close(struct hci_uart *hu)
+static int ath_flush(struct hci_uart *hu)
 {
 	struct ath_struct *ath = hu->priv;
 
@@ -137,19 +141,32 @@ static int ath_close(struct hci_uart *hu)
 
 	skb_queue_purge(&ath->txq);
 
-	kfree_skb(ath->rx_skb);
+	return 0;
+}
 
-	cancel_work_sync(&ath->ctxtsw);
+static const struct h4_recv_pkt ath_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+};
 
-	hu->priv = NULL;
-	kfree(ath);
+static int ath_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct ath_struct *ath = hu->priv;
 
-	return 0;
+	ath->rx_skb = h4_recv_buf(hu->hdev, ath->rx_skb, data, count,
+				  ath_recv_pkts, ARRAY_SIZE(ath_recv_pkts));
+	if (IS_ERR(ath->rx_skb)) {
+		int err = PTR_ERR(ath->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		return err;
+	}
+
+	return count;
 }
 
 #define HCI_OP_ATH_SLEEP 0xFC04
 
-/* Enqueue frame for transmittion */
 static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
 	struct ath_struct *ath = hu->priv;
@@ -159,8 +176,7 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		return 0;
 	}
 
-	/*
-	 * Update power management enable flag with parameters of
+	/* Update power management enable flag with parameters of
 	 * HCI sleep enable vendor specific HCI command.
 	 */
 	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
@@ -190,37 +206,15 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&ath->txq);
 }
 
-static const struct h4_recv_pkt ath_recv_pkts[] = {
-	{ H4_RECV_ACL,   .recv = hci_recv_frame },
-	{ H4_RECV_SCO,   .recv = hci_recv_frame },
-	{ H4_RECV_EVENT, .recv = hci_recv_frame },
-};
-
-/* Recv data */
-static int ath_recv(struct hci_uart *hu, const void *data, int count)
-{
-	struct ath_struct *ath = hu->priv;
-
-	ath->rx_skb = h4_recv_buf(hu->hdev, ath->rx_skb, data, count,
-				  ath_recv_pkts, ARRAY_SIZE(ath_recv_pkts));
-	if (IS_ERR(ath->rx_skb)) {
-		int err = PTR_ERR(ath->rx_skb);
-		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
-		return err;
-	}
-
-	return count;
-}
-
 static const struct hci_uart_proto athp = {
 	.id		= HCI_UART_ATH3K,
 	.name		= "ATH3K",
 	.open		= ath_open,
 	.close		= ath_close,
+	.flush		= ath_flush,
 	.recv		= ath_recv,
 	.enqueue	= ath_enqueue,
 	.dequeue	= ath_dequeue,
-	.flush		= ath_flush,
 };
 
 int __init ath_init(void)
-- 
2.1.0

