Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 4/7] Bluetooth: Use LE buffers for LE traffic
Date: Wed,  6 Oct 2010 20:42:12 +0200
Message-Id: <1286390535-27462-5-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BLuetooth chips may have separate buffers for
LE traffic. This patch add support to use LE
buffers provided by the chip.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci_core.h |    6 +++
 net/bluetooth/hci_conn.c         |   11 +++++-
 net/bluetooth/hci_core.c         |   77 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c        |   34 ++++++++++++++++-
 4 files changed, 120 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a430a57..2eb314f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -102,15 +102,19 @@ struct hci_dev {
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
 
@@ -358,6 +362,8 @@ void hci_conn_enter_sniff_mode(struct hci_conn *conn);
 void hci_conn_hold_device(struct hci_conn *conn);
 void hci_conn_put_device(struct hci_conn *conn);
 
+void hci_le_disconn(struct hci_conn *conn, __u8 reason);
+
 static inline void hci_conn_hold(struct hci_conn *conn)
 {
 	atomic_inc(&conn->refcnt);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 50f8973..3443065 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -232,6 +232,7 @@ static void hci_conn_timeout(unsigned long arg)
 {
 	struct hci_conn *conn = (void *) arg;
 	struct hci_dev *hdev = conn->hdev;
+	__u16 state;
 	__u8 reason;
 
 	BT_DBG("conn %p state %d", conn, conn->state);
@@ -241,7 +242,12 @@ static void hci_conn_timeout(unsigned long arg)
 
 	hci_dev_lock(hdev);
 
-	switch (conn->state) {
+	if (conn->type == LE_LINK)
+		state = conn->le_state;
+	else
+		state = conn->state;
+
+	switch (state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
 		if (conn->type == ACL_LINK && conn->out)
@@ -348,6 +354,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
+	} else if (conn->type == LE_LINK) {
+		hdev->le_cnt += conn->sent;
 	} else {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
@@ -436,6 +444,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 			return NULL;
 
 		hci_le_connect(le);
+		hci_conn_hold(le);
 
 		return le;
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc2a052..b320798 100644
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
@@ -1444,7 +1456,8 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 		if (c->type != type || skb_queue_empty(&c->data_q))
 			continue;
 
-		if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
+		if ((c->state != BT_CONNECTED && c->state != BT_CONFIG) &&
+		    (c->le_state != BT_CONNECTED && c->le_state != BT_CONFIG))
 			continue;
 
 		num++;
@@ -1456,8 +1469,25 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
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
@@ -1482,6 +1512,11 @@ static inline void hci_acl_tx_to(struct hci_dev *hdev)
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
 		}
+		if (c->type == LE_LINK && c->sent) {
+			BT_ERR("%s killing stalled LE connection %s",
+				hdev->name, batostr(&c->dst));
+			hci_le_disconn(c, 0x13);
+		}
 	}
 }
 
@@ -1556,6 +1591,35 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 	}
 }
 
+static inline void hci_sched_le(struct hci_dev *hdev)
+{
+	struct hci_conn *conn;
+	struct sk_buff *skb;
+	int quote;
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
+	while (hdev->le_cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+			BT_DBG("skb %p len %d", skb, skb->len);
+
+			hci_send_frame(skb);
+			hdev->le_last_tx = jiffies;
+
+			hdev->le_cnt--;
+			conn->sent++;
+		}
+	}
+}
+
 static void hci_tx_task(unsigned long arg)
 {
 	struct hci_dev *hdev = (struct hci_dev *) arg;
@@ -1563,7 +1627,8 @@ static void hci_tx_task(unsigned long arg)
 
 	read_lock(&hci_task_lock);
 
-	BT_DBG("%s acl %d sco %d", hdev->name, hdev->acl_cnt, hdev->sco_cnt);
+	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
+		hdev->sco_cnt, hdev->le_cnt);
 
 	/* Schedule queues and send stuff to HCI driver */
 
@@ -1573,6 +1638,8 @@ static void hci_tx_task(unsigned long arg)
 
 	hci_sched_esco(hdev);
 
+	hci_sched_le(hdev);
+
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b979ae..a914314 100644
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
@@ -1397,6 +1417,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_BUFFER_SIZE:
+		hci_cc_le_read_buffer_size(hdev, skb);
+		break;
+
 	case HCI_OP_LE_SET_ADVERTISE_ENABLE:
 		hci_cc_le_set_advertise(hdev, skb);
 		break;
@@ -1542,10 +1566,16 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sent -= count;
 
 			if (conn->type == ACL_LINK) {
-				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
+				hdev->acl_cnt += count;
+				if (hdev->acl_cnt > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
+			} else if (conn->type == LE_LINK) {
+				hdev->le_cnt += count;
+				if (hdev->le_cnt > hdev->le_pkts)
+					hdev->le_cnt = hdev->le_pkts;
 			} else {
-				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
+				hdev->sco_cnt += count;
+				if (hdev->sco_cnt > hdev->sco_pkts)
 					hdev->sco_cnt = hdev->sco_pkts;
 			}
 		}
-- 
1.7.0.1

