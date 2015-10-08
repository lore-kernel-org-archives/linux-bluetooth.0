Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enforce packet types in hci_recv_frame driver function
Date: Thu,  8 Oct 2015 03:14:28 +0200
Message-Id: <1444266868-78229-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When calling the hci_recv_frame driver function check for valid packet
types that the core should process. This should catch issues with
drivers trying to feed vendor packet types through this interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 43a1f2d8ffd3..b2095ca8472e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3538,6 +3538,13 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -ENXIO;
 	}
 
+	if (bt_cb(skb)->pkt_type != HCI_EVENT_PKT &&
+	    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
+	    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	/* Incoming skb */
 	bt_cb(skb)->incoming = 1;
 
-- 
2.4.3

