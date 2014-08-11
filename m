Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Remove unused l2cap_conn->security_timer
Date: Mon, 11 Aug 2014 15:40:16 +0300
Message-Id: <1407760819-25734-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407760819-25734-1-git-send-email-johan.hedberg@gmail.com>
References: <1407760819-25734-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that there are no-longer any users for l2cap_conn->security_timer we
can go ahead and simply remove it. The patch makes initialization of the
conn->info_timer unconditional since it's better not to leave any
l2cap_conn data structures uninitialized no matter what the underlying
transport.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 -
 net/bluetooth/l2cap_core.c    | 18 +-----------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index bdf2287abcd2..8349908946bc 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -638,7 +638,6 @@ struct l2cap_conn {
 
 	__u8			disc_reason;
 
-	struct delayed_work	security_timer;
 	struct l2cap_chan	*smp;
 
 	struct list_head	chan_l;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 550d58b7d831..cf88799a92db 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1659,19 +1659,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	l2cap_conn_put(conn);
 }
 
-static void security_timeout(struct work_struct *work)
-{
-	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
-					       security_timer.work);
-
-	BT_DBG("conn %p", conn);
-
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
-		smp_chan_destroy(conn);
-		l2cap_conn_del(conn->hcon, ETIMEDOUT);
-	}
-}
-
 static void disconn_work(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
@@ -6948,10 +6935,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	INIT_LIST_HEAD(&conn->chan_l);
 	INIT_LIST_HEAD(&conn->users);
 
-	if (hcon->type == LE_LINK)
-		INIT_DELAYED_WORK(&conn->security_timer, security_timeout);
-	else
-		INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
+	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
 
 	INIT_WORK(&conn->disconn_work, disconn_work);
 
-- 
1.9.3

