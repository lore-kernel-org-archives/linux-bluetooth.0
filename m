Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 May 2010 23:39:06 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/2] Bluetooth: Check sk is not owned before freeing
 l2cap_conn
Message-ID: <20100523023906.GB3385@vigoh>
References: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-05-21 13:04:52 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Check that socket sk is not locked in user process before removing
> l2cap connection handler.
> 
> krfcommd kernel thread may be preempted with l2cap tasklet which remove
> l2cap_conn structure. If krfcommd is in process of sending of RFCOMM reply
> (like "RFCOMM UA" reply to "RFCOMM DISC") then kernel crash happens.
> 
> ...
> [  694.175933] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [  694.184936] pgd = c0004000
> [  694.187683] [00000000] *pgd=00000000
> [  694.191711] Internal error: Oops: 5 [#1] PREEMPT
> [  694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
> [  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
> [  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
> [  694.270721] LR is at 0xd7017303
> ...
> [  694.525085] Backtrace:
> [  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) from [<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
> [  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] (kernel_sendmsg+0x48/0x80)
> ...
> 
> Modified version after comments of Gustavo F. Padovan <gustavo@padovan.org>
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index bb00015..11060d6 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2927,6 +2927,13 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  		break;
>  
>  	default:
> +		/* don't delete l2cap channel if sk is owned by user */
> +		if (sock_owned_by_user(sk)) {
> +			sk->sk_state = BT_DISCONN;
> +			l2cap_sock_clear_timer(sk);
> +			l2cap_sock_set_timer(sk, HZ);

Using the sock timer like you are you using looks too hackish, there are
kernel struct for such defer works. I still prefer the first solution,
that avoids the call to l2cap_chan_del() only.
But we have to solve the problem with the sock_kill() call, I'm
wondering if add a check inside l2cap_sock_kill is good idea. So we
check if the socket is owned by user and if yes, we just return, however
may have problem with socket refcnt doing that. 

Looking to the rfcomm code I found something that could be cause of the
problem, there isn't any sock_hold() in the rfcomm code, maybe is it
missing? Nevertheless it does the sock_put() without call sock_hold().

Like you I'm trying to figure out how to fix this issue, I don't know
yet how to fix it properly. I advice to take a look on the rfcomm code
and check if we really are missing a sock_hold() there. 

Also is not easy to reproduce such sequence of l2cap and rfcomm packets,
so I can't test the issue here too.


> +			break;
> +		}
>  		l2cap_chan_del(sk, ECONNREFUSED);
>  		break;
>  	}
> @@ -3135,6 +3142,15 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
>  		del_timer(&l2cap_pi(sk)->ack_timer);
>  	}
>  
> +	/* don't delete l2cap channel if sk is owned by user */
> +	if (sock_owned_by_user(sk)) {
> +		sk->sk_state = BT_DISCONN;
> +		l2cap_sock_clear_timer(sk);
> +		l2cap_sock_set_timer(sk, HZ);
> +		bh_unlock_sock(sk);
> +		return 0;
> +	}
> +
>  	l2cap_chan_del(sk, ECONNRESET);
>  	bh_unlock_sock(sk);
>  
> @@ -3167,6 +3183,15 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
>  		del_timer(&l2cap_pi(sk)->ack_timer);
>  	}
>  
> +	/* don't delete l2cap channel if sk is owned by user */
> +	if (sock_owned_by_user(sk)) {
> +		sk->sk_state = BT_DISCONN;
> +		l2cap_sock_clear_timer(sk);
> +		l2cap_sock_set_timer(sk, HZ);
> +		bh_unlock_sock(sk);
> +		return 0;
> +	}
> +
>  	l2cap_chan_del(sk, 0);
>  	bh_unlock_sock(sk);
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
