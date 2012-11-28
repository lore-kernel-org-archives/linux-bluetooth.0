Return-Path: <cyrus@holtmann.org>
Message-id: <50B62135.7080507@gmail.com>
Date: Wed, 28 Nov 2012 23:35:33 +0900
From: Chan-yeol Park <chanyeol.park@gmail.com>
MIME-version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix possible deadlock in SCO code
References: <1339738863-6407-1-git-send-email-gustavo@padovan.org>
In-reply-to: <1339738863-6407-1-git-send-email-gustavo@padovan.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

If we use the below patch, we face crash or circular locking dependency 
detected.
*It's very easily reproduced(about 100%)

I guess once sco_sock_shutdown() is called,"sk" would be destructed.
but due to response from remote side, sco_disconn_cfm(),sco_conn_del() 
would be called in order.
and finally in sco_conn_del() crash or circular locking dependency is 
happened.
because it access "sk" that is already destructed.

I think in sco_chan_del(), based on conn info, the relation between sk 
and conn should be cleaned
like the original code before you commit.

[  104.889622] Bluetooth: [sco_sock_shutdown] sock e8856000, sk eb695000
[  104.894666] Bluetooth: [sco_sock_clear_timer] sock eb695000 state 1
[  104.900869] Bluetooth: [__sco_sock_close] sk eb695000 state 1 socket 
e8856000
[  104.907976] Bluetooth: [sco_sock_set_timer] sock eb695000 state 8 
timeout 400
[  104.915106] Bluetooth: [sco_sock_release] sock e8856000, sk eb695000
[  104.921439] Bluetooth: [sco_sock_clear_timer] sock eb695000 state 8
[  104.927875] Bluetooth: [__sco_sock_close] sk eb695000 state 8 socket 
e8856000
[  104.938762] Bluetooth: [sco_chan_del] sk eb695000, conn ed38da60, err 104
[  104.956861] Bluetooth: [sco_sock_kill] sk eb695000 state 9
[  104.962321] Bluetooth: [sco_sock_destruct] sk eb695000
[  105.071125] Bluetooth: [sco_disconn_cfm] hcon ed376000 reason 22
[  105.075875] Bluetooth: [sco_conn_del] hcon ed376000 conn ed38da60, 
err 103
[  105.082848] Bluetooth: [sco_conn_del] before bh_lock_sock () sk eb695000

Could you give me your opinion?

regards
chanyeol

On 06/15/2012 02:41 PM, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> sco_chan_del() only has conn != NULL when called from sco_conn_del() so
> just move the code from it that deal with conn to sco_conn_del().
>
> [  120.765529]
> [  120.765529] ======================================================
> [  120.766529] [ INFO: possible circular locking dependency detected ]
> [  120.766529] 3.5.0-rc1-10292-g3701f94-dirty #70 Tainted: G        W
> [  120.766529] -------------------------------------------------------
> [  120.766529] kworker/u:3/1497 is trying to acquire lock:
> [  120.766529]  (&(&conn->lock)->rlock#2){+.+...}, at:
> [<ffffffffa00b7ecc>] sco_chan_del+0x4c/0x170 [bluetooth]
> [  120.766529]
> [  120.766529] but task is already holding lock:
> [  120.766529]  (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}, at:
> [<ffffffffa00b8401>] sco_conn_del+0x61/0xe0 [bluetooth]
> [  120.766529]
> [  120.766529] which lock already depends on the new lock.
> [  120.766529]
> [  120.766529]
> [  120.766529] the existing dependency chain (in reverse order) is:
> [  120.766529]
> [  120.766529] -> #1 (slock-AF_BLUETOOTH-BTPROTO_SCO){+.+...}:
> [  120.766529]        [<ffffffff8107980e>] lock_acquire+0x8e/0xb0
> [  120.766529]        [<ffffffff813c19e0>] _raw_spin_lock+0x40/0x80
> [  120.766529]        [<ffffffffa00b85e9>] sco_connect_cfm+0x79/0x300
> [bluetooth]
> [  120.766529]        [<ffffffffa0094b13>]
> hci_sync_conn_complete_evt.isra.90+0x343/0x400 [bluetooth]
> [  120.766529]        [<ffffffffa009d447>] hci_event_packet+0x317/0xfb0
> [bluetooth]
> [  120.766529]        [<ffffffffa008aa68>] hci_rx_work+0x2c8/0x890
> [bluetooth]
> [  120.766529]        [<ffffffff81047db7>] process_one_work+0x197/0x460
> [  120.766529]        [<ffffffff810489d6>] worker_thread+0x126/0x2d0
> [  120.766529]        [<ffffffff8104ee4d>] kthread+0x9d/0xb0
> [  120.766529]        [<ffffffff813c4294>] kernel_thread_helper+0x4/0x10
> [  120.766529]
> [  120.766529] -> #0 (&(&conn->lock)->rlock#2){+.+...}:
> [  120.766529]        [<ffffffff81078a8a>] __lock_acquire+0x154a/0x1d30
> [  120.766529]        [<ffffffff8107980e>] lock_acquire+0x8e/0xb0
> [  120.766529]        [<ffffffff813c19e0>] _raw_spin_lock+0x40/0x80
> [  120.766529]        [<ffffffffa00b7ecc>] sco_chan_del+0x4c/0x170
> [bluetooth]
> [  120.766529]        [<ffffffffa00b8414>] sco_conn_del+0x74/0xe0
> [bluetooth]
> [  120.766529]        [<ffffffffa00b88a2>] sco_disconn_cfm+0x32/0x60
> [bluetooth]
> [  120.766529]        [<ffffffffa0093a82>]
> hci_disconn_complete_evt.isra.53+0x242/0x390 [bluetooth]
> [  120.766529]        [<ffffffffa009d747>] hci_event_packet+0x617/0xfb0
> [bluetooth]
> [  120.766529]        [<ffffffffa008aa68>] hci_rx_work+0x2c8/0x890
> [bluetooth]
> [  120.766529]        [<ffffffff81047db7>] process_one_work+0x197/0x460
> [  120.766529]        [<ffffffff810489d6>] worker_thread+0x126/0x2d0
> [  120.766529]        [<ffffffff8104ee4d>] kthread+0x9d/0xb0
> [  120.766529]        [<ffffffff813c4294>] kernel_thread_helper+0x4/0x10
> [  120.766529]
> [  120.766529] other info that might help us debug this:
> [  120.766529]
> [  120.766529]  Possible unsafe locking scenario:
> [  120.766529]
> [  120.766529]        CPU0                    CPU1
> [  120.766529]        ----                    ----
> [  120.766529]   lock(slock-AF_BLUETOOTH-BTPROTO_SCO);
> [  120.766529]
> lock(&(&conn->lock)->rlock#2);
> [  120.766529]
> lock(slock-AF_BLUETOOTH-BTPROTO_SCO);
> [  120.766529]   lock(&(&conn->lock)->rlock#2);
> [  120.766529]
> [  120.766529]  *** DEADLOCK ***
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>   net/bluetooth/sco.c |   19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index cbdd313..596fdc8 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -149,6 +149,15 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
>   		sco_sock_clear_timer(sk);
>   		sco_chan_del(sk, err);
>   		bh_unlock_sock(sk);
> +
> +		sco_conn_lock(conn);
> +		conn->sk = NULL;
> +		sco_pi(sk)->conn = NULL;
> +		sco_conn_unlock(conn);
> +
> +		if (conn->hcon)
> +			hci_conn_put(conn->hcon);
> +
>   		sco_sock_kill(sk);
>   	}
>   
> @@ -838,16 +847,6 @@ static void sco_chan_del(struct sock *sk, int err)
>   
>   	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
>   
> -	if (conn) {
> -		sco_conn_lock(conn);
> -		conn->sk = NULL;
> -		sco_pi(sk)->conn = NULL;
> -		sco_conn_unlock(conn);
> -
> -		if (conn->hcon)
> -			hci_conn_put(conn->hcon);
> -	}
> -
>   	sk->sk_state = BT_CLOSED;
>   	sk->sk_err   = err;
>   	sk->sk_state_change(sk);

