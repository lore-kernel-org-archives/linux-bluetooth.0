Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 4/6] Bluetooth: Fix inconsistent lock state with RFCOMM
Date: Fri, 24 Sep 2010 22:01:42 -0300
Message-Id: <1285376504-3541-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1285376504-3541-4-git-send-email-gustavo@padovan.org>
References: <1285376504-3541-1-git-send-email-gustavo@padovan.org>
 <1285376504-3541-2-git-send-email-gustavo@padovan.org>
 <1285376504-3541-3-git-send-email-gustavo@padovan.org>
 <1285376504-3541-4-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

When receiving a rfcomm connection with the old dund deamon a
inconsistent lock state happens. That's because interrupts were already
disabled by l2cap_conn_start() when rfcomm_sk_state_change() try to lock
the spin_lock.

As result we may have a inconsistent lock state for l2cap_conn_start()
after rfcomm_sk_state_change() calls bh_lock_sock() and disable interrupts
as well.

[ 2833.151999]
[ 2833.151999] =================================
[ 2833.151999] [ INFO: inconsistent lock state ]
[ 2833.151999] 2.6.36-rc3 #2
[ 2833.151999] ---------------------------------
[ 2833.151999] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[ 2833.151999] krfcommd/2306 [HC0[0]:SC0[0]:HE1:SE1] takes:
[ 2833.151999]  (slock-AF_BLUETOOTH){+.?...}, at: [<ffffffffa00bcb56>] rfcomm_sk_state_change+0x46/0x170 [rfcomm]
[ 2833.151999] {IN-SOFTIRQ-W} state was registered at:
[ 2833.151999]   [<ffffffff81094346>] __lock_acquire+0x5b6/0x1560
[ 2833.151999]   [<ffffffff8109534a>] lock_acquire+0x5a/0x70
[ 2833.151999]   [<ffffffff81392b6c>] _raw_spin_lock+0x2c/0x40
[ 2833.151999]   [<ffffffffa00a5092>] l2cap_conn_start+0x92/0x640 [l2cap]
[ 2833.151999]   [<ffffffffa00a6a3f>] l2cap_sig_channel+0x6bf/0x1320 [l2cap]
[ 2833.151999]   [<ffffffffa00a9173>] l2cap_recv_frame+0x133/0x770 [l2cap]
[ 2833.151999]   [<ffffffffa00a997b>] l2cap_recv_acldata+0x1cb/0x390 [l2cap]
[ 2833.151999]   [<ffffffffa000db4b>] hci_rx_task+0x2ab/0x450 [bluetooth]
[ 2833.151999]   [<ffffffff8106b22b>] tasklet_action+0xcb/0xe0
[ 2833.151999]   [<ffffffff8106b91e>] __do_softirq+0xae/0x150
[ 2833.151999]   [<ffffffff8102bc0c>] call_softirq+0x1c/0x30
[ 2833.151999]   [<ffffffff8102ddb5>] do_softirq+0x75/0xb0
[ 2833.151999]   [<ffffffff8106b56d>] irq_exit+0x8d/0xa0
[ 2833.151999]   [<ffffffff8104484b>] smp_apic_timer_interrupt+0x6b/0xa0
[ 2833.151999]   [<ffffffff8102b6d3>] apic_timer_interrupt+0x13/0x20
[ 2833.151999]   [<ffffffff81029dfa>] cpu_idle+0x5a/0xb0
[ 2833.151999]   [<ffffffff81381ded>] rest_init+0xad/0xc0
[ 2833.151999]   [<ffffffff817ebc4d>] start_kernel+0x2dd/0x2e8
[ 2833.151999]   [<ffffffff817eb2e6>] x86_64_start_reservations+0xf6/0xfa
[ 2833.151999]   [<ffffffff817eb3ce>] x86_64_start_kernel+0xe4/0xeb
[ 2833.151999] irq event stamp: 731
[ 2833.151999] hardirqs last  enabled at (731): [<ffffffff8106b762>] local_bh_enable_ip+0x82/0xe0
[ 2833.151999] hardirqs last disabled at (729): [<ffffffff8106b93e>] __do_softirq+0xce/0x150
[ 2833.151999] softirqs last  enabled at (730): [<ffffffff8106b96e>] __do_softirq+0xfe/0x150
[ 2833.151999] softirqs last disabled at (711): [<ffffffff8102bc0c>] call_softirq+0x1c/0x30
[ 2833.151999]
[ 2833.151999] other info that might help us debug this:
[ 2833.151999] 2 locks held by krfcommd/2306:
[ 2833.151999]  #0:  (rfcomm_mutex){+.+.+.}, at: [<ffffffffa00bb744>] rfcomm_run+0x174/0xb20 [rfcomm]
[ 2833.151999]  #1:  (&(&d->lock)->rlock){+.+...}, at: [<ffffffffa00b9223>] rfcomm_dlc_accept+0x53/0x100 [rfcomm]
[ 2833.151999]
[ 2833.151999] stack backtrace:
[ 2833.151999] Pid: 2306, comm: krfcommd Tainted: G        W   2.6.36-rc3 #2
[ 2833.151999] Call Trace:
[ 2833.151999]  [<ffffffff810928e1>] print_usage_bug+0x171/0x180
[ 2833.151999]  [<ffffffff810936c3>] mark_lock+0x333/0x400
[ 2833.151999]  [<ffffffff810943ca>] __lock_acquire+0x63a/0x1560
[ 2833.151999]  [<ffffffff810948b5>] ? __lock_acquire+0xb25/0x1560
[ 2833.151999]  [<ffffffff8109534a>] lock_acquire+0x5a/0x70
[ 2833.151999]  [<ffffffffa00bcb56>] ? rfcomm_sk_state_change+0x46/0x170 [rfcomm]
[ 2833.151999]  [<ffffffff81392b6c>] _raw_spin_lock+0x2c/0x40
[ 2833.151999]  [<ffffffffa00bcb56>] ? rfcomm_sk_state_change+0x46/0x170 [rfcomm]
[ 2833.151999]  [<ffffffffa00bcb56>] rfcomm_sk_state_change+0x46/0x170 [rfcomm]
[ 2833.151999]  [<ffffffffa00b9239>] rfcomm_dlc_accept+0x69/0x100 [rfcomm]
[ 2833.151999]  [<ffffffffa00b9a49>] rfcomm_check_accept+0x59/0xd0 [rfcomm]
[ 2833.151999]  [<ffffffffa00bacab>] rfcomm_recv_frame+0x9fb/0x1320 [rfcomm]
[ 2833.151999]  [<ffffffff813932bb>] ? _raw_spin_unlock_irqrestore+0x3b/0x60
[ 2833.151999]  [<ffffffff81093acd>] ? trace_hardirqs_on_caller+0x13d/0x180
[ 2833.151999]  [<ffffffff81093b1d>] ? trace_hardirqs_on+0xd/0x10
[ 2833.151999]  [<ffffffffa00bb7f1>] rfcomm_run+0x221/0xb20 [rfcomm]
[ 2833.151999]  [<ffffffff813905e7>] ? schedule+0x287/0x780
[ 2833.151999]  [<ffffffffa00bb5d0>] ? rfcomm_run+0x0/0xb20 [rfcomm]
[ 2833.151999]  [<ffffffff81081026>] kthread+0x96/0xa0
[ 2833.151999]  [<ffffffff8102bb14>] kernel_thread_helper+0x4/0x10
[ 2833.151999]  [<ffffffff813936bc>] ? restore_args+0x0/0x30
[ 2833.151999]  [<ffffffff81080f90>] ? kthread+0x0/0xa0
[ 2833.151999]  [<ffffffff8102bb10>] ? kernel_thread_helper+0x0/0x10

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 44a6232..194b3a0 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -82,11 +82,14 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 {
 	struct sock *sk = d->owner, *parent;
+	unsigned long flags;
+
 	if (!sk)
 		return;
 
 	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
 
+	local_irq_save(flags);
 	bh_lock_sock(sk);
 
 	if (err)
@@ -108,6 +111,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	}
 
 	bh_unlock_sock(sk);
+	local_irq_restore(flags);
 
 	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
 		/* We have to drop DLC lock here, otherwise
-- 
1.7.2.2

