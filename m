Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add public l2cap_conn_drop() API to request disconnection
Date: Mon, 11 Aug 2014 15:24:53 +0300
Message-Id: <1407759894-24739-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407759894-24739-1-git-send-email-johan.hedberg@gmail.com>
References: <1407759894-24739-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since we no-longer do special handling of SMP within l2cap_core.c we
don't have any code for calling l2cap_conn_del() when smp.c doesn't like
the data it gets. At the same time we cannot simply export
l2cap_conn_del() since it will try to lock the channels it calls into
whereas we already hold the lock in the smp.c l2cap_chan callbacks (i.e.
it'd lead to a deadlock).

This patch adds a new l2cap_conn_drop() API which is very similar to
l2cap_conn_del() except that it defers the call to l2cap_conn_del()
through a workqueue, thereby making it safe to use it from an L2CAP
channel callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  4 ++++
 net/bluetooth/l2cap_core.c    | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index bda6252e3722..bdf2287abcd2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -625,6 +625,9 @@ struct l2cap_conn {
 
 	struct delayed_work	info_timer;
 
+	int			disconn_err;
+	struct work_struct	disconn_work;
+
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
 	__u8			tx_ident;
@@ -944,6 +947,7 @@ void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
 void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
+void l2cap_conn_drop(struct l2cap_conn *conn, int err);
 void l2cap_conn_get(struct l2cap_conn *conn);
 void l2cap_conn_put(struct l2cap_conn *conn);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4de1e1827055..550d58b7d831 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1627,6 +1627,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
+	if (work_pending(&conn->disconn_work))
+		cancel_work_sync(&conn->disconn_work);
+
 	l2cap_unregister_all_users(conn);
 
 	mutex_lock(&conn->chan_lock);
@@ -1669,6 +1672,26 @@ static void security_timeout(struct work_struct *work)
 	}
 }
 
+static void disconn_work(struct work_struct *work)
+{
+	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
+					       disconn_work);
+
+	BT_DBG("conn %p", conn);
+
+	l2cap_conn_del(conn->hcon, conn->disconn_err);
+}
+
+void l2cap_conn_drop(struct l2cap_conn *conn, int err)
+{
+	struct hci_dev *hdev = conn->hcon->hdev;
+
+	BT_DBG("conn %p err %d", conn, err);
+
+	conn->disconn_err = err;
+	queue_work(hdev->workqueue, &conn->disconn_work);
+}
+
 static void l2cap_conn_free(struct kref *ref)
 {
 	struct l2cap_conn *conn = container_of(ref, struct l2cap_conn, ref);
@@ -6930,6 +6953,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	else
 		INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
 
+	INIT_WORK(&conn->disconn_work, disconn_work);
+
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
 
-- 
1.9.3

