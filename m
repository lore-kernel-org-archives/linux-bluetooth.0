Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Remove quirk for HCI_VENDOR_PKT filter handling
Date: Fri,  9 Oct 2015 14:09:21 +0200
Message-Id: <1444392563-12977-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI_VENDOR_PKT quirk was needed for BPA-100/105 devices that send
these messages. Now that there is support for proper diagnostic channel
this quirk is no longer needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9a100c1fd7b5..bad86dfe134f 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -120,10 +120,7 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	/* Apply filter */
 	flt = &hci_pi(sk)->filter;
 
-	if (bt_cb(skb)->pkt_type == HCI_VENDOR_PKT)
-		flt_type = 0;
-	else
-		flt_type = bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS;
+	flt_type = bt_cb(skb)->pkt_type & HCI_FLT_TYPE_BITS;
 
 	if (!test_bit(flt_type, &flt->type_mask))
 		return true;
-- 
2.4.3

