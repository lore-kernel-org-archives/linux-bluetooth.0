Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: [PATCH 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
Date: Wed, 18 Jan 2012 10:48:03 -0200
Message-Id: <1326890884-16678-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

__cancel_delayed_work() is being used in some paths where we cannot
sleep waiting for the delayed work to finish. However, that function
might return while the timer is running and the work will be queued
again. Replace the calls with safer cancel_delayed_work() version
which spins until the timer handler finishes in other CPUs and
cancels the delayed work.

Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    4 ++--
 net/bluetooth/l2cap_core.c    |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 18242ea..dd2dbe8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -611,7 +611,7 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
 {
 	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
 
-	if (!__cancel_delayed_work(work))
+	if (!cancel_delayed_work(work))
 		l2cap_chan_hold(chan);
 	schedule_delayed_work(work, timeout);
 }
@@ -621,7 +621,7 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 {
 	bool ret;
 
-	ret = __cancel_delayed_work(work);
+	ret = cancel_delayed_work(work);
 	if (ret)
 		l2cap_chan_put(chan);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0087db8..6ee7a2d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1018,10 +1018,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		__cancel_delayed_work(&conn->info_timer);
+		cancel_delayed_work(&conn->info_timer);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
-		__cancel_delayed_work(&conn->security_timer);
+		cancel_delayed_work(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 
@@ -2583,7 +2583,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
 					cmd->ident == conn->info_ident) {
-		__cancel_delayed_work(&conn->info_timer);
+		cancel_delayed_work(&conn->info_timer);
 
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -3130,7 +3130,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
 		return 0;
 
-	__cancel_delayed_work(&conn->info_timer);
+	cancel_delayed_work(&conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
@@ -4504,7 +4504,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	if (hcon->type == LE_LINK) {
 		smp_distribute_keys(conn, 0);
-		__cancel_delayed_work(&conn->security_timer);
+		cancel_delayed_work(&conn->security_timer);
 	}
 
 	rcu_read_lock();
-- 
1.7.8.rc4

