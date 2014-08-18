Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Remove unused l2cap_conn_shutdown API
Date: Mon, 18 Aug 2014 20:33:30 +0300
Message-Id: <1408383214-16366-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that there are no more users of the l2cap_conn_shutdown API (since
smp.c switched to using hci_disconnect) we can simply remove it along
with all of it's l2cap_conn variables.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  4 ----
 net/bluetooth/l2cap_core.c    | 25 -------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8f1652ed3326..be25eddea615 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -625,9 +625,6 @@ struct l2cap_conn {
 
 	struct delayed_work	info_timer;
 
-	int			disconn_err;
-	struct work_struct	disconn_work;
-
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
 	__u8			tx_ident;
@@ -947,7 +944,6 @@ void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 		       u8 status);
 void __l2cap_physical_cfm(struct l2cap_chan *chan, int result);
 
-void l2cap_conn_shutdown(struct l2cap_conn *conn, int err);
 struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
 void l2cap_conn_put(struct l2cap_conn *conn);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2d550afe4322..2d9a2b58d2c8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1635,9 +1635,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
-	if (work_pending(&conn->disconn_work))
-		cancel_work_sync(&conn->disconn_work);
-
 	l2cap_unregister_all_users(conn);
 
 	/* Force the connection to be immediately dropped */
@@ -1670,26 +1667,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	l2cap_conn_put(conn);
 }
 
-static void disconn_work(struct work_struct *work)
-{
-	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
-					       disconn_work);
-
-	BT_DBG("conn %p", conn);
-
-	l2cap_conn_del(conn->hcon, conn->disconn_err);
-}
-
-void l2cap_conn_shutdown(struct l2cap_conn *conn, int err)
-{
-	struct hci_dev *hdev = conn->hcon->hdev;
-
-	BT_DBG("conn %p err %d", conn, err);
-
-	conn->disconn_err = err;
-	queue_work(hdev->workqueue, &conn->disconn_work);
-}
-
 static void l2cap_conn_free(struct kref *ref)
 {
 	struct l2cap_conn *conn = container_of(ref, struct l2cap_conn, ref);
@@ -6943,8 +6920,6 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
 
-	INIT_WORK(&conn->disconn_work, disconn_work);
-
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
 
-- 
1.9.3

