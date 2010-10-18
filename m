Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 3/6] Bluetooth: Use LE buffers for LE traffic
Date: Mon, 18 Oct 2010 16:02:53 +0300
Message-Id: <1287406976-13463-4-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BLuetooth chips may have separate buffers for
LE traffic. This patch add support to use LE
buffers provided by the chip.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci.h      |    2 +
 include/net/bluetooth/hci_core.h |    5 +++
 net/bluetooth/hci_conn.c         |    6 +++
 net/bluetooth/hci_core.c         |   74 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c        |   40 +++++++++++++++++++-
 5 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 02055b9..b42edf0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -189,6 +189,8 @@ enum {
 
 #define LMP_EV4		0x01
 #define LMP_EV5		0x02
+#define LMP_NO_BREDR	0x20
+#define LMP_LE		0x40
 
 #define LMP_SNIFF_SUBR	0x02
 #define LMP_EDR_ESCO_2M	0x20
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fc2aaee..326d290 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -103,15 +103,19 @@ struct hci_dev {
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
 
@@ -469,6 +473,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
+#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 
 /* ----- HCI protocols ----- */
 struct hci_proto {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c1eb8e0..c7309e4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -324,6 +324,11 @@ int hci_conn_del(struct hci_conn *conn)
 
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
@@ -409,6 +414,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 			return NULL;
 
 		hci_le_connect(le);
+		hci_conn_hold(le);
 
 		return le;
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc2a052..45c78c2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -254,6 +254,14 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
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
@@ -509,6 +517,10 @@ int hci_dev_open(__u16 dev)
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
+		if (lmp_le_capable(hdev))
+			ret = __hci_request(hdev, hci_le_init_req, 0,
+					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -645,7 +657,7 @@ int hci_dev_reset(__u16 dev)
 		hdev->flush(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0;
+	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
@@ -1456,8 +1468,25 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
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
@@ -1556,6 +1585,40 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
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
+		/* ACL tx timeout must be longer than maximum
+		 * link supervision timeout (40.9 seconds) */
+		if (!hdev->le_cnt &&
+		    time_after(jiffies, hdev->le_last_tx + HZ * 45))
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
@@ -1563,7 +1626,8 @@ static void hci_tx_task(unsigned long arg)
 
 	read_lock(&hci_task_lock);
 
-	BT_DBG("%s acl %d sco %d", hdev->name, hdev->acl_cnt, hdev->sco_cnt);
+	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
+		hdev->sco_cnt, hdev->le_cnt);
 
 	/* Schedule queues and send stuff to HCI driver */
 
@@ -1573,6 +1637,8 @@ static void hci_tx_task(unsigned long arg)
 
 	hci_sched_esco(hdev);
 
+	hci_sched_le(hdev);
+
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4061613..499c823 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -539,6 +539,26 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, rp->status);
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
+	hci_req_complete(hdev, rp->status);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1352,6 +1372,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_BUFFER_SIZE:
+		hci_cc_le_read_buffer_size(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
@@ -1489,10 +1513,22 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sent -= count;
 
 			if (conn->type == ACL_LINK) {
-				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
+				hdev->acl_cnt += count;
+				if (hdev->acl_cnt > hdev->acl_pkts)
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
-				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
+				hdev->sco_cnt += count;
+				if (hdev->sco_cnt > hdev->sco_pkts)
 					hdev->sco_cnt = hdev->sco_pkts;
 			}
 		}
-- 
1.7.1

