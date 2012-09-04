Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 12/15] Bluetooth: Factor out hci_queue_acl
Date: Tue,  4 Sep 2012 16:44:31 +0300
Message-Id: <1346766274-21612-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use hci_chan as parameter instead of hci_conn as we need logical
handle from hci_chan for AMP link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 179b9e3..7a0c20c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2151,9 +2151,10 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 	hdr->dlen   = cpu_to_le16(len);
 }
 
-static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
+static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 			  struct sk_buff *skb, __u16 flags)
 {
+	struct hci_conn *conn = chan->conn;
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
 
@@ -2200,14 +2201,13 @@ static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
 
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 {
-	struct hci_conn *conn = chan->conn;
-	struct hci_dev *hdev = conn->hdev;
+	struct hci_dev *hdev = chan->conn->hdev;
 
 	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
 
 	skb->dev = (void *) hdev;
 
-	hci_queue_acl(conn, &chan->data_q, skb, flags);
+	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
-- 
1.7.9.5

