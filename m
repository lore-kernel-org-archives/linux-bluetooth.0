Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Reduce critical section in sco_conn_ready
Date: Tue, 29 Jan 2013 19:59:56 -0300
Message-Id: <1359500396-8184-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
References: <1359500396-8184-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reduces the critical section protected by sco_conn_lock in
sco_conn_ready function. The lock is acquired only when it is really
needed.

This patch fixes the following lockdep warning which is generated
when the host terminates a SCO connection.

Today, this warning is a false positive. There is no way those
two threads reported by lockdep are running at the same time since
hdev->workqueue (where rx_work is queued) is single-thread. However,
if somehow this behavior is changed in future, we will have a
potential deadlock.

======================================================
[ INFO: possible circular locking dependency detected ]
3.8.0-rc1+ #7 Not tainted
-------------------------------------------------------
kworker/u:1H/1018 is trying to acquire lock:
 (&(&conn->lock)->rlock){+.+...}, at: [<ffffffffa0033ba6>] sco_chan_del+0x66/0x190 [bluetooth]

but task is already holding lock:
 (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}, at: [<ffffffffa0033d5a>] sco_conn_del+0x8a/0xe0 [bluetooth]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}:
       [<ffffffff81083011>] lock_acquire+0xb1/0xe0
       [<ffffffff813efd01>] _raw_spin_lock+0x41/0x80
       [<ffffffffa003436e>] sco_connect_cfm+0xbe/0x350 [bluetooth]
       [<ffffffffa0015d6c>] hci_event_packet+0xd3c/0x29b0 [bluetooth]
       [<ffffffffa0004583>] hci_rx_work+0x133/0x870 [bluetooth]
       [<ffffffff8104d65f>] process_one_work+0x2bf/0x4f0
       [<ffffffff81050022>] worker_thread+0x2b2/0x3e0
       [<ffffffff81056021>] kthread+0xd1/0xe0
       [<ffffffff813f14bc>] ret_from_fork+0x7c/0xb0

-> #0 (&(&conn->lock)->rlock){+.+...}:
       [<ffffffff81082215>] __lock_acquire+0x1465/0x1c70
       [<ffffffff81083011>] lock_acquire+0xb1/0xe0
       [<ffffffff813efd01>] _raw_spin_lock+0x41/0x80
       [<ffffffffa0033ba6>] sco_chan_del+0x66/0x190 [bluetooth]
       [<ffffffffa0033d6d>] sco_conn_del+0x9d/0xe0 [bluetooth]
       [<ffffffffa0034653>] sco_disconn_cfm+0x53/0x60 [bluetooth]
       [<ffffffffa000fef3>] hci_disconn_complete_evt.isra.54+0x363/0x3c0 [bluetooth]
       [<ffffffffa00150f7>] hci_event_packet+0xc7/0x29b0 [bluetooth]
       [<ffffffffa0004583>] hci_rx_work+0x133/0x870 [bluetooth]
       [<ffffffff8104d65f>] process_one_work+0x2bf/0x4f0
       [<ffffffff81050022>] worker_thread+0x2b2/0x3e0
       [<ffffffff81056021>] kthread+0xd1/0xe0
       [<ffffffff813f14bc>] ret_from_fork+0x7c/0xb0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(slock-AF_BLUETOOTH-BTPROTO_SCO);
                               lock(&(&conn->lock)->rlock);
                               lock(slock-AF_BLUETOOTH-BTPROTO_SCO);
  lock(&(&conn->lock)->rlock);

 *** DEADLOCK ***

4 locks held by kworker/u:1H/1018:
 #0:  (hdev->name#2){.+.+.+}, at: [<ffffffff8104d5f8>] process_one_work+0x258/0x4f0
 #1:  ((&hdev->rx_work)){+.+.+.}, at: [<ffffffff8104d5f8>] process_one_work+0x258/0x4f0
 #2:  (&hdev->lock){+.+.+.}, at: [<ffffffffa000fbe9>] hci_disconn_complete_evt.isra.54+0x59/0x3c0 [bluetooth]
 #3:  (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}, at: [<ffffffffa0033d5a>] sco_conn_del+0x8a/0xe0 [bluetooth]

stack backtrace:
Pid: 1018, comm: kworker/u:1H Not tainted 3.8.0-rc1+ #7
Call Trace:
 [<ffffffff813e92f9>] print_circular_bug+0x1fb/0x20c
 [<ffffffff81082215>] __lock_acquire+0x1465/0x1c70
 [<ffffffff81083011>] lock_acquire+0xb1/0xe0
 [<ffffffffa0033ba6>] ? sco_chan_del+0x66/0x190 [bluetooth]
 [<ffffffff813efd01>] _raw_spin_lock+0x41/0x80
 [<ffffffffa0033ba6>] ? sco_chan_del+0x66/0x190 [bluetooth]
 [<ffffffffa0033ba6>] sco_chan_del+0x66/0x190 [bluetooth]
 [<ffffffffa0033d6d>] sco_conn_del+0x9d/0xe0 [bluetooth]
 [<ffffffffa0034653>] sco_disconn_cfm+0x53/0x60 [bluetooth]
 [<ffffffffa000fef3>] hci_disconn_complete_evt.isra.54+0x363/0x3c0 [bluetooth]
 [<ffffffffa000fbd0>] ? hci_disconn_complete_evt.isra.54+0x40/0x3c0 [bluetooth]
 [<ffffffffa00150f7>] hci_event_packet+0xc7/0x29b0 [bluetooth]
 [<ffffffff81202e90>] ? __dynamic_pr_debug+0x80/0x90
 [<ffffffff8133ff7d>] ? kfree_skb+0x2d/0x40
 [<ffffffffa0021644>] ? hci_send_to_monitor+0x1a4/0x1c0 [bluetooth]
 [<ffffffffa0004583>] hci_rx_work+0x133/0x870 [bluetooth]
 [<ffffffff8104d5f8>] ? process_one_work+0x258/0x4f0
 [<ffffffff8104d65f>] process_one_work+0x2bf/0x4f0
 [<ffffffff8104d5f8>] ? process_one_work+0x258/0x4f0
 [<ffffffff8104fdc1>] ? worker_thread+0x51/0x3e0
 [<ffffffffa0004450>] ? hci_tx_work+0x800/0x800 [bluetooth]
 [<ffffffff81050022>] worker_thread+0x2b2/0x3e0
 [<ffffffff8104fd70>] ? busy_worker_rebind_fn+0x100/0x100
 [<ffffffff81056021>] kthread+0xd1/0xe0
 [<ffffffff81055f50>] ? flush_kthread_worker+0xc0/0xc0
 [<ffffffff813f14bc>] ret_from_fork+0x7c/0xb0
 [<ffffffff81055f50>] ? flush_kthread_worker+0xc0/0xc0

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---

This lockdep warning has been around for a long time. I could test
until Linux 3.4, but it seems it is older than that. However, in
current bluetooth-next, this warning has been masked by commit
53502d69be49e3dd5bc95ab0f2deeaea260bd617 which introduced a bug in
SCO socket shutdown routine.

The bug in SCO socket shutdown routine has been fixed by patch 02/05
from this patchset.

 net/bluetooth/sco.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 531a93d..e435641 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -900,8 +900,6 @@ static void sco_conn_ready(struct sco_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
-	sco_conn_lock(conn);
-
 	if (sk) {
 		sco_sock_clear_timer(sk);
 		bh_lock_sock(sk);
@@ -909,9 +907,13 @@ static void sco_conn_ready(struct sco_conn *conn)
 		sk->sk_state_change(sk);
 		bh_unlock_sock(sk);
 	} else {
+		sco_conn_lock(conn);
+
 		parent = sco_get_sock_listen(conn->src);
-		if (!parent)
-			goto done;
+		if (!parent) {
+			sco_conn_unlock(conn);
+			return;
+		}
 
 		bh_lock_sock(parent);
 
@@ -919,7 +921,8 @@ static void sco_conn_ready(struct sco_conn *conn)
 				    BTPROTO_SCO, GFP_ATOMIC);
 		if (!sk) {
 			bh_unlock_sock(parent);
-			goto done;
+			sco_conn_unlock(conn);
+			return;
 		}
 
 		sco_sock_init(sk, parent);
@@ -939,10 +942,9 @@ static void sco_conn_ready(struct sco_conn *conn)
 		parent->sk_data_ready(parent, 1);
 
 		bh_unlock_sock(parent);
-	}
 
-done:
-	sco_conn_unlock(conn);
+		sco_conn_unlock(conn);
+	}
 }
 
 /* ----- SCO interface with lower layer (HCI) ----- */
-- 
1.8.1.1

