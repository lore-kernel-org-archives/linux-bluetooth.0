Return-Path: <cyrus@holtmann.org>
From: Ulisses Furquim <ulisses@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: [PATCH] Bluetooth: Fix deadlocks with sock lock and L2CAP timers locks
Date: Wed, 21 Dec 2011 20:02:36 -0200
Message-Id: <1324504956-16840-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When cancelling a delayed work (timer) in L2CAP we can not sleep holding
the sock mutex otherwise we might deadlock with an L2CAP timer handler.
This is possible because RX/TX and L2CAP timers run in different workqueues.
The scenario below illustrates the problem. Thus we are now avoiding to
sleep on the timers locks.

 ======================================================
 [ INFO: possible circular locking dependency detected ]
 3.1.0-05270-ga978dc7-dirty #239
 -------------------------------------------------------
 kworker/1:1/873 is trying to acquire lock:
  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}, at: [<ffffffffa002ceac>] l2cap_chan_timeout+0x3c/0xe0 [bluetooth]

 but task is already holding lock:
  ((&(&chan->chan_timer)->work)){+.+...}, at: [<ffffffff81051a86>] process_one_work+0x126/0x450

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 ((&(&chan->chan_timer)->work)){+.+...}:
        [<ffffffff8106b276>] check_prevs_add+0xf6/0x170
        [<ffffffff8106b903>] validate_chain+0x613/0x790
        [<ffffffff8106dfee>] __lock_acquire+0x4be/0xac0
        [<ffffffff8106ec2d>] lock_acquire+0x8d/0xb0
        [<ffffffff81052a6f>] wait_on_work+0x4f/0x160
        [<ffffffff81052ca3>] __cancel_work_timer+0x73/0x80
        [<ffffffff81052cbd>] cancel_delayed_work_sync+0xd/0x10
        [<ffffffffa002f2ed>] l2cap_chan_connect+0x22d/0x470 [bluetooth]
        [<ffffffffa002fb51>] l2cap_sock_connect+0xb1/0x140 [bluetooth]
        [<ffffffff8130811b>] kernel_connect+0xb/0x10
        [<ffffffffa00cf98a>] rfcomm_session_create+0x12a/0x1c0 [rfcomm]
        [<ffffffffa00cfbe7>] __rfcomm_dlc_open+0x1c7/0x240 [rfcomm]
        [<ffffffffa00d07c2>] rfcomm_dlc_open+0x42/0x70 [rfcomm]
        [<ffffffffa00d3b03>] rfcomm_sock_connect+0x103/0x150 [rfcomm]
        [<ffffffff8130bd7e>] sys_connect+0xae/0xc0
        [<ffffffff813368d2>] compat_sys_socketcall+0xb2/0x220
        [<ffffffff813b2089>] sysenter_dispatch+0x7/0x30

 -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+...}:
        [<ffffffff8106b16d>] check_prev_add+0x6cd/0x6e0
        [<ffffffff8106b276>] check_prevs_add+0xf6/0x170
        [<ffffffff8106b903>] validate_chain+0x613/0x790
        [<ffffffff8106dfee>] __lock_acquire+0x4be/0xac0
        [<ffffffff8106ec2d>] lock_acquire+0x8d/0xb0
        [<ffffffff8130d91a>] lock_sock_nested+0x8a/0xa0
        [<ffffffffa002ceac>] l2cap_chan_timeout+0x3c/0xe0 [bluetooth]
        [<ffffffff81051ae4>] process_one_work+0x184/0x450
        [<ffffffff8105276e>] worker_thread+0x15e/0x340
        [<ffffffff81057bb6>] kthread+0x96/0xa0
        [<ffffffff813b1ef4>] kernel_thread_helper+0x4/0x10

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((&(&chan->chan_timer)->work));
                                lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
                                lock((&(&chan->chan_timer)->work));
   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);

  *** DEADLOCK ***

 2 locks held by kworker/1:1/873:
  #0:  (events){.+.+.+}, at: [<ffffffff81051a86>] process_one_work+0x126/0x450
  #1:  ((&(&chan->chan_timer)->work)){+.+...}, at: [<ffffffff81051a86>] process_one_work+0x126/0x450

 stack backtrace:
 Pid: 873, comm: kworker/1:1 Not tainted 3.1.0-05270-ga978dc7-dirty #239
 Call Trace:
  [<ffffffff813a0f6e>] print_circular_bug+0xd2/0xe3
  [<ffffffff8106b16d>] check_prev_add+0x6cd/0x6e0
  [<ffffffff8106b276>] check_prevs_add+0xf6/0x170
  [<ffffffff8106b903>] validate_chain+0x613/0x790
  [<ffffffff8106dfee>] __lock_acquire+0x4be/0xac0
  [<ffffffff8130d8f6>] ? lock_sock_nested+0x66/0xa0
  [<ffffffff8106ea30>] ? lock_release_nested+0x100/0x110
  [<ffffffff8130d8f6>] ? lock_sock_nested+0x66/0xa0
  [<ffffffff8106ec2d>] lock_acquire+0x8d/0xb0
  [<ffffffffa002ceac>] ? l2cap_chan_timeout+0x3c/0xe0 [bluetooth]
  [<ffffffff8130d91a>] lock_sock_nested+0x8a/0xa0
  [<ffffffffa002ceac>] ? l2cap_chan_timeout+0x3c/0xe0 [bluetooth]
  [<ffffffff81051a86>] ? process_one_work+0x126/0x450
  [<ffffffffa002ceac>] l2cap_chan_timeout+0x3c/0xe0 [bluetooth]
  [<ffffffff81051ae4>] process_one_work+0x184/0x450
  [<ffffffff81051a86>] ? process_one_work+0x126/0x450
  [<ffffffffa002ce70>] ? l2cap_security_cfm+0x4e0/0x4e0 [bluetooth]
  [<ffffffff8105276e>] worker_thread+0x15e/0x340
  [<ffffffff81052610>] ? manage_workers+0x110/0x110
  [<ffffffff81057bb6>] kthread+0x96/0xa0
  [<ffffffff813b1ef4>] kernel_thread_helper+0x4/0x10
  [<ffffffff813af69d>] ? retint_restore_args+0xe/0xe
  [<ffffffff81057b20>] ? __init_kthread_worker+0x70/0x70
  [<ffffffff813b1ef0>] ? gs_change+0xb/0xb

Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   29 +++++++++++++++++++++--------
 net/bluetooth/l2cap_core.c    |   29 +++++++++--------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f141fbe..9572cbd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -595,32 +595,45 @@ enum {
 	FLAG_EFS_ENABLE,
 };
 
+static inline void l2cap_chan_hold(struct l2cap_chan *c)
+{
+	atomic_inc(&c->refcnt);
+}
+
+static inline void l2cap_chan_put(struct l2cap_chan *c)
+{
+	if (atomic_dec_and_test(&c->refcnt))
+		kfree(c);
+}
+
 static inline void l2cap_set_timer(struct l2cap_chan *chan,
 					struct delayed_work *work, long timeout)
 {
 	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
 
-	cancel_delayed_work_sync(work);
-
+	if (!__cancel_delayed_work(work))
+		l2cap_chan_hold(chan);
 	schedule_delayed_work(work, timeout);
 }
 
-static inline void l2cap_clear_timer(struct delayed_work *work)
+static inline void l2cap_clear_timer(struct l2cap_chan *chan,
+					struct delayed_work *work)
 {
-	cancel_delayed_work_sync(work);
+	if (__cancel_delayed_work(work))
+		l2cap_chan_put(chan);
 }
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
-#define __clear_chan_timer(c) l2cap_clear_timer(&c->chan_timer)
+#define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
 		L2CAP_DEFAULT_RETRANS_TO);
-#define __clear_retrans_timer(c) l2cap_clear_timer(&c->retrans_timer)
+#define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
 #define __set_monitor_timer(c) l2cap_set_timer(c, &c->monitor_timer, \
 		L2CAP_DEFAULT_MONITOR_TO);
-#define __clear_monitor_timer(c) l2cap_clear_timer(&c->monitor_timer)
+#define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
 #define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
 		L2CAP_DEFAULT_ACK_TO);
-#define __clear_ack_timer(c) l2cap_clear_timer(&c->ack_timer)
+#define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
 
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1732183..944c189 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -77,17 +77,6 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* ---- L2CAP channels ---- */
 
-static inline void chan_hold(struct l2cap_chan *c)
-{
-	atomic_inc(&c->refcnt);
-}
-
-static inline void chan_put(struct l2cap_chan *c)
-{
-	if (atomic_dec_and_test(&c->refcnt))
-		kfree(c);
-}
-
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
 {
 	struct l2cap_chan *c, *r = NULL;
@@ -287,7 +276,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	release_sock(sk);
 
 	chan->ops->close(chan->data);
-	chan_put(chan);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(struct sock *sk)
@@ -321,7 +310,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	list_del(&chan->global_l);
 	write_unlock_bh(&chan_list_lock);
 
-	chan_put(chan);
+	l2cap_chan_put(chan);
 }
 
 static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
@@ -363,7 +352,7 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	chan->local_acc_lat	= L2CAP_DEFAULT_ACC_LAT;
 	chan->local_flush_to	= L2CAP_DEFAULT_FLUSH_TO;
 
-	chan_hold(chan);
+	l2cap_chan_hold(chan);
 
 	list_add_rcu(&chan->list, &conn->chan_l);
 }
@@ -385,7 +374,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		list_del_rcu(&chan->list);
 		synchronize_rcu();
 
-		chan_put(chan);
+		l2cap_chan_put(chan);
 
 		chan->conn = NULL;
 		hci_conn_put(conn->hcon);
@@ -1029,10 +1018,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		cancel_delayed_work_sync(&conn->info_timer);
+		__cancel_delayed_work(&conn->info_timer);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
-		cancel_delayed_work_sync(&conn->security_timer);
+		__cancel_delayed_work(&conn->security_timer);
 		smp_chan_destroy(conn);
 	}
 
@@ -2583,7 +2572,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	if ((conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) &&
 					cmd->ident == conn->info_ident) {
-		cancel_delayed_work_sync(&conn->info_timer);
+		__cancel_delayed_work(&conn->info_timer);
 
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
@@ -3129,7 +3118,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
 		return 0;
 
-	cancel_delayed_work_sync(&conn->info_timer);
+	__cancel_delayed_work(&conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
@@ -4508,7 +4497,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	if (hcon->type == LE_LINK) {
 		smp_distribute_keys(conn, 0);
-		cancel_delayed_work_sync(&conn->security_timer);
+		__cancel_delayed_work(&conn->security_timer);
 	}
 
 	rcu_read_lock();
-- 
1.7.8.rc4

