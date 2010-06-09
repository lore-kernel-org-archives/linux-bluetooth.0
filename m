Return-Path: <cyrus@holtmann.org>
Subject: [PATCH v3 2/3] Modified hci_recv_fragment() to use hci_reassembly
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <1276088748.31226.6.camel@atheros013-desktop>
References: <1276088748.31226.6.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 9 Jun 2010 18:39:28 +0530
Message-ID: <1276088968.31226.10.camel@atheros013-desktop>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

modified packet based reassembly code to use hci_reassembly()

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 net/bluetooth/hci_core.c |   78 +++++++--------------------------------------
 1 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 631a185..48ef56e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1150,82 +1150,28 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 {
+	int remaining = 0;
+	int err = 0;
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
+		err = hci_reassembly(hdev, type, data, count, &skb, &remaining);
 
-			case HCI_SCODATA_PKT:
-				if (count >= HCI_SCO_HDR_SIZE) {
-					struct hci_sco_hdr *h = data;
-					len = HCI_SCO_HDR_SIZE + h->dlen;
-				} else
-					return -EILSEQ;
-				break;
-			}
+		if (err < 0)
+			return err;
 
-			skb = bt_skb_alloc(len, GFP_ATOMIC);
-			if (!skb) {
-				BT_ERR("%s no memory for packet", hdev->name);
-				return -ENOMEM;
-			}
-
-			skb->dev = (void *) hdev;
-			bt_cb(skb)->pkt_type = type;
+		__reassembly(hdev, type) = skb;
 
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
+		data += (count - remaining);
+		count = remaining;
 
-		len = min(len, count);
+	} while (count);
 
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
+	return err;
 }
 EXPORT_SYMBOL(hci_recv_fragment);
 
-- 
1.7.0
