Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: hci_uart: Use h4_recv_buf helper for Atheros AR300x
Date: Sat,  4 Apr 2015 21:59:26 -0700
Message-Id: <1428209967-20757-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of using hci_recv_stream_fragment, use the local available
h4_recv_buf helper function.

To ensure that the function is available select BT_HCIUART_H4.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig   |  1 +
 drivers/bluetooth/hci_ath.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index e8630b605aa9..f8a41975c30d 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -62,6 +62,7 @@ config BT_HCIUART_BCSP
 config BT_HCIUART_ATH3K
 	bool "Atheros AR300x serial support"
 	depends on BT_HCIUART
+	select BT_HCIUART_H4
 	help
 	  HCIATH3K (HCI Atheros AR300x) is a serial protocol for
 	  communication between host and Atheros AR300x Bluetooth devices.
diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 4e89d3e33b7b..15beb974f3a0 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -45,6 +45,7 @@ struct ath_struct {
 	struct hci_uart *hu;
 	unsigned int cur_sleep;
 
+	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 	struct work_struct ctxtsw;
 };
@@ -136,6 +137,8 @@ static int ath_close(struct hci_uart *hu)
 
 	skb_queue_purge(&ath->txq);
 
+	kfree_skb(ath->rx_skb);
+
 	cancel_work_sync(&ath->ctxtsw);
 
 	hu->priv = NULL;
@@ -190,12 +193,13 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu)
 /* Recv data */
 static int ath_recv(struct hci_uart *hu, const void *data, int count)
 {
-	int ret;
+	struct ath_struct *ath = hu->priv;
 
-	ret = hci_recv_stream_fragment(hu->hdev, data, count);
-	if (ret < 0) {
-		BT_ERR("Frame Reassembly Failed");
-		return ret;
+	ath->rx_skb = h4_recv_buf(hu->hdev, ath->rx_skb, data, count);
+	if (IS_ERR(ath->rx_skb)) {
+		int err = PTR_ERR(ath->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		return err;
 	}
 
 	return count;
-- 
2.1.0

