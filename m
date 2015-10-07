Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Enable support for set_diag driver callback
Date: Wed,  7 Oct 2015 20:08:26 +0200
Message-Id: <1444241306-41525-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The set_diag driver callback allows enabling and disabling the vendor
specific diagnostic information. Since Broadcom chips have support for
a dedicated LM_DIAG channel, hook it up accordingly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_bcm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1425bf50ae99..645e66e9a945 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -249,6 +249,29 @@ static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
 static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
 #endif
 
+static int bcm_set_diag(struct hci_dev *hdev, bool enable)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct bcm_data *bcm = hu->priv;
+	struct sk_buff *skb;
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	skb = bt_skb_alloc(3, GFP_KERNEL);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	*skb_put(skb, 1) = BCM_LM_DIAG_PKT;
+	*skb_put(skb, 1) = 0xf0;
+	*skb_put(skb, 1) = enable;
+
+	skb_queue_tail(&bcm->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	return 0;
+}
+
 static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
@@ -342,6 +365,7 @@ static int bcm_setup(struct hci_uart *hu)
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
+	hu->hdev->set_diag = bcm_set_diag;
 	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
 
 	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
-- 
2.4.3

