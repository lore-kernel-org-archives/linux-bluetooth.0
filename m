Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v7 2/4] Implements hci_reassembly to reassemble Rx packets
Date: Wed, 14 Jul 2010 13:02:17 +0530
Message-ID: <1279092739-4623-2-git-send-email-suraj@atheros.com>
In-Reply-To: <1279092739-4623-1-git-send-email-suraj@atheros.com>
References: <1279092739-4623-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements feature to reassemble received HCI frames from any input stream

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 include/net/bluetooth/bluetooth.h |    1 +
 net/bluetooth/hci_core.c          |  109 +++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ff77e8f..d6b150c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -138,6 +138,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
+	__u16 expect;
 	__u8 tx_seq;
 	__u8 retries;
 	__u8 sar;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0ded790..477c4a6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1033,6 +1033,115 @@ int hci_recv_frame(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(hci_recv_frame);
 
+static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
+			  int count, __u8 index, gfp_t gfp_mask)
+{
+	int len = 0;
+	int hlen = 0;
+	int remain = count;
+	struct sk_buff *skb;
+	struct bt_skb_cb *scb;
+
+	if ((type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT) ||
+				index >= NUM_REASSEMBLY)
+		return -EILSEQ;
+
+	skb = hdev->reassembly[index];
+
+	if (!skb) {
+		switch (type) {
+		case HCI_ACLDATA_PKT:
+			len = HCI_MAX_FRAME_SIZE;
+			hlen = HCI_ACL_HDR_SIZE;
+			break;
+		case HCI_EVENT_PKT:
+			len = HCI_MAX_EVENT_SIZE;
+			hlen = HCI_EVENT_HDR_SIZE;
+			break;
+		case HCI_SCODATA_PKT:
+			len = HCI_MAX_SCO_SIZE;
+			hlen = HCI_SCO_HDR_SIZE;
+			break;
+		}
+
+		skb = bt_skb_alloc(len, gfp_mask);
+		if (!skb)
+			return -ENOMEM;
+
+		scb = (void *) skb->cb;
+		scb->expect = hlen;
+		scb->pkt_type = type;
+
+		skb->dev = (void *) hdev;
+		hdev->reassembly[index] = skb;
+	}
+
+	while (count) {
+		scb = (void *) skb->cb;
+		len = min(scb->expect, (__u16)count);
+
+		memcpy(skb_put(skb, len), data, len);
+
+		count -= len;
+		data += len;
+		scb->expect -= len;
+		remain = count;
+
+		switch (type) {
+		case HCI_EVENT_PKT:
+			if (skb->len == HCI_EVENT_HDR_SIZE) {
+				struct hci_event_hdr *h = hci_event_hdr(skb);
+				scb->expect = h->plen;
+
+				if (skb_tailroom(skb) < scb->expect) {
+					kfree_skb(skb);
+					hdev->reassembly[index] = NULL;
+					return -ENOMEM;
+				}
+			}
+			break;
+
+		case HCI_ACLDATA_PKT:
+			if (skb->len  == HCI_ACL_HDR_SIZE) {
+				struct hci_acl_hdr *h = hci_acl_hdr(skb);
+				scb->expect = __le16_to_cpu(h->dlen);
+
+				if (skb_tailroom(skb) < scb->expect) {
+					kfree_skb(skb);
+					hdev->reassembly[index] = NULL;
+					return -ENOMEM;
+				}
+			}
+			break;
+
+		case HCI_SCODATA_PKT:
+			if (skb->len == HCI_SCO_HDR_SIZE) {
+				struct hci_sco_hdr *h = hci_sco_hdr(skb);
+				scb->expect = h->dlen;
+
+				if (skb_tailroom(skb) < scb->expect) {
+					kfree_skb(skb);
+					hdev->reassembly[index] = NULL;
+					return -ENOMEM;
+				}
+			}
+			break;
+		}
+
+		if (scb->expect == 0) {
+			/* Complete frame */
+
+			bt_cb(skb)->pkt_type = type;
+			hci_recv_frame(skb);
+
+			hdev->reassembly[index] = NULL;
+			return remain;
+		}
+	}
+
+	return remain;
+}
+
 /* Receive packet type fragment */
 #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 1])
 
-- 
1.7.0.4

