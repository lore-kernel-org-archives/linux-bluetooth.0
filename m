Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Add protocol support for Intel UART devices
Date: Sun,  5 Apr 2015 04:16:32 -0700
Message-Id: <1428232592-17038-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the basic skeleton for protocol support for Intel based
UART devices. It is a simple H:4 driver with a vendor specific
callback for address configuration.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig     |   1 +
 drivers/bluetooth/hci_intel.c | 115 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_ldisc.c |   6 +++
 drivers/bluetooth/hci_uart.h  |   5 ++
 4 files changed, 127 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index ed5c2738bea2..6141e40ee1cd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -117,6 +117,7 @@ config BT_HCIUART_3WIRE
 config BT_HCIUART_INTEL
 	bool "Intel protocol support"
 	depends on BT_HCIUART
+	select BT_HCIUART_H4
 	select BT_INTEL
 	help
 	  The Intel protocol support enables Bluetooth HCI over serial
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 5dd07bf05236..a4ca6e8ef825 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -28,4 +28,119 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btintel.h"
 #include "hci_uart.h"
+
+struct intel_data {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+};
+
+static int intel_open(struct hci_uart *hu)
+{
+	struct intel_data *intel;
+
+	BT_DBG("hu %p", hu);
+
+	intel = kzalloc(sizeof(*intel), GFP_KERNEL);
+	if (!intel)
+		return -ENOMEM;
+
+	skb_queue_head_init(&intel->txq);
+
+	hu->priv = intel;
+	return 0;
+}
+
+static int intel_close(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&intel->txq);
+	kfree_skb(intel->rx_skb);
+	kfree(intel);
+
+	hu->priv = NULL;
+	return 0;
+}
+
+static int intel_flush(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&intel->txq);
+
+	return 0;
+}
+
+static int intel_setup(struct hci_uart *hu)
+{
+	BT_DBG("hu %p", hu);
+
+	hu->hdev->set_bdaddr = btintel_set_bdaddr;
+
+	return 0;
+}
+
+static int intel_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct intel_data *intel = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	intel->rx_skb = h4_recv_buf(hu->hdev, intel->rx_skb, data, count);
+	if (IS_ERR(intel->rx_skb)) {
+		int err = PTR_ERR(intel->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		return err;
+	}
+
+	return count;
+}
+
+static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct intel_data *intel = hu->priv;
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	skb_queue_tail(&intel->txq, skb);
+
+	return 0;
+}
+
+static struct sk_buff *intel_dequeue(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+
+	return skb_dequeue(&intel->txq);
+}
+
+static const struct hci_uart_proto intel_proto = {
+	.id		= HCI_UART_INTEL,
+	.name		= "Intel",
+	.open		= intel_open,
+	.close		= intel_close,
+	.flush		= intel_flush,
+	.setup		= intel_setup,
+	.recv		= intel_recv,
+	.enqueue	= intel_enqueue,
+	.dequeue	= intel_dequeue,
+};
+
+int __init intel_init(void)
+{
+	return hci_uart_register_proto(&intel_proto);
+}
+
+int __exit intel_deinit(void)
+{
+	return hci_uart_unregister_proto(&intel_proto);
+}
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5c9a73f02664..d0ce210cc6dd 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -681,6 +681,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_3WIRE
 	h5_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_INTEL
+	intel_init();
+#endif
 #ifdef CONFIG_BT_HCIUART_BCM
 	bcm_init();
 #endif
@@ -707,6 +710,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_3WIRE
 	h5_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_INTEL
+	intel_deinit();
+#endif
 #ifdef CONFIG_BT_HCIUART_BCM
 	bcm_deinit();
 #endif
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 94f3c42b327f..9d7de55af104 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -125,6 +125,11 @@ int h5_init(void);
 int h5_deinit(void);
 #endif
 
+#ifdef CONFIG_BT_HCIUART_INTEL
+int intel_init(void);
+int intel_deinit(void);
+#endif
+
 #ifdef CONFIG_BT_HCIUART_BCM
 int bcm_init(void);
 int bcm_deinit(void);
-- 
2.1.0

