Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Queue diagnostic messages together with HCI packets
Date: Fri,  9 Oct 2015 14:09:23 +0200
Message-Id: <1444392563-12977-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sending diagnostic messages directly to the monitor socket might cause
issues for devices processing their messages in interrupt context. So
instead of trying to directly forward them, queue them up with the other
HCI packets and lets them be processed by the sockets at the same time.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d2b3dd32d6cf..fd91649ae7ee 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3562,14 +3562,15 @@ EXPORT_SYMBOL(hci_recv_frame);
 /* Receive diagnostic message from HCI drivers */
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	/* Mark as diagnostic packet */
+	bt_cb(skb)->pkt_type = HCI_DIAG_PKT;
+
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	/* Mark as diagnostic packet and send to monitor */
-	bt_cb(skb)->pkt_type = HCI_DIAG_PKT;
-	hci_send_to_monitor(hdev, skb);
+	skb_queue_tail(&hdev->rx_q, skb);
+	queue_work(hdev->workqueue, &hdev->rx_work);
 
-	kfree_skb(skb);
 	return 0;
 }
 EXPORT_SYMBOL(hci_recv_diag);
-- 
2.4.3

