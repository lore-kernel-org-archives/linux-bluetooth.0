Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5 v2] Bluetooth: make use of connection number to optimize the scheduler
Date: Wed, 17 Aug 2011 16:23:00 +0300
Message-Id: <1313587384-2653-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
References: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if there is any existing connection according to its type
before start iterating in the list and immediately stop iterating when
reaching the number of connections.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   16 ++++++++++++++++
 net/bluetooth/hci_core.c         |   15 +++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f441b8..e2ba4d6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -395,6 +395,22 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	}
 }
 
+static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	switch (type) {
+	case ACL_LINK:
+		return h->acl_num;
+	case LE_LINK:
+		return h->le_num;
+	case SCO_LINK:
+	case ESCO_LINK:
+		return h->sco_num;
+	default:
+		return 0;
+	}
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 								__u16 handle)
 {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ec0bc3f..9574752 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2075,6 +2075,9 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 			min  = c->sent;
 			conn = c;
 		}
+
+		if (hci_conn_num(hdev, type) == num)
+			break;
 	}
 
 	if (conn) {
@@ -2132,6 +2135,9 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_conn_num(hdev, ACL_LINK))
+		return;
+
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
@@ -2163,6 +2169,9 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_conn_num(hdev, SCO_LINK))
+		return;
+
 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
@@ -2183,6 +2192,9 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_conn_num(hdev, ESCO_LINK))
+		return;
+
 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
@@ -2203,6 +2215,9 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_conn_num(hdev, LE_LINK))
+		return;
+
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
-- 
1.7.6

