Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use HCI_EV_HARDWARE_ERROR define for event payload
Date: Sun,  2 Nov 2014 03:02:01 +0100
Message-Id: <1414893721-91141-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When constructing the event payload for the HCI_Hardware_Error event
message, use the HCI_EV_HARDWARE_ERROR define.

In addition rename the variables from hard_err to hw_err to clearly
indicate that this is about the hardware error and not a hard error.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 20bdd71559b1..bd1fe37a7993 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -172,7 +172,7 @@ static void h5_peer_reset(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
 	struct sk_buff *skb;
-	const unsigned char hard_err[] = { 0x10, 0x01, 0x00 };
+	const u8 hw_err[] = { HCI_EV_HARDWARE_ERROR, 0x01, 0x00 };
 
 	BT_ERR("Peer device has reset");
 
@@ -192,7 +192,7 @@ static void h5_peer_reset(struct hci_uart *hu)
 		return;
 
 	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
-	memcpy(skb_put(skb, 3), hard_err, 3);
+	memcpy(skb_put(skb, 3), hw_err, 3);
 
 	/* Send Hardware Error to upper stack */
 	hci_recv_frame(hu->hdev, skb);
-- 
1.9.3

