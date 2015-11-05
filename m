Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Make bt_cb()->pkt_type and bt_cb()->except HCI specific
Date: Thu,  5 Nov 2015 10:38:00 +0100
Message-Id: <1446716280-49570-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The two fields for pkt_type and expect inside the bt_cb() structure are
highly HCI specific and only used by HCI drivers. So instead of keeping
them global, move them into the union entry for HCI.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 8d38f411009c..8afa7534248e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -300,6 +300,8 @@ typedef void (*hci_req_complete_skb_t)(struct hci_dev *hdev, u8 status,
 #define HCI_REQ_SKB	BIT(1)
 
 struct hci_ctrl {
+	__u8 pkt_type;
+	__u16 expect;
 	__u16 opcode;
 	u8 req_flags;
 	u8 req_event;
@@ -310,9 +312,7 @@ struct hci_ctrl {
 };
 
 struct bt_skb_cb {
-	__u8 pkt_type;
 	__u8 force_active;
-	__u16 expect;
 	__u8 incoming:1;
 	union {
 		struct l2cap_ctrl l2cap;
@@ -321,8 +321,8 @@ struct bt_skb_cb {
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
-#define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
-#define hci_skb_expect(skb) bt_cb((skb))->expect
+#define hci_skb_pkt_type(skb) bt_cb((skb))->hci.pkt_type
+#define hci_skb_expect(skb) bt_cb((skb))->hci.expect
 #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
 
 static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
-- 
2.5.0

