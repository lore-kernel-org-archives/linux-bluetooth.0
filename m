Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Test 'count' value before enter the loop
Date: Sat, 24 Jul 2010 01:34:54 -0300
Message-Id: <1279946094-17478-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Testing first we avoid enter the loop when count = 0.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 995c9f9..8303f1c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1149,7 +1149,7 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
 		return -EILSEQ;
 
-	do {
+	while (count) {
 		rem = hci_reassembly(hdev, type, data, count,
 						type - 1, GFP_ATOMIC);
 		if (rem < 0)
@@ -1157,7 +1157,7 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 
 		data += (count - rem);
 		count = rem;
-	} while (count);
+	};
 
 	return rem;
 }
@@ -1170,7 +1170,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
 	int type;
 	int rem = 0;
 
-	do {
+	while (count) {
 		struct sk_buff *skb = hdev->reassembly[STREAM_REASSEMBLY];
 
 		if (!skb) {
@@ -1192,7 +1192,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
 
 		data += (count - rem);
 		count = rem;
-	} while (count);
+	};
 
 	return rem;
 }
-- 
1.7.1.1
