Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v5 3/3] Implemented HCI frame reassembly for stream Rx
Date: Mon, 12 Jul 2010 17:42:24 +0530
Message-ID: <1278936744-6003-3-git-send-email-suraj@atheros.com>
In-Reply-To: <1278936744-6003-2-git-send-email-suraj@atheros.com>
References: <1278936744-6003-1-git-send-email-suraj@atheros.com>
 <1278936744-6003-2-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented frame reassembly implementation for reassembling fragments
received from stream.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 600372d..345fc14 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -124,6 +124,7 @@ struct hci_dev {
 
 	struct sk_buff		*sent_cmd;
 	struct sk_buff		*reassembly[3];
+	struct sk_buff		*stream_reassembly;
 
 	struct mutex		req_lock;
 	wait_queue_head_t	req_wait_q;
@@ -437,6 +438,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
 int hci_register_sysfs(struct hci_dev *hdev);
 void hci_unregister_sysfs(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ca6182c..6025257 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -917,6 +917,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	for (i = 0; i < 3; i++)
 		hdev->reassembly[i] = NULL;
 
+	hdev->stream_reassembly = NULL;
+
 	init_waitqueue_head(&hdev->req_wait_q);
 	mutex_init(&hdev->req_lock);
 
@@ -976,6 +978,8 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	for (i = 0; i < 3; i++)
 		kfree_skb(hdev->reassembly[i]);
 
+	kfree_skb(hdev->stream_reassembly);
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
@@ -1166,6 +1170,39 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 }
 EXPORT_SYMBOL(hci_recv_fragment);
 
+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
+{
+	int type;
+	int rem = 0;
+
+	do {
+		struct sk_buff *skb = hdev->stream_reassembly;
+		if (!skb) {
+			struct { char type; } *pkt;
+
+			/* Start of the frame */
+			pkt = data;
+			type = pkt->type;
+
+			data++;
+			count--;
+		} else
+			type = bt_cb(skb)->pkt_type;
+
+		rem = hci_reassembly(hdev, type, data, count, &skb, GFP_ATOMIC);
+		if (rem < 0)
+			return rem;
+
+		hdev->stream_reassembly = skb;
+
+		data += (count - rem);
+		count = rem;
+	} while (count);
+
+	return rem;
+}
+EXPORT_SYMBOL(hci_recv_stream_fragment);
+
 /* ---- Interface to upper protocols ---- */
 
 /* Register/Unregister protocols.
-- 
1.7.0.4

