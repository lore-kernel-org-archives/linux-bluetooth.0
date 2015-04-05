Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: hci_uart: Introduce h4_recv_buf helper function
Date: Sat,  4 Apr 2015 21:59:24 -0700
Message-Id: <1428209967-20757-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The h4_recv_buf helper function can be used for receiving H:4 packets
out of a TTY stream. It is self-contained and allows for reuse by all
HCI UART protocols.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h4.c   | 98 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h |  3 ++
 2 files changed, 101 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 97a5df4941b4..09270bc26654 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -161,3 +161,101 @@ int __exit h4_deinit(void)
 {
 	return hci_uart_unregister_proto(&h4p);
 }
+
+struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+			    const unsigned char *buffer, int count)
+{
+	while (count) {
+		int len;
+
+		if (!skb) {
+			switch (buffer[0]) {
+			case HCI_ACLDATA_PKT:
+				skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
+				bt_cb(skb)->expect = HCI_ACL_HDR_SIZE;
+				break;
+			case HCI_SCODATA_PKT:
+				skb = bt_skb_alloc(HCI_MAX_SCO_SIZE,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
+				bt_cb(skb)->expect = HCI_SCO_HDR_SIZE;
+				break;
+			case HCI_EVENT_PKT:
+				skb = bt_skb_alloc(HCI_MAX_EVENT_SIZE,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
+				bt_cb(skb)->expect = HCI_EVENT_HDR_SIZE;
+				break;
+			default:
+				return ERR_PTR(-EILSEQ);
+			}
+
+			count -= 1;
+			buffer += 1;
+		}
+
+		len = min_t(uint, bt_cb(skb)->expect, count);
+		memcpy(skb_put(skb, len), buffer, len);
+
+		count -= len;
+		buffer += len;
+		bt_cb(skb)->expect -= len;
+
+		switch (bt_cb(skb)->pkt_type) {
+		case HCI_ACLDATA_PKT:
+			if (skb->len == HCI_ACL_HDR_SIZE) {
+				__le16 dlen = hci_acl_hdr(skb)->dlen;
+
+				/* Complete ACL header */
+				bt_cb(skb)->expect = __le16_to_cpu(dlen);
+
+				if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+			}
+			break;
+		case HCI_SCODATA_PKT:
+			if (skb->len == HCI_SCO_HDR_SIZE) {
+				/* Complete SCO header */
+				bt_cb(skb)->expect = hci_sco_hdr(skb)->dlen;
+
+				if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+			}
+			break;
+		case HCI_EVENT_PKT:
+			if (skb->len == HCI_EVENT_HDR_SIZE) {
+				/* Complete event header */
+				bt_cb(skb)->expect = hci_event_hdr(skb)->plen;
+
+				if (skb_tailroom(skb) < bt_cb(skb)->expect) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+			}
+			break;
+		}
+
+		if (bt_cb(skb)->expect == 0) {
+			/* Complete frame */
+			hci_recv_frame(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 79bbcefb0112..53b329229f2e 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -99,6 +99,9 @@ int hci_uart_init_ready(struct hci_uart *hu);
 #ifdef CONFIG_BT_HCIUART_H4
 int h4_init(void);
 int h4_deinit(void);
+
+struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+			    const unsigned char *buffer, int count);
 #endif
 
 #ifdef CONFIG_BT_HCIUART_BCSP
-- 
2.1.0

