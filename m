Return-Path: <cyrus@holtmann.org>
From: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
Subject: [PATCH] Bluetooth: L2CAP socket option to reserve bandwidth
Date: Tue, 24 Jul 2012 13:42:17 +0530
Message-ID: <1343117537-31501-2-git-send-email-manojkr.sharma@stericsson.com>
In-Reply-To: <1343117537-31501-1-git-send-email-manojkr.sharma@stericsson.com>
References: <manojkr.sharma@stericsson.com>
 <1343117537-31501-1-git-send-email-manojkr.sharma@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a socket option for reserving percentage
bandwidth. This can be useful in reserving bandwidth for AVDTP
channels.

Signed-off-by: Manoj Kumar Sharma <manojkr.sharma@stericsson.com>
---
 include/net/bluetooth/bluetooth.h |    2 ++
 include/net/bluetooth/hci_core.h  |    2 ++
 include/net/bluetooth/l2cap.h     |    1 +
 net/bluetooth/hci_conn.c          |   30 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c          |   27 ++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c        |    2 ++
 net/bluetooth/l2cap_sock.c        |   11 +++++++++++
 7 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index a65910b..3d30fbb 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -118,6 +118,8 @@ int bt_err(const char *fmt, ...);
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
+#define BT_BANDWIDTH_RESERVE	14
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index db1c5df..ceff6d6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -346,6 +346,7 @@ struct hci_chan {
 	struct hci_conn *conn;
 	struct sk_buff_head data_q;
 	unsigned int	sent;
+	unsigned int	num_pkt_reserved;
 };
 
 extern struct list_head hci_dev_list;
@@ -567,6 +568,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
+int hci_chan_reserve_bandwidth(struct hci_chan *chan, __u8 percentage);
 int hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f26a468..ec680f6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -482,6 +482,7 @@ struct l2cap_chan {
 	__u32		remote_sdu_itime;
 	__u32		remote_acc_lat;
 	__u32		remote_flush_to;
+	__u8		bandwidth_reserved;
 
 	struct delayed_work	chan_timer;
 	struct delayed_work	retrans_timer;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5238b6b..a211c6c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -954,6 +954,36 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	return chan;
 }
 
+int hci_chan_reserve_bandwidth(struct hci_chan *chan, __u8 percentage)
+{
+	struct hci_dev * hdev = chan->conn->hdev;
+	unsigned int num_pkts_requested = (hdev->acl_pkts * percentage + 50) / 100;
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *conn, *n;
+	unsigned int total_pkts_reserved = 0;
+	unsigned int req_pkts_reserved = 0;
+
+	BT_DBG("Packets reserved calculated %d", num_pkts_requested);
+
+	list_for_each_entry_safe(conn, n, &h->list, list) {
+		struct hci_chan *tmp, *ch;
+
+		list_for_each_entry_safe(tmp, ch, &conn->chan_list, list)
+			total_pkts_reserved += tmp->num_pkt_reserved;
+	}
+
+	req_pkts_reserved = total_pkts_reserved
+							+ num_pkts_requested - chan->num_pkt_reserved;
+
+	if (req_pkts_reserved >= hdev->acl_pkts)
+		return -EBUSY;
+
+	chan->num_pkt_reserved = num_pkts_requested;
+
+	return 0;
+}
+EXPORT_SYMBOL(hci_chan_reserve_bandwidth);
+
 int hci_chan_del(struct hci_chan *chan)
 {
 	struct hci_conn *conn = chan->conn;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6dc44c..bf365f1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2393,10 +2393,11 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 						int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_chan *chan = NULL;
+	struct hci_chan *chan = NULL, *chan_reserved = NULL;
 	int num = 0, min = ~0, cur_prio = 0;
 	struct hci_conn *conn;
 	int cnt, q, conn_num = 0;
+	int num_pkt_reserved = 0;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2419,6 +2420,11 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 			if (skb_queue_empty(&tmp->data_q))
 				continue;
 
+			num_pkt_reserved += tmp->num_pkt_reserved;
+			
+			if (tmp->num_pkt_reserved)
+				chan_reserved = tmp;
+
 			skb = skb_peek(&tmp->data_q);
 			if (skb->priority < cur_prio)
 				continue;
@@ -2464,6 +2470,25 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 	q = cnt / num;
 	*quote = q ? q : 1;
+	if (num_pkt_reserved && chan_reserved &&
+		(chan_reserved->conn->sent < num_pkt_reserved)) {
+		if (!chan->num_pkt_reserved) {
+			int unreserved_credits_left = cnt - num_pkt_reserved;
+
+			if (*quote > unreserved_credits_left)
+				*quote = unreserved_credits_left > 0 ?
+							unreserved_credits_left : 0;
+
+			if (!*quote) {
+				/* Send the packet of reserved channel,
+				 * since bandwidth is not available for sending
+				 * any packets on other channel.
+				 */
+				chan = chan_reserved;
+				*quote = q ? q : 1;
+			}
+		}
+	}
 	BT_DBG("chan %p quote %d", chan, *quote);
 	return chan;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e487731..97bc657 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -347,6 +347,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	hchan = hci_chan_create(conn->hcon);
 	chan->hchan = hchan;
 
+	if (hchan)
+		hci_chan_reserve_bandwidth(hchan, chan->bandwidth_reserved);
 
 	l2cap_chan_hold(chan);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 04e7c17..458aca4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -692,6 +692,17 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		chan->chan_policy = (u8) opt;
 		break;
 
+	case BT_BANDWIDTH_RESERVE:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+		chan->bandwidth_reserved = opt;
+
+		if (chan->hchan)
+			hci_chan_reserve_bandwidth(chan->hchan, chan->bandwidth_reserved);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.6.6.1

