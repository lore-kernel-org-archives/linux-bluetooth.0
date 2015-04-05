Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Remove hci_recv_stream_fragment function
Date: Sat,  4 Apr 2015 21:59:27 -0700
Message-Id: <1428209967-20757-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_recv_stream_fragment function should have never been introduced
in the first place. The Bluetooth core does not need to know anything
about the HCI transport protocol.

With all transport protocol specific detailed moved back into the
drivers where they belong (mainly generic USB and UART drivers), this
function can now be removed.

This reduces the size of hci_dev structure and also removes an exported
symbol from the Bluetooth core module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |   3 -
 net/bluetooth/hci_core.c         | 148 +--------------------------------------
 2 files changed, 1 insertion(+), 150 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ad957f336ead..a056c2bfeb81 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -185,7 +185,6 @@ struct amp_assoc {
 
 #define HCI_MAX_PAGES	3
 
-#define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
@@ -327,7 +326,6 @@ struct hci_dev {
 	struct sk_buff_head	cmd_q;
 
 	struct sk_buff		*sent_cmd;
-	struct sk_buff		*reassembly[NUM_REASSEMBLY];
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
@@ -1012,7 +1010,6 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
-int hci_recv_stream_fragment(struct hci_dev *hdev, const void *data, int count);
 
 void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c9e7cafb245a..476709bd068a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3200,7 +3200,7 @@ EXPORT_SYMBOL(hci_register_dev);
 /* Unregister HCI device */
 void hci_unregister_dev(struct hci_dev *hdev)
 {
-	int i, id;
+	int id;
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
@@ -3214,9 +3214,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_dev_do_close(hdev);
 
-	for (i = 0; i < NUM_REASSEMBLY; i++)
-		kfree_skb(hdev->reassembly[i]);
-
 	cancel_work_sync(&hdev->power_on);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
@@ -3320,149 +3317,6 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(hci_recv_frame);
 
-static int hci_reassembly(struct hci_dev *hdev, int type, const void *data,
-			  int count, __u8 index)
-{
-	int len = 0;
-	int hlen = 0;
-	int remain = count;
-	struct sk_buff *skb;
-	struct bt_skb_cb *scb;
-
-	if ((type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT) ||
-	    index >= NUM_REASSEMBLY)
-		return -EILSEQ;
-
-	skb = hdev->reassembly[index];
-
-	if (!skb) {
-		switch (type) {
-		case HCI_ACLDATA_PKT:
-			len = HCI_MAX_FRAME_SIZE;
-			hlen = HCI_ACL_HDR_SIZE;
-			break;
-		case HCI_EVENT_PKT:
-			len = HCI_MAX_EVENT_SIZE;
-			hlen = HCI_EVENT_HDR_SIZE;
-			break;
-		case HCI_SCODATA_PKT:
-			len = HCI_MAX_SCO_SIZE;
-			hlen = HCI_SCO_HDR_SIZE;
-			break;
-		}
-
-		skb = bt_skb_alloc(len, GFP_ATOMIC);
-		if (!skb)
-			return -ENOMEM;
-
-		scb = (void *) skb->cb;
-		scb->expect = hlen;
-		scb->pkt_type = type;
-
-		hdev->reassembly[index] = skb;
-	}
-
-	while (count) {
-		scb = (void *) skb->cb;
-		len = min_t(uint, scb->expect, count);
-
-		memcpy(skb_put(skb, len), data, len);
-
-		count -= len;
-		data += len;
-		scb->expect -= len;
-		remain = count;
-
-		switch (type) {
-		case HCI_EVENT_PKT:
-			if (skb->len == HCI_EVENT_HDR_SIZE) {
-				struct hci_event_hdr *h = hci_event_hdr(skb);
-				scb->expect = h->plen;
-
-				if (skb_tailroom(skb) < scb->expect) {
-					kfree_skb(skb);
-					hdev->reassembly[index] = NULL;
-					return -ENOMEM;
-				}
-			}
-			break;
-
-		case HCI_ACLDATA_PKT:
-			if (skb->len  == HCI_ACL_HDR_SIZE) {
-				struct hci_acl_hdr *h = hci_acl_hdr(skb);
-				scb->expect = __le16_to_cpu(h->dlen);
-
-				if (skb_tailroom(skb) < scb->expect) {
-					kfree_skb(skb);
-					hdev->reassembly[index] = NULL;
-					return -ENOMEM;
-				}
-			}
-			break;
-
-		case HCI_SCODATA_PKT:
-			if (skb->len == HCI_SCO_HDR_SIZE) {
-				struct hci_sco_hdr *h = hci_sco_hdr(skb);
-				scb->expect = h->dlen;
-
-				if (skb_tailroom(skb) < scb->expect) {
-					kfree_skb(skb);
-					hdev->reassembly[index] = NULL;
-					return -ENOMEM;
-				}
-			}
-			break;
-		}
-
-		if (scb->expect == 0) {
-			/* Complete frame */
-
-			bt_cb(skb)->pkt_type = type;
-			hci_recv_frame(hdev, skb);
-
-			hdev->reassembly[index] = NULL;
-			return remain;
-		}
-	}
-
-	return remain;
-}
-
-#define STREAM_REASSEMBLY 0
-
-int hci_recv_stream_fragment(struct hci_dev *hdev, const void *data, int count)
-{
-	int type;
-	int rem = 0;
-
-	while (count) {
-		struct sk_buff *skb = hdev->reassembly[STREAM_REASSEMBLY];
-
-		if (!skb) {
-			const struct { char type; } *pkt;
-
-			/* Start of the frame */
-			pkt = data;
-			type = pkt->type;
-
-			data++;
-			count--;
-		} else
-			type = bt_cb(skb)->pkt_type;
-
-		rem = hci_reassembly(hdev, type, data, count,
-				     STREAM_REASSEMBLY);
-		if (rem < 0)
-			return rem;
-
-		data += (count - rem);
-		count = rem;
-	}
-
-	return rem;
-}
-EXPORT_SYMBOL(hci_recv_stream_fragment);
-
 /* ---- Interface to upper protocols ---- */
 
 int hci_register_cb(struct hci_cb *cb)
-- 
2.1.0

