Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add hci_skb_* helper wrappers for bt_cb(skb) access
Date: Thu,  5 Nov 2015 07:09:59 +0100
Message-Id: <1446703801-30566-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For all the HCI driver related variables accesssed via bt_cb(skb),
provide helper wrappers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fde1791c24b0..b98cd7aea2fa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -317,6 +317,10 @@ struct bt_skb_cb {
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
+#define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
+#define hci_skb_expect(skb) bt_cb((skb))->expect
+#define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
+
 static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 {
 	struct sk_buff *skb;
-- 
2.5.0

