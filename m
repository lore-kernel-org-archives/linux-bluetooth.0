Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: HCI H5 peer reset detection
Date: Wed,  8 Oct 2014 16:54:28 +0200
Message-Id: <1412780068-19449-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

H5 Specification says:
If a SYNC message is received while in the Active State, it is
assumed that the peer device has reset. The local device should
therefore perform a full reset of the upper stack, and start Link
Establishment again at the Uninitialized State. Upon entering the
Active State, the first packet sent shall have its SEQ and ACK
numbers set to zero.

This patch resets the HCI H5 driver data/state to unitialized and
reports an HCI hardware error event to notify the upper stack that
HCI synchronization has been lost. H5 will be re-synchronized and
upper stack should generate an HCI Reset command.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_h5.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index caacb42..5c5e9ac 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -168,6 +168,36 @@ wakeup:
 	hci_uart_tx_wakeup(hu);
 }
 
+static void h5_peer_reset(struct hci_uart *hu)
+{
+	struct h5 *h5 = hu->priv;
+	struct sk_buff *skb;
+	const unsigned char hard_err[] = { 0x10, 0x01, 0x00 };
+
+	BT_ERR("Peer device has reset");
+
+	h5->state = H5_UNINITIALIZED;
+
+	del_timer(&h5->timer);
+
+	skb_queue_purge(&h5->rel);
+	skb_queue_purge(&h5->unrel);
+	skb_queue_purge(&h5->unack);
+
+	h5->tx_seq = 0;
+	h5->tx_ack = 0;
+
+	skb = bt_skb_alloc(3, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+	memcpy(skb_put(skb, 3), hard_err, 3);
+
+	/* Send Hardware Error to upper stack */
+	hci_recv_frame(hu->hdev, skb);
+}
+
 static int h5_open(struct hci_uart *hu)
 {
 	struct h5 *h5;
@@ -283,8 +313,12 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 	conf_req[2] = h5_cfg_field(h5);
 
 	if (memcmp(data, sync_req, 2) == 0) {
+		if (h5->state == H5_ACTIVE)
+			h5_peer_reset(hu);
 		h5_link_control(hu, sync_rsp, 2);
 	} else if (memcmp(data, sync_rsp, 2) == 0) {
+		if (h5->state == H5_ACTIVE)
+			h5_peer_reset(hu);
 		h5->state = H5_INITIALIZED;
 		h5_link_control(hu, conf_req, 3);
 	} else if (memcmp(data, conf_req, 2) == 0) {
-- 
1.8.3.2

