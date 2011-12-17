Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 16/22] Bluetooth: convert info timer to delayed_work
Date: Sat, 17 Dec 2011 19:29:36 -0200
Message-Id: <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Another step of remove interrupt context from Bluetooth Core.
Use the system workqueue.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a175091..f791374 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -522,7 +522,7 @@ struct l2cap_conn {
 	__u8		info_state;
 	__u8		info_ident;
 
-	struct timer_list info_timer;
+	struct delayed_work info_work;
 
 	spinlock_t	lock;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5c5948f..a78cdf7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -698,7 +698,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		mod_timer(&conn->info_timer, jiffies +
+		schedule_delayed_work(&conn->info_work,
 					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
 
 		l2cap_send_cmd(conn, conn->info_ident,
@@ -998,9 +998,10 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	mutex_unlock(&conn->chan_lock);
 }
 
-static void l2cap_info_timeout(unsigned long arg)
+static void l2cap_info_timeout(struct work_struct *work)
 {
-	struct l2cap_conn *conn = (void *) arg;
+	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
+							info_work.work);
 
 	conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 	conn->info_ident = 0;
@@ -1033,7 +1034,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		del_timer_sync(&conn->info_timer);
+		cancel_delayed_work_sync(&conn->info_work);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
 		del_timer(&conn->security_timer);
@@ -1094,8 +1095,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 		setup_timer(&conn->security_timer, security_timeout,
 						(unsigned long) conn);
 	else
-		setup_timer(&conn->info_timer, l2cap_info_timeout,
-						(unsigned long) conn);
+		INIT_DELAYED_WORK(&conn->info_work, l2cap_info_timeout);
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
@@ -2530,7 +2530,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
 					cmd->ident == conn->info_ident) {
-		del_timer(&conn->info_timer);
+		cancel_delayed_work_sync(&conn->info_work);
 
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -2656,7 +2656,7 @@ sendresp:
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		mod_timer(&conn->info_timer, jiffies +
+		schedule_delayed_work(&conn->info_work,
 					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
 
 		l2cap_send_cmd(conn, conn->info_ident,
@@ -3081,7 +3081,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
 		return 0;
 
-	del_timer(&conn->info_timer);
+	cancel_delayed_work_sync(&conn->info_work);
 
 	if (result != L2CAP_IR_SUCCESS) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
-- 
1.7.6.4

