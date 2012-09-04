Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 13/15] Bluetooth: AMP: Use Loglink handle in ACL Handle field
Date: Tue,  4 Sep 2012 16:44:32 +0300
Message-Id: <1346766274-21612-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For AMP HCI controller use Logical Link handle in HCI ACL
Handle field.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7a0c20c..9c50cdc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2162,7 +2162,20 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 	skb->data_len = 0;
 
 	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-	hci_add_acl_hdr(skb, conn->handle, flags);
+
+	switch (hdev->dev_type) {
+	case HCI_BREDR:
+		hci_add_acl_hdr(skb, conn->handle, flags);
+		break;
+
+	case HCI_AMP:
+		hci_add_acl_hdr(skb, chan->handle, flags);
+		break;
+
+	default:
+		BT_ERR("%s unknown dev_type %d", hdev->name, hdev->dev_type);
+		return;
+	}
 
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
-- 
1.7.9.5

