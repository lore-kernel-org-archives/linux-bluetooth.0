Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove exported hci_recv_fragment function
Date: Tue, 16 Sep 2014 21:36:09 +0200
Message-Id: <1410896169-28726-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_recv_fragment function is no longer used by any driver and thus
do not export it. In fact it is not even needed by the core and it can
be removed altogether.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 20 --------------------
 2 files changed, 21 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 206b92bfeebb..37ff1aef0845 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -926,7 +926,6 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
-int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count);
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
 
 void hci_init_sysfs(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 41948678f514..cb05d7f16a34 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4374,26 +4374,6 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 	return remain;
 }
 
-int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
-{
-	int rem = 0;
-
-	if (type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT)
-		return -EILSEQ;
-
-	while (count) {
-		rem = hci_reassembly(hdev, type, data, count, type - 1);
-		if (rem < 0)
-			return rem;
-
-		data += (count - rem);
-		count = rem;
-	}
-
-	return rem;
-}
-EXPORT_SYMBOL(hci_recv_fragment);
-
 #define STREAM_REASSEMBLY 0
 
 int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
-- 
1.9.3

