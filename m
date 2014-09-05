Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/7] Bluetooth: Move identity address update behind a workqueue
Date: Fri,  5 Sep 2014 20:50:48 +0300
Message-Id: <1409939452-5928-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409939452-5928-1-git-send-email-johan.hedberg@gmail.com>
References: <1409939452-5928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The identity address update of all channels for an l2cap_conn needs to
take the lock for each channel, i.e. it's safest to do this by a
separate workqueue callback.

Previously this was partially solved by moving the entire SMP key
distribution behind a workqueue. However, if we want SMP context locking
to be correct and safe we should always use the l2cap_chan lock when
accessing it, meaning even smp_distribute_keys needs to take that lock
which would once again create a dead lock when updating the identity
address.

The simplest way to solve this is to have l2cap_conn manage the deferred
work which is what this patch does. A subsequent patch will remove the
now unnecessary SMP key distribution work struct.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  3 ++-
 net/bluetooth/l2cap_core.c    | 10 ++++++++--
 net/bluetooth/smp.c           |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index be25eddea615..ead99f032f7a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -633,6 +633,8 @@ struct l2cap_conn {
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
 
+	struct work_struct	id_addr_update_work;
+
 	__u8			disc_reason;
 
 	struct l2cap_chan	*smp;
@@ -937,7 +939,6 @@ int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
-void l2cap_conn_update_id_addr(struct hci_conn *hcon);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
 void l2cap_move_start(struct l2cap_chan *chan);
 void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ab405f0e53cb..b71430caab4a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -631,9 +631,11 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
-void l2cap_conn_update_id_addr(struct hci_conn *hcon)
+static void l2cap_conn_update_id_addr(struct work_struct *work)
 {
-	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
+					       id_addr_update_work);
+	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
 	mutex_lock(&conn->chan_lock);
@@ -1635,6 +1637,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
+	if (work_pending(&conn->id_addr_update_work))
+		cancel_work_sync(&conn->id_addr_update_work);
+
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -6927,6 +6932,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
+	INIT_WORK(&conn->id_addr_update_work, l2cap_conn_update_id_addr);
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9accb4739488..795c603bed30 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -654,7 +654,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		 */
 		bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
 		hcon->dst_type = smp->remote_irk->addr_type;
-		l2cap_conn_update_id_addr(hcon);
+		queue_work(hdev->workqueue, &conn->id_addr_update_work);
 
 		/* When receiving an indentity resolving key for
 		 * a remote device that does not use a resolvable
-- 
1.9.3

