Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: Queue incoming ACL data until BT_CONNECTED state is reached
Date: Fri, 17 Jan 2014 11:33:26 +0200
Message-Id: <1389951206-22294-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1389951206-22294-1-git-send-email-johan.hedberg@gmail.com>
References: <1389951206-22294-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a queue for incoming L2CAP data that's received before
l2cap_connect_cfm is called and processes the data once
l2cap_connect_cfm is called. This way we ensure that we have e.g. all
remote features before processing L2CAP signaling data (which is very
important for making the correct security decisions).

The processing of the pending rx data needs to be done through
queue_work since unlike l2cap_recv_acldata, l2cap_connect_cfm is called
with the hci_dev lock held which could cause potential deadlocks.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  3 +++
 net/bluetooth/l2cap_core.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c695083eee2b..85cf40acc47e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -624,6 +624,9 @@ struct l2cap_conn {
 	__u32			rx_len;
 	__u8			tx_ident;
 
+	struct sk_buff_head	pending_rx;
+	struct work_struct	pending_rx_work;
+
 	__u8			disc_reason;
 
 	struct delayed_work	security_timer;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 317a5737daf6..fa59a32b0497 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1550,6 +1550,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	}
 
 	mutex_unlock(&conn->chan_lock);
+
+	queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
 }
 
 /* Notify sockets that we cannot guaranty reliability anymore */
@@ -1675,6 +1677,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	kfree_skb(conn->rx_skb);
 
+	skb_queue_purge(&conn->pending_rx);
+	flush_work(&conn->pending_rx_work);
+
 	l2cap_unregister_all_users(conn);
 
 	mutex_lock(&conn->chan_lock);
@@ -6880,9 +6885,16 @@ drop:
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
+	struct hci_conn *hcon = conn->hcon;
 	u16 cid, len;
 	__le16 psm;
 
+	if (hcon->state != BT_CONNECTED) {
+		BT_DBG("queueing pending rx skb");
+		skb_queue_tail(&conn->pending_rx, skb);
+		return;
+	}
+
 	skb_pull(skb, L2CAP_HDR_SIZE);
 	cid = __le16_to_cpu(lh->cid);
 	len = __le16_to_cpu(lh->len);
@@ -6928,6 +6940,24 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 }
 
+static void process_pending_rx(struct work_struct *work)
+{
+	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
+					       pending_rx_work);
+
+	BT_DBG("");
+
+	while (1) {
+		struct sk_buff *skb;
+
+		skb = skb_dequeue(&conn->pending_rx);
+		if (!skb)
+			break;
+
+		l2cap_recv_frame(conn, skb);
+	}
+}
+
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -6983,6 +7013,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	else
 		INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
 
+	skb_queue_head_init(&conn->pending_rx);
+	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
+
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	return conn;
-- 
1.8.4.2

