Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Move mgmt_event helper function to different location
Date: Fri,  4 Jul 2014 19:06:22 +0200
Message-Id: <1404493583-56960-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move the mgmt_event function higher up in the code so that no forward
declaration is needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 60 ++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 91bccef63f30..4ef73523d95b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -212,6 +212,36 @@ static u8 mgmt_status(u8 hci_status)
 	return MGMT_STATUS_FAILED;
 }
 
+static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
+		      struct sock *skip_sk)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+
+	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(event);
+	if (hdev)
+		hdr->index = cpu_to_le16(hdev->id);
+	else
+		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
+	hdr->len = cpu_to_le16(data_len);
+
+	if (data)
+		memcpy(skb_put(skb, data_len), data, data_len);
+
+	/* Time stamp */
+	__net_timestamp(skb);
+
+	hci_send_to_control(skb, skip_sk);
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -1364,36 +1394,6 @@ failed:
 	return err;
 }
 
-static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
-		      struct sock *skip_sk)
-{
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(event);
-	if (hdev)
-		hdr->index = cpu_to_le16(hdev->id);
-	else
-		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
-	hdr->len = cpu_to_le16(data_len);
-
-	if (data)
-		memcpy(skb_put(skb, data_len), data, data_len);
-
-	/* Time stamp */
-	__net_timestamp(skb);
-
-	hci_send_to_control(skb, skip_sk);
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int new_settings(struct hci_dev *hdev, struct sock *skip)
 {
 	__le32 ev;
-- 
1.9.3

