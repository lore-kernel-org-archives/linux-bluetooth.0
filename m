Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Switch HCI H5 driver to use hci_reset_dev() function
Date: Sun,  2 Nov 2014 08:15:39 +0100
Message-Id: <1414912539-1010-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of having the driver generate the HCI Hardware Error event
manually, just call hci_reset_dev() to trigger the upper stack reset.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h5.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index bd1fe37a7993..ec0fa7732c0d 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -171,8 +171,6 @@ wakeup:
 static void h5_peer_reset(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
-	struct sk_buff *skb;
-	const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, 0x00 };
 
 	BT_ERR("Peer device has reset");
 
@@ -187,15 +185,8 @@ static void h5_peer_reset(struct hci_uart *hu)
 	h5->tx_seq = 0;
 	h5->tx_ack = 0;
 
-	skb = bt_skb_alloc(3, GFP_ATOMIC);
-	if (!skb)
-		return;
-
-	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
-	memcpy(skb_put(skb, 3), hw_err, 3);
-
-	/* Send Hardware Error to upper stack */
-	hci_recv_frame(hu->hdev, skb);
+	/* Send reset request to upper stack */
+	hci_reset_dev(hu->hdev);
 }
 
 static int h5_open(struct hci_uart *hu)
-- 
1.9.3

