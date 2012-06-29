Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add refcnt to l2cap_conn
Date: Fri, 29 Jun 2012 16:58:34 +0300
Message-Id: <1340978315-4700-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adding kref to l2cap_conn helps to better handle racing when deleting
l2cap_conn. Races are created when deleting conn from timeout and from
the other execution path.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    6 ++
 net/bluetooth/l2cap_core.c    |  128 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/smp.c           |    7 +--
 3 files changed, 113 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d80e3f0..6b85b00 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -572,6 +572,8 @@ struct l2cap_conn {
 
 	struct list_head	chan_l;
 	struct mutex		chan_lock;
+
+	struct kref		kref;
 };
 
 #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
@@ -777,5 +779,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void l2cap_conn_set_timer(struct l2cap_conn *conn, struct delayed_work *work,
+			  long timeout);
+bool l2cap_conn_clear_timer(struct l2cap_conn *conn,
+			    struct delayed_work *work);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5dd7a76..2f7995e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -57,6 +57,70 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 		    struct sk_buff_head *skbs, u8 event);
+static void l2cap_conn_del(struct hci_conn *hcon, int err);
+
+/* ---- L2CAP connections ---- */
+
+static void l2cap_conn_get(struct l2cap_conn *conn)
+{
+	BT_DBG("conn %p refcnt %d -> %d", conn,
+	       atomic_read(&conn->kref.refcount),
+	       atomic_read(&conn->kref.refcount) + 1);
+
+	kref_get(&conn->kref);
+}
+
+static void l2cap_conn_destroy(struct kref *kref)
+{
+	struct l2cap_conn *conn = container_of(kref, struct l2cap_conn, kref);
+
+	BT_DBG("conn %p", conn);
+
+	l2cap_conn_del(conn->hcon, 0);
+}
+
+static int l2cap_conn_put(struct l2cap_conn *conn)
+{
+	/* conn might be NULL, was checked before in l2cap_conn_del */
+	if (!conn) {
+		BT_DBG("conn == NULL");
+		return 1;
+	}
+
+	BT_DBG("conn %p refcnt %d -> %d", conn,
+	       atomic_read(&conn->kref.refcount),
+	       atomic_read(&conn->kref.refcount) - 1);
+
+	return kref_put(&conn->kref, &l2cap_conn_destroy);
+}
+
+void l2cap_conn_set_timer(struct l2cap_conn *conn, struct delayed_work *work,
+			  long timeout)
+{
+	BT_DBG("conn %p timeout %ld", conn, timeout);
+
+	/* If delayed work cancelled do not hold(conn)
+	   since it is already done with previous set_timer */
+	if (!cancel_delayed_work(work))
+		l2cap_conn_get(conn);
+
+	schedule_delayed_work(work, timeout);
+}
+
+bool l2cap_conn_clear_timer(struct l2cap_conn *conn, struct delayed_work *work)
+{
+	bool ret;
+
+	BT_DBG("conn %p", conn);
+
+	/* put(conn) if delayed work cancelled otherwise it
+	   is done in delayed work function */
+	ret = cancel_delayed_work(work);
+	if (ret)
+		l2cap_conn_put(conn);
+
+	return ret;
+}
 
 /* ---- L2CAP channels ---- */
 
@@ -974,7 +1038,8 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
+		l2cap_conn_set_timer(conn, &conn->info_timer,
+				     L2CAP_INFO_TIMEOUT);
 
 		l2cap_send_cmd(conn, conn->info_ident,
 					L2CAP_INFO_REQ, sizeof(req), &req);
@@ -1256,12 +1321,14 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 static void l2cap_info_timeout(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
-							info_timer.work);
+					       info_timer.work);
 
 	conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 	conn->info_ident = 0;
 
 	l2cap_conn_start(conn);
+
+	l2cap_conn_put(conn);
 }
 
 static void l2cap_conn_del(struct hci_conn *hcon, int err)
@@ -1295,13 +1362,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	hci_chan_del(conn->hchan);
 
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
-
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
-		cancel_delayed_work_sync(&conn->security_timer);
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		smp_chan_destroy(conn);
-	}
 
 	hcon->l2cap_data = NULL;
 	kfree(conn);
@@ -1310,14 +1372,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 static void security_timeout(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
-						security_timer.work);
+					       security_timer.work);
 
 	BT_DBG("conn %p", conn);
 
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
-		smp_chan_destroy(conn);
-		l2cap_conn_del(conn->hcon, ETIMEDOUT);
-	}
+	l2cap_conn_put(conn);
 }
 
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
@@ -1359,6 +1418,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 	INIT_LIST_HEAD(&conn->chan_l);
 
+	kref_init(&conn->kref);
+
 	if (hcon->type == LE_LINK)
 		INIT_DELAYED_WORK(&conn->security_timer, security_timeout);
 	else
@@ -3316,8 +3377,8 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		return 0;
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
-					cmd->ident == conn->info_ident) {
-		cancel_delayed_work(&conn->info_timer);
+	    cmd->ident == conn->info_ident) {
+		l2cap_conn_clear_timer(conn, &conn->info_timer);
 
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -3431,10 +3492,11 @@ sendresp:
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		schedule_delayed_work(&conn->info_timer, L2CAP_INFO_TIMEOUT);
+		l2cap_conn_set_timer(conn, &conn->info_timer,
+				     L2CAP_INFO_TIMEOUT);
 
 		l2cap_send_cmd(conn, conn->info_ident,
-					L2CAP_INFO_REQ, sizeof(info), &info);
+			       L2CAP_INFO_REQ, sizeof(info), &info);
 	}
 
 	if (chan && !test_bit(CONF_REQ_SENT, &chan->conf_state) &&
@@ -3887,7 +3949,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
 		return 0;
 
-	cancel_delayed_work(&conn->info_timer);
+	l2cap_conn_clear_timer(conn, &conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
@@ -5270,8 +5332,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case L2CAP_CID_SMP:
-		if (smp_sig_channel(conn, skb))
-			l2cap_conn_del(conn->hcon, EACCES);
+		if (smp_sig_channel(conn, skb)) {
+			l2cap_conn_clear_timer(conn, &conn->security_timer);
+			l2cap_conn_put(conn);
+		}
 		break;
 
 	default:
@@ -5323,8 +5387,14 @@ int l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		conn = l2cap_conn_add(hcon, status);
 		if (conn)
 			l2cap_conn_ready(conn);
-	} else
-		l2cap_conn_del(hcon, bt_to_errno(status));
+	} else {
+		conn = hcon->l2cap_data;
+
+		if (hcon->type == LE_LINK)
+			l2cap_conn_clear_timer(conn, &conn->security_timer);
+
+		l2cap_conn_put(conn);
+	}
 
 	return 0;
 }
@@ -5342,9 +5412,14 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 
 int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
+	struct l2cap_conn *conn = hcon->l2cap_data;
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
-	l2cap_conn_del(hcon, bt_to_errno(reason));
+	if (hcon->type == LE_LINK)
+		l2cap_conn_clear_timer(conn, &conn->security_timer);
+
+	l2cap_conn_put(conn);
+
 	return 0;
 }
 
@@ -5374,10 +5449,13 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
+	l2cap_conn_get(conn);
+
 	if (hcon->type == LE_LINK) {
 		if (!status && encrypt)
 			smp_distribute_keys(conn, 0);
-		cancel_delayed_work(&conn->security_timer);
+
+		l2cap_conn_clear_timer(conn, &conn->security_timer);
 	}
 
 	mutex_lock(&conn->chan_lock);
@@ -5473,6 +5551,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	mutex_unlock(&conn->chan_lock);
 
+	l2cap_conn_put(conn);
+
 	return 0;
 }
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16ef0dc..5bb5b51 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -186,8 +186,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	skb->priority = HCI_PRIO_MAX;
 	hci_send_acl(conn->hchan, skb, 0);
 
-	cancel_delayed_work_sync(&conn->security_timer);
-	schedule_delayed_work(&conn->security_timer, SMP_TIMEOUT);
+	l2cap_conn_set_timer(conn, &conn->security_timer, SMP_TIMEOUT);
 }
 
 static __u8 authreq_to_seclevel(__u8 authreq)
@@ -268,7 +267,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 			 hcon->dst_type, reason);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
-		cancel_delayed_work_sync(&conn->security_timer);
+		l2cap_conn_clear_timer(conn, &conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 }
@@ -999,7 +998,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 	if (conn->hcon->out || force) {
 		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
-		cancel_delayed_work_sync(&conn->security_timer);
+		l2cap_conn_clear_timer(conn, &conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 
-- 
1.7.9.5

