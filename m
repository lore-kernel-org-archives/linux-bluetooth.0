Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Make data pointer of hci_recv_stream_fragment const
Date: Sat,  4 Apr 2015 20:59:40 -0700
Message-Id: <1428206381-6111-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The data pointer provided to hci_recv_stream_fragment function should
have been marked const. The function has no business in modifying the
original data. So fix this now.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 93fd3e756b8a..ad957f336ead 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1012,7 +1012,7 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
-int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
+int hci_recv_stream_fragment(struct hci_dev *hdev, const void *data, int count);
 
 void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 46b114c0140b..c9e7cafb245a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3320,7 +3320,7 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(hci_recv_frame);
 
-static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
+static int hci_reassembly(struct hci_dev *hdev, int type, const void *data,
 			  int count, __u8 index)
 {
 	int len = 0;
@@ -3430,7 +3430,7 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 
 #define STREAM_REASSEMBLY 0
 
-int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
+int hci_recv_stream_fragment(struct hci_dev *hdev, const void *data, int count)
 {
 	int type;
 	int rem = 0;
@@ -3439,7 +3439,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
 		struct sk_buff *skb = hdev->reassembly[STREAM_REASSEMBLY];
 
 		if (!skb) {
-			struct { char type; } *pkt;
+			const struct { char type; } *pkt;
 
 			/* Start of the frame */
 			pkt = data;
-- 
2.1.0

