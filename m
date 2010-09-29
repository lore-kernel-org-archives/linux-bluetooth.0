Return-Path: <cyrus@holtmann.org>
Message-ID: <4CA2EDA1.9050201@nokia.com>
Date: Wed, 29 Sep 2010 11:41:21 +0400
From: Yuri Kululin <ext-yuri.kululin@nokia.com>
MIME-Version: 1.0
To: "ext Gustavo F. Padovan" <gustavo@padovan.org>
CC: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH 4/6] Bluetooth: Fix inconsistent lock state with RFCOMM
References: <1285376504-3541-1-git-send-email-gustavo@padovan.org> <1285376504-3541-2-git-send-email-gustavo@padovan.org> <1285376504-3541-3-git-send-email-gustavo@padovan.org> <1285376504-3541-4-git-send-email-gustavo@padovan.org> <1285376504-3541-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1285376504-3541-5-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ext Gustavo F. Padovan wrote:
> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> When receiving a rfcomm connection with the old dund deamon a
> inconsistent lock state happens. That's because interrupts were already
> disabled by l2cap_conn_start() when rfcomm_sk_state_change() try to lock
> the spin_lock.
> 
> As result we may have a inconsistent lock state for l2cap_conn_start()
> after rfcomm_sk_state_change() calls bh_lock_sock() and disable interrupts
> as well.
> 
> [ 2833.151999]
> [ 2833.151999] =================================
> [ 2833.151999] [ INFO: inconsistent lock state ]
> [ 2833.151999] 2.6.36-rc3 #2
> [ 2833.151999] ---------------------------------
> [ 2833.151999] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [ 2833.151999] krfcommd/2306 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [ 2833.151999]  (slock-AF_BLUETOOTH){+.?...}, at: [<ffffffffa00bcb56>] rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [ 2833.151999] {IN-SOFTIRQ-W} state was registered at:
> [ 2833.151999]   [<ffffffff81094346>] __lock_acquire+0x5b6/0x1560
> [ 2833.151999]   [<ffffffff8109534a>] lock_acquire+0x5a/0x70
> [ 2833.151999]   [<ffffffff81392b6c>] _raw_spin_lock+0x2c/0x40
> [ 2833.151999]   [<ffffffffa00a5092>] l2cap_conn_start+0x92/0x640 [l2cap]
> [ 2833.151999]   [<ffffffffa00a6a3f>] l2cap_sig_channel+0x6bf/0x1320 [l2cap]
> [ 2833.151999]   [<ffffffffa00a9173>] l2cap_recv_frame+0x133/0x770 [l2cap]
> [ 2833.151999]   [<ffffffffa00a997b>] l2cap_recv_acldata+0x1cb/0x390 [l2cap]
> [ 2833.151999]   [<ffffffffa000db4b>] hci_rx_task+0x2ab/0x450 [bluetooth]
> [ 2833.151999]   [<ffffffff8106b22b>] tasklet_action+0xcb/0xe0
> [ 2833.151999]   [<ffffffff8106b91e>] __do_softirq+0xae/0x150
> [ 2833.151999]   [<ffffffff8102bc0c>] call_softirq+0x1c/0x30
> [ 2833.151999]   [<ffffffff8102ddb5>] do_softirq+0x75/0xb0
> [ 2833.151999]   [<ffffffff8106b56d>] irq_exit+0x8d/0xa0
> [ 2833.151999]   [<ffffffff8104484b>] smp_apic_timer_interrupt+0x6b/0xa0
> [ 2833.151999]   [<ffffffff8102b6d3>] apic_timer_interrupt+0x13/0x20
> [ 2833.151999]   [<ffffffff81029dfa>] cpu_idle+0x5a/0xb0
> [ 2833.151999]   [<ffffffff81381ded>] rest_init+0xad/0xc0
> [ 2833.151999]   [<ffffffff817ebc4d>] start_kernel+0x2dd/0x2e8
> [ 2833.151999]   [<ffffffff817eb2e6>] x86_64_start_reservations+0xf6/0xfa
> [ 2833.151999]   [<ffffffff817eb3ce>] x86_64_start_kernel+0xe4/0xeb
> [ 2833.151999] irq event stamp: 731
> [ 2833.151999] hardirqs last  enabled at (731): [<ffffffff8106b762>] local_bh_enable_ip+0x82/0xe0
> [ 2833.151999] hardirqs last disabled at (729): [<ffffffff8106b93e>] __do_softirq+0xce/0x150
> [ 2833.151999] softirqs last  enabled at (730): [<ffffffff8106b96e>] __do_softirq+0xfe/0x150
> [ 2833.151999] softirqs last disabled at (711): [<ffffffff8102bc0c>] call_softirq+0x1c/0x30
> [ 2833.151999]
> [ 2833.151999] other info that might help us debug this:
> [ 2833.151999] 2 locks held by krfcommd/2306:
> [ 2833.151999]  #0:  (rfcomm_mutex){+.+.+.}, at: [<ffffffffa00bb744>] rfcomm_run+0x174/0xb20 [rfcomm]
> [ 2833.151999]  #1:  (&(&d->lock)->rlock){+.+...}, at: [<ffffffffa00b9223>] rfcomm_dlc_accept+0x53/0x100 [rfcomm]
> [ 2833.151999]
> [ 2833.151999] stack backtrace:
> [ 2833.151999] Pid: 2306, comm: krfcommd Tainted: G        W   2.6.36-rc3 #2
> [ 2833.151999] Call Trace:
> [ 2833.151999]  [<ffffffff810928e1>] print_usage_bug+0x171/0x180
> [ 2833.151999]  [<ffffffff810936c3>] mark_lock+0x333/0x400
> [ 2833.151999]  [<ffffffff810943ca>] __lock_acquire+0x63a/0x1560
> [ 2833.151999]  [<ffffffff810948b5>] ? __lock_acquire+0xb25/0x1560
> [ 2833.151999]  [<ffffffff8109534a>] lock_acquire+0x5a/0x70
> [ 2833.151999]  [<ffffffffa00bcb56>] ? rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [ 2833.151999]  [<ffffffff81392b6c>] _raw_spin_lock+0x2c/0x40
> [ 2833.151999]  [<ffffffffa00bcb56>] ? rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [ 2833.151999]  [<ffffffffa00bcb56>] rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [ 2833.151999]  [<ffffffffa00b9239>] rfcomm_dlc_accept+0x69/0x100 [rfcomm]
> [ 2833.151999]  [<ffffffffa00b9a49>] rfcomm_check_accept+0x59/0xd0 [rfcomm]
> [ 2833.151999]  [<ffffffffa00bacab>] rfcomm_recv_frame+0x9fb/0x1320 [rfcomm]
> [ 2833.151999]  [<ffffffff813932bb>] ? _raw_spin_unlock_irqrestore+0x3b/0x60
> [ 2833.151999]  [<ffffffff81093acd>] ? trace_hardirqs_on_caller+0x13d/0x180
> [ 2833.151999]  [<ffffffff81093b1d>] ? trace_hardirqs_on+0xd/0x10
> [ 2833.151999]  [<ffffffffa00bb7f1>] rfcomm_run+0x221/0xb20 [rfcomm]
> [ 2833.151999]  [<ffffffff813905e7>] ? schedule+0x287/0x780
> [ 2833.151999]  [<ffffffffa00bb5d0>] ? rfcomm_run+0x0/0xb20 [rfcomm]
> [ 2833.151999]  [<ffffffff81081026>] kthread+0x96/0xa0
> [ 2833.151999]  [<ffffffff8102bb14>] kernel_thread_helper+0x4/0x10
> [ 2833.151999]  [<ffffffff813936bc>] ? restore_args+0x0/0x30
> [ 2833.151999]  [<ffffffff81080f90>] ? kthread+0x0/0xa0
> [ 2833.151999]  [<ffffffff8102bb10>] ? kernel_thread_helper+0x0/0x10
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 44a6232..194b3a0 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -82,11 +82,14 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
>  static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
>  {
>  	struct sock *sk = d->owner, *parent;
> +	unsigned long flags;
> +
>  	if (!sk)
>  		return;
>  
>  	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
>  
> +	local_irq_save(flags);
>  	bh_lock_sock(sk);
>  
>  	if (err)
> @@ -108,6 +111,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
>  	}
>  
>  	bh_unlock_sock(sk);
> +	local_irq_restore(flags);
>  
>  	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
>  		/* We have to drop DLC lock here, otherwise

I've faced with the similar warning and looks like this patch fixes the issue.

[ 2917.827178] =================================
[ 2917.833068] [ INFO: inconsistent lock state ]
[ 2917.837432] 2.6.32-09421-g65e7ba7 #54
[ 2917.841125] ---------------------------------
[ 2917.845520] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[ 2917.851562] krfcommd/1516 [HC0[0]:SC0[0]:HE1:SE1] takes:
[ 2917.856903]  (slock-AF_BLUETOOTH){+.?...}, at: [<bf057b50>]
rfcomm_sk_state_change+0x78/0x160 [rfcomm]
[ 2917.866363] {IN-SOFTIRQ-W} state was registered at:
[ 2917.871276]   [<c008d33c>] mark_lock+0x298/0x630
[ 2917.875946]   [<c008ed3c>] __lock_acquire+0x5f4/0x175c
[ 2917.881134]   [<c008ff0c>] lock_acquire+0x68/0x7c
[ 2917.885864]   [<c036938c>] _spin_lock+0x48/0x58
[ 2917.890441]   [<bf025960>] l2cap_conn_start+0x80/0x388 [l2cap]
[ 2917.896362]   [<bf028f44>] l2cap_recv_frame+0x1c58/0x2fe0 [l2cap]
[ 2917.902526]   [<bf02a3cc>] l2cap_recv_acldata+0x100/0x350 [l2cap]
[ 2917.908691]   [<bf0035a8>] hci_rx_task+0x244/0x478 [bluetooth]
[ 2917.914642]   [<c006c4d0>] tasklet_action+0x78/0xd8
[ 2917.919555]   [<c006cc34>] __do_softirq+0xa8/0x154
[ 2917.924407]   [<c006cd40>] irq_exit+0x60/0xb4
[ 2917.928802]   [<c0030078>] asm_do_IRQ+0x78/0x90
[ 2917.933380]   [<c0030af0>] __irq_svc+0x50/0xbc
[ 2917.937866]   [<c0043c74>] omap3_enter_idle_bm+0x1d0/0x238
[ 2917.943389]   [<c029ee94>] cpuidle_idle_call+0xb4/0x114
[ 2917.948669]   [<c00320b0>] cpu_idle+0x58/0xac
[ 2917.953063]   [<c0360b18>] rest_init+0x70/0x84
[ 2917.957550]   [<c00089fc>] start_kernel+0x2b4/0x318
[ 2917.962493]   [<80008034>] 0x80008034
[ 2917.966186] irq event stamp: 312
[ 2917.969421] hardirqs last  enabled at (312): [<c03691ac>]
_spin_unlock_irqrestore+0x44/0x70
[ 2917.977844] hardirqs last disabled at (311): [<c036947c>]
_spin_lock_irqsave+0x24/0x68
[ 2917.985809] softirqs last  enabled at (261): [<c006ccc8>]
__do_softirq+0x13c/0x154
[ 2917.993438] softirqs last disabled at (244): [<c006cde8>]
do_softirq+0x54/0x78
[ 2918.000732]
[ 2918.000732] other info that might help us debug this:
[ 2918.007293] 2 locks held by krfcommd/1516:
[ 2918.011413]  #0:  (rfcomm_mutex){+.+.+.}, at: [<bf054df4>]
rfcomm_run+0x1f0/0xb00 [rfcomm]
[ 2918.019805]  #1:  (&d->lock){+.+...}, at: [<bf055220>]
rfcomm_run+0x61c/0xb00 [rfcomm]
[ 2918.027832]
[ 2918.027832] stack backtrace:
[ 2918.032226] Backtrace:
[ 2918.034729] [<c00348d0>] (dump_backtrace+0x0/0x110) from [<c036616c>]
(dump_stack+0x18/0x1c)
[ 2918.043212]  r7:dc8f6c00 r6:c0425252 r5:00000001 r4:00000001
[ 2918.048950] [<c0366154>] (dump_stack+0x0/0x1c) from [<c008d060>]
(print_usage_bug+0x178/0x1bc)
[ 2918.057617] [<c008cee8>] (print_usage_bug+0x0/0x1bc) from [<c008d408>]
(mark_lock+0x364/0x630)
[ 2918.066284] [<c008d0a4>] (mark_lock+0x0/0x630) from [<c008edcc>]
(__lock_acquire+0x684/0x175c)
[ 2918.074951] [<c008e748>] (__lock_acquire+0x0/0x175c) from [<c008ff0c>]
(lock_acquire+0x68/0x7c)
[ 2918.083709] [<c008fea4>] (lock_acquire+0x0/0x7c) from [<c036938c>]
(_spin_lock+0x48/0x58)
[ 2918.091949]  r7:dba9402c r6:dba5c3c0 r5:dba9402c r4:bf057b50
[ 2918.097717] [<c0369344>] (_spin_lock+0x0/0x58) from [<bf057b50>]
(rfcomm_sk_state_change+0x78/0x160 [rfcomm])
[ 2918.107696]  r5:dba94000 r4:00000000
[ 2918.111358] [<bf057ad8>] (rfcomm_sk_state_change+0x0/0x160 [rfcomm]) from
[<bf055238>] (rfcomm_run+0x634/0xb00 [rfcomm])
[ 2918.122283]  r7:dba5c450 r6:dba5d6c0 r5:dba5c3c0 r4:dba5c430
[ 2918.128051] [<bf054c04>] (rfcomm_run+0x0/0xb00 [rfcomm]) from [<c007cc10>]
(kthread+0x88/0x90)
[ 2918.136749] [<c007cb88>] (kthread+0x0/0x90) from [<c006a86c>]
(do_exit+0x0/0x678)
[ 2918.144256]  r7:00000000 r6:00000000 r5:00000000 r4:00000000

Thanks,
Yuri K.
