Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v5 1/3] Implements hci_reassembly to reassemble Rx packets
Date: Mon, 12 Jul 2010 17:42:22 +0530
Message-ID: <1278936744-6003-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements feature to reassemble HCI frames received from an input stream.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 net/bluetooth/hci_core.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index aeb2982..e1ede0b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1033,6 +1033,112 @@ int hci_recv_frame(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(hci_recv_frame);
 
+static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
+			  int count, struct sk_buff **skb_ptr, gfp_t how)
+{
+	int len = 0;
+	int header_len = 0;
+	int remain = count;
+	struct sk_buff *skb = *skb_ptr;
+	struct { struct bt_skb_cb cb_info; int expect; } *scb;
+
+	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
+		return -EILSEQ;
+
+	if (!skb) {
+		switch (type) {
+		case HCI_ACLDATA_PKT:
+			len = HCI_MAX_FRAME_SIZE;
+			header_len = HCI_ACL_HDR_SIZE;
+			break;
+		case HCI_EVENT_PKT:
+			len = HCI_MAX_EVENT_SIZE;
+			header_len = HCI_EVENT_HDR_SIZE;
+			break;
+		case HCI_SCODATA_PKT:
+			len = HCI_MAX_SCO_SIZE;
+			header_len = HCI_SCO_HDR_SIZE;
+			break;
+		}
+
+		skb = bt_skb_alloc(len, how);
+		if (!skb)
+			return -ENOMEM;
+
+		scb = (void *) skb->cb;
+		scb->expect = header_len;
+		scb->cb_info.pkt_type = type;
+
+		skb->dev = (void *) hdev;
+		*skb_ptr = skb;
+	}
+
+	while (count) {
+		scb = (void *) skb->cb;
+		len = min(scb->expect, count);
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
+					*skb_ptr = NULL;
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
+					*skb_ptr = NULL;
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
+					*skb_ptr = NULL;
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
+			*skb_ptr = NULL;
+			return remain;
+		}
+	}
+
+	return remain;
+}
+
 /* Receive packet type fragment */
 #define __reassembly(hdev, type)  ((hdev)->reassembly[(type) - 2])
 
-- 
1.7.0.4

