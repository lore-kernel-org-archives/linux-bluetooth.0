Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] Bluetooth: hci_uart: Add protocol support for Broadcom UART devices
Date: Sun,  5 Apr 2015 22:52:18 -0700
Message-Id: <1428299539-8273-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the protocol support for Broadcom based UART devices to
enable firmware and patchram download procedure. It is a pretty
straight forward H:4 driver with the exception of actually having
its own setup and address configuration callbacks.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |   1 +
 drivers/bluetooth/hci_bcm.c   | 115 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |   6 +++
 drivers/bluetooth/hci_uart.h  |   5 ++
 4 files changed, 127 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index ea76031eb93f..93351b91bbb4 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -122,6 +122,7 @@ config BT_HCIUART_INTEL
 config BT_HCIUART_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIUART
+	select BT_HCIUART_H4
 	select BT_BCM
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index dd338fa77433..fe1905c4beb2 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -28,4 +28,119 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btbcm.h"
 #include "hci_uart.h"
+
+struct bcm_data {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+};
+
+static int bcm_open(struct hci_uart *hu)
+{
+	struct bcm_data *bcm;
+
+	BT_DBG("hu %p", hu);
+
+	bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
+	if (!bcm)
+		return -ENOMEM;
+
+	skb_queue_head_init(&bcm->txq);
+
+	hu->priv = bcm;
+	return 0;
+}
+
+static int bcm_close(struct hci_uart *hu)
+{
+	struct bcm_data *bcm = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&bcm->txq);
+	kfree_skb(bcm->rx_skb);
+	kfree(bcm);
+
+	hu->priv = NULL;
+	return 0;
+}
+
+static int bcm_flush(struct hci_uart *hu)
+{
+	struct bcm_data *bcm = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&bcm->txq);
+
+	return 0;
+}
+
+static int bcm_setup(struct hci_uart *hu)
+{
+	BT_DBG("hu %p", hu);
+
+	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
+
+	return btbcm_setup_patchram(hu->hdev);
+}
+
+static int bcm_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct bcm_data *bcm = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count);
+	if (IS_ERR(bcm->rx_skb)) {
+		int err = PTR_ERR(bcm->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		return err;
+	}
+
+	return count;
+}
+
+static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct bcm_data *bcm = hu->priv;
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	skb_queue_tail(&bcm->txq, skb);
+
+	return 0;
+}
+
+static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
+{
+	struct bcm_data *bcm = hu->priv;
+
+	return skb_dequeue(&bcm->txq);
+}
+
+static const struct hci_uart_proto bcm_proto = {
+	.id		= HCI_UART_BCM,
+	.name		= "BCM",
+	.open		= bcm_open,
+	.close		= bcm_close,
+	.flush		= bcm_flush,
+	.setup		= bcm_setup,
+	.recv		= bcm_recv,
+	.enqueue	= bcm_enqueue,
+	.dequeue	= bcm_dequeue,
+};
+
+int __init bcm_init(void)
+{
+	return hci_uart_register_proto(&bcm_proto);
+}
+
+int __exit bcm_deinit(void)
+{
+	return hci_uart_unregister_proto(&bcm_proto);
+}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b182ddc43dfe..a106c3e201e3 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -679,6 +679,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_3WIRE
 	h5_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_BCM
+	bcm_init();
+#endif
 
 	return 0;
 }
@@ -702,6 +705,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_3WIRE
 	h5_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_BCM
+	bcm_deinit();
+#endif
 
 	/* Release tty registration of line discipline */
 	err = tty_unregister_ldisc(N_HCI);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 466798acf049..a3108abce5d3 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -128,3 +128,8 @@ int h5_deinit(void);
 #ifdef CONFIG_BT_HCIUART_INTEL
 int intel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_BCM
+int bcm_init(void);
+int bcm_deinit(void);
+#endif
-- 
2.1.0

