Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix inconsistent lock state with RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1281797213-10940-1-git-send-email-gustavo@padovan.org>
References: <1281797213-10940-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 14 Aug 2010 21:39:45 +0200
Message-ID: <1281814785.23399.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> When receiving a rfcomm connection with the old dund deamon the following
> inconsistent lock state happens:
> 
> [  811.702999] =================================
> [  811.702999] [ INFO: inconsistent lock state ]
> [  811.702999] 2.6.35-rc1-01743-g41069ad-dirty #1
> [  811.702999] ---------------------------------
> [  811.702999] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [  811.702999] krfcommd/3892 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [  811.702999]  (slock-AF_BLUETOOTH){+.?...}, at: [<ffffffffa0189b56>] rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [  811.702999] {IN-SOFTIRQ-W} state was registered at:
> [  811.702999]   [<ffffffff8108dfa6>] __lock_acquire+0x5b6/0x1560
> [  811.702999]   [<ffffffff8108efaa>] lock_acquire+0x5a/0x70
> [  811.702999]   [<ffffffff81387b2c>] _raw_spin_lock+0x2c/0x40
> [  811.702999]   [<ffffffffa0043092>] 0xffffffffa0043092
> [  811.702999]   [<ffffffffa0044a3f>] 0xffffffffa0044a3f
> [  811.702999]   [<ffffffffa0047183>] 0xffffffffa0047183
> [  811.702999]   [<ffffffffa004798b>] 0xffffffffa004798b
> [  811.702999]   [<ffffffffa000db4b>] 0xffffffffa000db4b
> [  811.702999]   [<ffffffff81067efb>] tasklet_action+0xcb/0xe0
> [  811.702999]   [<ffffffff810685ee>] __do_softirq+0xae/0x150
> [  811.702999]   [<ffffffff81029c0c>] call_softirq+0x1c/0x30
> [  811.702999]   [<ffffffff8102bd75>] do_softirq+0x75/0xb0
> [  811.702999]   [<ffffffff8106823d>] irq_exit+0x8d/0xa0
> [  811.702999]   [<ffffffff8102b330>] do_IRQ+0x70/0xf0
> [  811.702999]   [<ffffffff81388513>] ret_from_intr+0x0/0xf
> [  811.702999]   [<ffffffff81027dfa>] cpu_idle+0x5a/0xb0
> [  811.702999]   [<ffffffff81382934>] start_secondary+0x211/0x254
> [  811.702999] irq event stamp: 411
> [  811.702999] hardirqs last  enabled at (411): [<ffffffff81068432>] local_bh_enable_ip+0x82/0xe0
> [  811.702999] hardirqs last disabled at (409): [<ffffffff8106860e>] __do_softirq+0xce/0x150
> [  811.702999] softirqs last  enabled at (410): [<ffffffff8106863e>] __do_softirq+0xfe/0x150
> [  811.702999] softirqs last disabled at (391): [<ffffffff81029c0c>] call_softirq+0x1c/0x30
> [  811.702999]
> [  811.702999] other info that might help us debug this:
> [  811.702999] 2 locks held by krfcommd/3892:
> [  811.702999]  #0:  (rfcomm_mutex){+.+.+.}, at: [<ffffffffa0188744>] rfcomm_run+0x174/0xb20 [rfcomm]
> [  811.702999]  #1:  (&(&d->lock)->rlock){+.+...}, at: [<ffffffffa0186223>] rfcomm_dlc_accept+0x53/0x100 [rfcomm]
> [  811.702999]
> [  811.702999] stack backtrace:
> [  811.702999] Pid: 3892, comm: krfcommd Tainted: G        W   2.6.35-rc1-01743-g41069ad-dirty #1
> [  811.702999] Call Trace:
> [  811.702999]  [<ffffffff8108c541>] print_usage_bug+0x171/0x180
> [  811.702999]  [<ffffffff8108d323>] mark_lock+0x333/0x400
> [  811.702999]  [<ffffffff8108e02a>] __lock_acquire+0x63a/0x1560
> [  811.702999]  [<ffffffff8108e515>] ? __lock_acquire+0xb25/0x1560
> [  811.702999]  [<ffffffff8108efaa>] lock_acquire+0x5a/0x70
> [  811.702999]  [<ffffffffa0189b56>] ? rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [  811.702999]  [<ffffffff81387b2c>] _raw_spin_lock+0x2c/0x40
> [  811.702999]  [<ffffffffa0189b56>] ? rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [  811.702999]  [<ffffffffa0189b56>] rfcomm_sk_state_change+0x46/0x170 [rfcomm]
> [  811.702999]  [<ffffffffa0186239>] rfcomm_dlc_accept+0x69/0x100 [rfcomm]
> [  811.702999]  [<ffffffffa0186a49>] rfcomm_check_accept+0x59/0xd0 [rfcomm]
> [  811.702999]  [<ffffffffa0187cab>] rfcomm_recv_frame+0x9fb/0x1320 [rfcomm]
> [  811.702999]  [<ffffffff8138827b>] ? _raw_spin_unlock_irqrestore+0x3b/0x60
> [  811.702999]  [<ffffffff8108d72d>] ? trace_hardirqs_on_caller+0x13d/0x180
> [  811.702999]  [<ffffffff8108d77d>] ? trace_hardirqs_on+0xd/0x10
> [  811.702999]  [<ffffffffa01887f1>] rfcomm_run+0x221/0xb20 [rfcomm]
> [  811.702999]  [<ffffffff81385667>] ? schedule+0x267/0x5d0
> [  811.702999]  [<ffffffffa01885d0>] ? rfcomm_run+0x0/0xb20 [rfcomm]
> [  811.702999]  [<ffffffff8107afae>] kthread+0x8e/0xa0
> [  811.702999]  [<ffffffff81029b14>] kernel_thread_helper+0x4/0x10
> [  811.702999]  [<ffffffff813885bc>] ? restore_args+0x0/0x30
> [  811.702999]  [<ffffffff8107af20>] ? kthread+0x0/0xa0
> [  811.702999]  [<ffffffff81029b10>] ? kernel_thread_helper+0x0/0x10
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 44a6232..30cd80b 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -82,12 +82,14 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
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
> -	bh_lock_sock(sk);
> +	spin_lock_irqsave(&sk->sk_lock.slock, flags);
>  
>  	if (err)
>  		sk->sk_err = err;
> @@ -107,7 +109,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
>  		sk->sk_state_change(sk);
>  	}
>  
> -	bh_unlock_sock(sk);
> +	spin_unlock_irqrestore(&sk->sk_lock.slock, flags);
>  
>  	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
>  		/* We have to drop DLC lock here, otherwise

I am missing an explanation why you fixed it this way. And also why thi
sis the right way to fix it. Directly referencing sk->sk_lock seems
pretty much wrong to me.

Regards

Marcel


