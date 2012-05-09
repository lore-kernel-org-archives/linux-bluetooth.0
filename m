Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATC -v2 1/2] Bluetooth: Fix packet size informed to the controller
Date: Wed,  9 May 2012 18:27:15 -0300
Message-Id: <1336598836-28478-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When building fragmented skb's skb->len keeps track of the size of head
plus all fragments combined, however when queueing the skb for sending we
need to report the head size instead of the total size, so we just set
skb->len to skb_headlen().

This bug appeared when implementing MSG_MORE support for L2CAP sockets, it
never showed up before because l2cap_skbuff_fromiovec() never accounted skb
size correctly. A following patch will fix this.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/hci_core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a492b374..a7208e8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2162,6 +2162,12 @@ static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
 
+	skb->len = skb_headlen(skb);
+	skb->data_len = 0;
+
+	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
+	hci_add_acl_hdr(skb, conn->handle, flags);
+
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
 		/* Non fragmented */
@@ -2205,8 +2211,6 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 	BT_DBG("%s chan %p flags 0x%x", hdev->name, chan, flags);
 
 	skb->dev = (void *) hdev;
-	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-	hci_add_acl_hdr(skb, conn->handle, flags);
 
 	hci_queue_acl(conn, &chan->data_q, skb, flags);
 
-- 
1.7.10.1

