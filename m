Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 4/6] Bluetooth: Clean up magic pointers
Date: Wed,  7 Dec 2011 15:56:54 +0200
Message-Id: <1323266216-25261-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 include/net/bluetooth/hci.h |    7 ++++++-
 net/bluetooth/hci_event.c   |    8 ++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9490c2c..b9c0087 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -981,9 +981,14 @@ struct hci_ev_role_change {
 } __packed;
 
 #define HCI_EV_NUM_COMP_PKTS		0x13
+struct hci_comp_pkts_info {
+	__le16   handle;
+	__le16   count;
+} __packed;
+
 struct hci_ev_num_comp_pkts {
 	__u8     num_hndl;
-	/* variable length part */
+	struct hci_comp_pkts_info handles[0];
 } __packed;
 
 #define HCI_EV_MODE_CHANGE		0x14
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a06cc60..cfccf7e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2266,7 +2266,6 @@ static inline void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb
 static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
-	__le16 *ptr;
 	int i;
 
 	skb_pull(skb, sizeof(*ev));
@@ -2285,12 +2284,13 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	tasklet_disable(&hdev->tx_task);
 
-	for (i = 0, ptr = (__le16 *) skb->data; i < ev->num_hndl; i++) {
+	for (i = 0; i < ev->num_hndl; i++) {
 		struct hci_conn *conn;
+		struct hci_comp_pkts_info *info = &ev->handles[i];
 		__u16  handle, count;
 
-		handle = get_unaligned_le16(ptr++);
-		count  = get_unaligned_le16(ptr++);
+		handle = __le16_to_cpu(info->handle);
+		count  = __le16_to_cpu(info->count);
 
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!conn)
-- 
1.7.4.1

