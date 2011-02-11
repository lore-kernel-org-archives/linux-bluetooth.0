Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [bluetooth-next -v2 03/24] Bluetooth: Use LE buffers for LE traffic
Date: Thu, 10 Feb 2011 22:38:48 -0300
Message-Id: <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Bluetooth chips may have separate buffers for LE traffic.
This patch add support to use LE buffers provided by the chip.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_conn.c         |    5 +++
 net/bluetooth/hci_core.c         |   74 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c        |   33 +++++++++++++++++
 4 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f434e96..d30b93c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -123,15 +123,19 @@ struct hci_dev {
 	atomic_t	cmd_cnt;
 	unsigned int	acl_cnt;
 	unsigned int	sco_cnt;
+	unsigned int	le_cnt;
 
 	unsigned int	acl_mtu;
 	unsigned int	sco_mtu;
+	unsigned int	le_mtu;
 	unsigned int	acl_pkts;
 	unsigned int	sco_pkts;
+	unsigned int	le_pkts;
 
 	unsigned long	cmd_last_tx;
 	unsigned long	acl_last_tx;
 	unsigned long	sco_last_tx;
+	unsigned long	le_last_tx;
 
 	struct workqueue_struct	*workqueue;
 
@@ -521,6 +525,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
+#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 
 /* ----- HCI protocols ----- */
 struct hci_proto {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d0c470c..aecd78e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -326,6 +326,11 @@ int hci_conn_del(struct hci_conn *conn)
 
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
+	} else if (conn->type == LE_LINK) {
+		if (hdev->le_pkts)
+			hdev->le_cnt += conn->sent;
+		else
+			hdev->acl_cnt += conn->sent;
 	} else {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f00322..9296053 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -263,6 +263,14 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
 }
 
+static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
+{
+	BT_DBG("%s", hdev->name);
+
+	/* Read LE buffer size */
+	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+}
+
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
 {
 	__u8 scan = opt;
@@ -529,6 +537,10 @@ int hci_dev_open(__u16 dev)
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
+		if (lmp_le_capable(hdev))
+			ret = __hci_request(hdev, hci_le_init_req, 0,
+					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -671,7 +683,7 @@ int hci_dev_reset(__u16 dev)
 		hdev->flush(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0;
+	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
@@ -1672,8 +1684,25 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 	}
 
 	if (conn) {
-		int cnt = (type == ACL_LINK ? hdev->acl_cnt : hdev->sco_cnt);
-		int q = cnt / num;
+		int cnt, q;
+
+		switch (conn->type) {
+		case ACL_LINK:
+			cnt = hdev->acl_cnt;
+			break;
+		case SCO_LINK:
+		case ESCO_LINK:
+			cnt = hdev->sco_cnt;
+			break;
+		case LE_LINK:
+			cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
+			break;
+		default:
+			cnt = 0;
+			BT_ERR("Unknown link type");
+		}
+
+		q = cnt / num;
 		*quote = q ? q : 1;
 	} else
 		*quote = 0;
@@ -1772,6 +1801,40 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 	}
 }
 
+static inline void hci_sched_le(struct hci_dev *hdev)
+{
+	struct hci_conn *conn;
+	struct sk_buff *skb;
+	int quote, cnt;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!test_bit(HCI_RAW, &hdev->flags)) {
+		/* LE tx timeout must be longer than maximum
+		 * link supervision timeout (40.9 seconds) */
+		if (!hdev->le_cnt &&
+				time_after(jiffies, hdev->le_last_tx + HZ * 45))
+			hci_acl_tx_to(hdev);
+	}
+
+	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+	while (cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+			BT_DBG("skb %p len %d", skb, skb->len);
+
+			hci_send_frame(skb);
+			hdev->le_last_tx = jiffies;
+
+			cnt--;
+			conn->sent++;
+		}
+	}
+	if (hdev->le_pkts)
+		hdev->le_cnt = cnt;
+	else
+		hdev->acl_cnt = cnt;
+}
+
 static void hci_tx_task(unsigned long arg)
 {
 	struct hci_dev *hdev = (struct hci_dev *) arg;
@@ -1779,7 +1842,8 @@ static void hci_tx_task(unsigned long arg)
 
 	read_lock(&hci_task_lock);
 
-	BT_DBG("%s acl %d sco %d", hdev->name, hdev->acl_cnt, hdev->sco_cnt);
+	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
+		hdev->sco_cnt, hdev->le_cnt);
 
 	/* Schedule queues and send stuff to HCI driver */
 
@@ -1789,6 +1853,8 @@ static void hci_tx_task(unsigned long arg)
 
 	hci_sched_esco(hdev);
 
+	hci_sched_le(hdev);
+
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 47c6e93..3155ad5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -776,6 +776,25 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 		mgmt_pin_code_neg_reply_complete(hdev->id, &rp->bdaddr,
 								rp->status);
 }
+static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
+				       struct sk_buff *skb)
+{
+	struct hci_rp_le_read_buffer_size *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->le_mtu = __le16_to_cpu(rp->le_mtu);
+	hdev->le_pkts = rp->le_max_pkt;
+
+	hdev->le_cnt = hdev->le_pkts;
+
+	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
+
+	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
+}
 
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
@@ -1704,6 +1723,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_pin_code_neg_reply(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_BUFFER_SIZE:
+		hci_cc_le_read_buffer_size(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
@@ -1849,6 +1872,16 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 				hdev->acl_cnt += count;
 				if (hdev->acl_cnt > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
+			} else if (conn->type == LE_LINK) {
+				if (hdev->le_pkts) {
+					hdev->le_cnt += count;
+					if (hdev->le_cnt > hdev->le_pkts)
+						hdev->le_cnt = hdev->le_pkts;
+				} else {
+					hdev->acl_cnt += count;
+					if (hdev->acl_cnt > hdev->acl_pkts)
+						hdev->acl_cnt = hdev->acl_pkts;
+				}
 			} else {
 				hdev->sco_cnt += count;
 				if (hdev->sco_cnt > hdev->sco_pkts)
-- 
1.7.4

