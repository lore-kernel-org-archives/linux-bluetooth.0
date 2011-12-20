Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 3/3] Bluetooth: Rename info_work to info_timer
Date: Tue, 20 Dec 2011 10:57:28 -0200
Message-Id: <1324385848-19101-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324385848-19101-2-git-send-email-padovan@profusion.mobi>
References: <1324385848-19101-1-git-send-email-padovan@profusion.mobi>
 <1324385848-19101-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It makes more sense this way, since info_timer is a timer using delayed
work API.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fc481d1..f141fbe 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -522,7 +522,7 @@ struct l2cap_conn {
 	__u8		info_state;
 	__u8		info_ident;
 
-	struct delayed_work info_work;
+	struct delayed_work info_timer;
 
 	spinlock_t	lock;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d006455..a898285 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -699,7 +699,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		schedule_delayed_work(&conn->info_work,
+		schedule_delayed_work(&conn->info_timer,
 					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
 
 		l2cap_send_cmd(conn, conn->info_ident,
@@ -996,7 +996,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 static void l2cap_info_timeout(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
-							info_work.work);
+							info_timer.work);
 
 	conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 	conn->info_ident = 0;
@@ -1029,7 +1029,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_work);
+		cancel_delayed_work_sync(&conn->info_timer);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
 		cancel_delayed_work_sync(&conn->security_timer);
@@ -1089,7 +1089,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	if (hcon->type == LE_LINK)
 		INIT_DELAYED_WORK(&conn->security_timer, security_timeout);
 	else
-		INIT_DELAYED_WORK(&conn->info_work, l2cap_info_timeout);
+		INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
@@ -2583,7 +2583,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
 					cmd->ident == conn->info_ident) {
-		cancel_delayed_work_sync(&conn->info_work);
+		cancel_delayed_work_sync(&conn->info_timer);
 
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -2704,7 +2704,7 @@ sendresp:
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_SENT;
 		conn->info_ident = l2cap_get_ident(conn);
 
-		schedule_delayed_work(&conn->info_work,
+		schedule_delayed_work(&conn->info_timer,
 					msecs_to_jiffies(L2CAP_INFO_TIMEOUT));
 
 		l2cap_send_cmd(conn, conn->info_ident,
@@ -3129,7 +3129,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
 		return 0;
 
-	cancel_delayed_work_sync(&conn->info_work);
+	cancel_delayed_work_sync(&conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
-- 
1.7.6.4

