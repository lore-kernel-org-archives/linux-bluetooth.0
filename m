Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH v6 4/4] Implemented HCI frame reassembly for Rx from stream
Date: Tue, 13 Jul 2010 15:03:31 +0530
Message-ID: <1279013611-4775-4-git-send-email-suraj@atheros.com>
In-Reply-To: <1279013611-4775-3-git-send-email-suraj@atheros.com>
References: <1279013611-4775-1-git-send-email-suraj@atheros.com>
 <1279013611-4775-2-git-send-email-suraj@atheros.com>
 <1279013611-4775-3-git-send-email-suraj@atheros.com>
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
index 10ad3ed..a6453a8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -437,6 +437,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
 int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
 int hci_register_sysfs(struct hci_dev *hdev);
 void hci_unregister_sysfs(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eb13815..d8366f1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1163,6 +1163,41 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 }
 EXPORT_SYMBOL(hci_recv_fragment);
 
+#define STREAM_BUF_INDEX 0
+
+int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
+{
+	int type;
+	int rem = 0;
+
+	do {
+		struct sk_buff *skb = hdev->reassembly[STREAM_BUF_INDEX];
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
+					count, STREAM_BUF_INDEX, GFP_ATOMIC);
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

