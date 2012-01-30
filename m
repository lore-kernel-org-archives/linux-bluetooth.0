Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: [PATCH v4 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
Date: Mon, 30 Jan 2012 18:26:28 -0200
Message-Id: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

__cancel_delayed_work() is being used in some paths where we cannot
sleep waiting for the delayed work to finish. However, that function
might return while the timer is running and the work will be queued
again. Replace the calls with safer cancel_delayed_work() version
which spins until the timer handler finishes on other CPUs and
cancels the delayed work.

Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    4 ++--
 net/bluetooth/l2cap_core.c    |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e7a8cc7..42fdbb8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -614,7 +614,7 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
 {
 	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
 
-	if (!__cancel_delayed_work(work))
+	if (!cancel_delayed_work(work))
 		l2cap_chan_hold(chan);
 	schedule_delayed_work(work, timeout);
 }
@@ -624,7 +624,7 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 {
 	bool ret;
 
-	ret = __cancel_delayed_work(work);
+	ret = cancel_delayed_work(work);
 	if (ret)
 		l2cap_chan_put(chan);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 942ba1d..ae7fb27 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2588,7 +2588,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
 					cmd->ident == conn->info_ident) {
-		__cancel_delayed_work(&conn->info_timer);
+		cancel_delayed_work(&conn->info_timer);
 
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -3135,7 +3135,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
 		return 0;
 
-	__cancel_delayed_work(&conn->info_timer);
+	cancel_delayed_work(&conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
@@ -4509,7 +4509,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	if (hcon->type == LE_LINK) {
 		smp_distribute_keys(conn, 0);
-		__cancel_delayed_work(&conn->security_timer);
+		cancel_delayed_work(&conn->security_timer);
 	}
 
 	rcu_read_lock();
-- 
1.7.8.rc4

