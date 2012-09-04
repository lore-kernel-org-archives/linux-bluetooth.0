Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 10/15] Bluetooth: AMP: Handle AMP_LINK connection
Date: Tue,  4 Sep 2012 16:44:29 +0300
Message-Id: <1346766274-21612-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AMP_LINK represents physical link between AMP controllers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   13 +++++++++++++
 net/bluetooth/hci_core.c         |   20 ++++++++++++++++++--
 net/bluetooth/hci_event.c        |    1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 29e0601..6593270 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -73,6 +73,7 @@ struct discovery_state {
 struct hci_conn_hash {
 	struct list_head list;
 	unsigned int     acl_num;
+	unsigned int     amp_num;
 	unsigned int     sco_num;
 	unsigned int     le_num;
 };
@@ -448,6 +449,9 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case ACL_LINK:
 		h->acl_num++;
 		break;
+	case AMP_LINK:
+		h->amp_num++;
+		break;
 	case LE_LINK:
 		h->le_num++;
 		break;
@@ -469,6 +473,9 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case ACL_LINK:
 		h->acl_num--;
 		break;
+	case AMP_LINK:
+		h->amp_num--;
+		break;
 	case LE_LINK:
 		h->le_num--;
 		break;
@@ -485,6 +492,8 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	switch (type) {
 	case ACL_LINK:
 		return h->acl_num;
+	case AMP_LINK:
+		return h->amp_num;
 	case LE_LINK:
 		return h->le_num;
 	case SCO_LINK:
@@ -805,6 +814,10 @@ static inline void hci_proto_disconn_cfm(struct hci_conn *conn, __u8 reason)
 		sco_disconn_cfm(conn, reason);
 		break;
 
+	/* L2CAP would be handled for BREDR chan */
+	case AMP_LINK:
+		break;
+
 	default:
 		BT_ERR("unknown link type %d", conn->type);
 		break;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ab4fca2..179b9e3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2379,6 +2379,9 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	case ACL_LINK:
 		cnt = hdev->acl_cnt;
 		break;
+	case AMP_LINK:
+		cnt = hdev->block_cnt;
+		break;
 	case SCO_LINK:
 	case ESCO_LINK:
 		cnt = hdev->sco_cnt;
@@ -2508,11 +2511,19 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	struct hci_chan *chan;
 	struct sk_buff *skb;
 	int quote;
+	u8 type;
 
 	__check_timeout(hdev, cnt);
 
+	BT_DBG("%s", hdev->name);
+
+	if (hdev->dev_type == HCI_AMP)
+		type = AMP_LINK;
+	else
+		type = ACL_LINK;
+
 	while (hdev->block_cnt > 0 &&
-	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
+	       (chan = hci_chan_sent(hdev, type, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
 			int blocks;
@@ -2552,7 +2563,12 @@ static void hci_sched_acl(struct hci_dev *hdev)
 {
 	BT_DBG("%s", hdev->name);
 
-	if (!hci_conn_num(hdev, ACL_LINK))
+	/* No ACL link over BR/EDR controller */
+	if (!hci_conn_num(hdev, ACL_LINK) && hdev->dev_type == HCI_BREDR)
+		return;
+
+	/* No AMP link over AMP controller */
+	if (!hci_conn_num(hdev, AMP_LINK) && hdev->dev_type == HCI_AMP)
 		return;
 
 	switch (hdev->flow_ctl_mode) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 07209e5..fc40f5b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2685,6 +2685,7 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		switch (conn->type) {
 		case ACL_LINK:
+		case AMP_LINK:
 			hdev->block_cnt += block_count;
 			if (hdev->block_cnt > hdev->num_blocks)
 				hdev->block_cnt = hdev->num_blocks;
-- 
1.7.9.5

