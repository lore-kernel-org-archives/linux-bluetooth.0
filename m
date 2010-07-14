Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v7 4/4] Implemented HCI frame reassembly for Rx from stream
Date: Wed, 14 Jul 2010 13:02:19 +0530
Message-ID: <1279092739-4623-4-git-send-email-suraj@atheros.com>
In-Reply-To: <1279092739-4623-3-git-send-email-suraj@atheros.com>
References: <1279092739-4623-1-git-send-email-suraj@atheros.com>
 <1279092739-4623-2-git-send-email-suraj@atheros.com>
 <1279092739-4623-3-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented frame reassembly implementation for reassembling fragments
received from stream.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 28e5eee..350b3e6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -437,6 +437,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
 int hci_register_sysfs(struct hci_dev *hdev);
 void hci_unregister_sysfs(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 451e266..995c9f9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1163,6 +1163,41 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 }
 EXPORT_SYMBOL(hci_recv_fragment);
 
+#define STREAM_REASSEMBLY 0
+
+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
+{
+	int type;
+	int rem = 0;
+
+	do {
+		struct sk_buff *skb = hdev->reassembly[STREAM_REASSEMBLY];
+
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
+		rem = hci_reassembly(hdev, type, data,
+					count, STREAM_REASSEMBLY, GFP_ATOMIC);
+		if (rem < 0)
+			return rem;
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

