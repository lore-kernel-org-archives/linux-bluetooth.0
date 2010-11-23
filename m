Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFC 08/20] Bluetooth: Treat LE and ACL links separately on timeout
Date: Tue, 23 Nov 2010 12:06:24 -0300
Message-Id: <1290524796-32246-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Separate LE and ACL timeouts. Othervise ACL connections
on non LE hw will time out after 45 secs.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 45c78c2..5750b80 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1495,19 +1495,19 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 	return conn;
 }
 
-static inline void hci_acl_tx_to(struct hci_dev *hdev)
+static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
 	struct hci_conn  *c;
 
-	BT_ERR("%s ACL tx timeout", hdev->name);
+	BT_ERR("%s link tx timeout", hdev->name);
 
 	/* Kill stalled connections */
 	list_for_each(p, &h->list) {
 		c = list_entry(p, struct hci_conn, list);
-		if (c->type == ACL_LINK && c->sent) {
-			BT_ERR("%s killing stalled ACL connection %s",
+		if (c->type == type && c->sent) {
+			BT_ERR("%s killing stalled connection %s",
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
 		}
@@ -1526,7 +1526,7 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
-			hci_acl_tx_to(hdev);
+			hci_link_tx_to(hdev, ACL_LINK);
 	}
 
 	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
@@ -1596,9 +1596,9 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->le_cnt &&
+		if (!hdev->le_cnt && hdev->le_pkts &&
 		    time_after(jiffies, hdev->le_last_tx + HZ * 45))
-			hci_acl_tx_to(hdev);
+			hci_link_tx_to(hdev, LE_LINK);
 	}
 
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
-- 
1.7.3.2

