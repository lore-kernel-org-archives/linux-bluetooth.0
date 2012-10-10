Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 4/6] Bluetooth: AMP: Handle number of compl blocks for AMP_LINK
Date: Wed, 10 Oct 2012 17:38:29 +0300
Message-Id: <1349879912-23633-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add handling blocks count for AMP link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 82e478a..5c0b6c1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2677,6 +2677,27 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
+static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
+						 __u16 handle)
+{
+	struct hci_chan *chan;
+
+	switch (hdev->dev_type) {
+	case HCI_BREDR:
+		return hci_conn_hash_lookup_handle(hdev, handle);
+	case HCI_AMP:
+		chan = hci_chan_lookup_handle(hdev, handle);
+		if (chan)
+			return chan->conn;
+		break;
+	default:
+		BT_ERR("%s unknown dev_type %d", hdev->name, hdev->dev_type);
+		break;
+	}
+
+	return NULL;
+}
+
 static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
@@ -2698,13 +2719,13 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	for (i = 0; i < ev->num_hndl; i++) {
 		struct hci_comp_blocks_info *info = &ev->handles[i];
-		struct hci_conn *conn;
+		struct hci_conn *conn = NULL;
 		__u16  handle, block_count;
 
 		handle = __le16_to_cpu(info->handle);
 		block_count = __le16_to_cpu(info->blocks);
 
-		conn = hci_conn_hash_lookup_handle(hdev, handle);
+		conn = __hci_conn_lookup_handle(hdev, handle);
 		if (!conn)
 			continue;
 
-- 
1.7.9.5

