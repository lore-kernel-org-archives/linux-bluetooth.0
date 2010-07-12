Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v5 2/3] Modified hci_recv_fragment() to use hci_reassembly
Date: Mon, 12 Jul 2010 17:42:23 +0530
Message-ID: <1278936744-6003-2-git-send-email-suraj@atheros.com>
In-Reply-To: <1278936744-6003-1-git-send-email-suraj@atheros.com>
References: <1278936744-6003-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

modified packet based reassembly function hci_recv_fragment() to use hci_reassembly()

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 net/bluetooth/hci_core.c |   79 ++++++---------------------------------------
 1 files changed, 11 insertions(+), 68 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e1ede0b..ca6182c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1144,82 +1144,25 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 {
+	int rem = 0;
+
 	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
 		return -EILSEQ;
 
-	while (count) {
+	do {
 		struct sk_buff *skb = __reassembly(hdev, type);
-		struct { int expect; } *scb;
-		int len = 0;
-
-		if (!skb) {
-			/* Start of the frame */
-
-			switch (type) {
-			case HCI_EVENT_PKT:
-				if (count >= HCI_EVENT_HDR_SIZE) {
-					struct hci_event_hdr *h = data;
-					len = HCI_EVENT_HDR_SIZE + h->plen;
-				} else
-					return -EILSEQ;
-				break;
 
-			case HCI_ACLDATA_PKT:
-				if (count >= HCI_ACL_HDR_SIZE) {
-					struct hci_acl_hdr *h = data;
-					len = HCI_ACL_HDR_SIZE + __le16_to_cpu(h->dlen);
-				} else
-					return -EILSEQ;
-				break;
+		rem = hci_reassembly(hdev, type, data, count, &skb, GFP_ATOMIC);
+		if (rem < 0)
+			return rem;
 
-			case HCI_SCODATA_PKT:
-				if (count >= HCI_SCO_HDR_SIZE) {
-					struct hci_sco_hdr *h = data;
-					len = HCI_SCO_HDR_SIZE + h->dlen;
-				} else
-					return -EILSEQ;
-				break;
-			}
+		__reassembly(hdev, type) = skb;
 
-			skb = bt_skb_alloc(len, GFP_ATOMIC);
-			if (!skb) {
-				BT_ERR("%s no memory for packet", hdev->name);
-				return -ENOMEM;
-			}
-
-			skb->dev = (void *) hdev;
-			bt_cb(skb)->pkt_type = type;
-
-			__reassembly(hdev, type) = skb;
-
-			scb = (void *) skb->cb;
-			scb->expect = len;
-		} else {
-			/* Continuation */
-
-			scb = (void *) skb->cb;
-			len = scb->expect;
-		}
+		data += (count - rem);
+		count = rem;
+	} while (count);
 
-		len = min(len, count);
-
-		memcpy(skb_put(skb, len), data, len);
-
-		scb->expect -= len;
-
-		if (scb->expect == 0) {
-			/* Complete frame */
-
-			__reassembly(hdev, type) = NULL;
-
-			bt_cb(skb)->pkt_type = type;
-			hci_recv_frame(skb);
-		}
-
-		count -= len; data += len;
-	}
-
-	return 0;
+	return rem;
 }
 EXPORT_SYMBOL(hci_recv_fragment);
 
-- 
1.7.0.4

