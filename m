Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Reply-To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: fix crash by disabling tasklet in sock
	accept
References: <1295351698-8096-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1295351698-8096-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 19 Jan 2011 17:37:50 +0200
Message-Id: <1295451471.9558.2.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Crash can happen when tasklet handling connect/disconnect requests
> preempts socket accept. Can be reproduced with "l2test -r" on one
> side and several "l2test -c -b 1000 -i hci0 -P 10 <bdaddr>" on the
> other side.
> 
> ...
> [ 3555.897247] Unable to handle kernel NULL pointer dereference at
> virtual address 000000bc
> [ 3555.915039] pgd = cab9c000
> [ 3555.917785] [000000bc] *pgd=8bf3d031, *pte=00000000, *ppte=00000000
> [ 3555.928314] Internal error: Oops: 17 [#1] PREEMPT
> [ 3555.999786] CPU: 0       Not tainted   (2.6.32.21-13874-g67918ef #65)
> ...
> [ 3556.005981] PC is at bt_accept_unlink+0x20/0x58 [bluetooth]
> [ 3556.011627] LR is at bt_accept_dequeue+0x3c/0xe8 [bluetooth]
> ...
> [ 3556.161285] [<bf0007fc>] (bt_accept_unlink+0x20/0x58 [bluetooth]) from
> [<bf000870>] (bt_accept_dequeue+0x3c/0xe8 [bluetooth])
> [ 3556.172729] [<bf000870>] (bt_accept_dequeue+0x3c/0xe8 [bluetooth])
> from [<bf324df8>] (l2cap_sock_accept+0x100/0x15c [l2cap])
> [ 3556.184082] [<bf324df8>] (l2cap_sock_accept+0x100/0x15c [l2cap]) from
> [<c026a0a8>] (sys_accept4+0x120/0x1e0)
> [ 3556.193969] [<c026a0a8>] (sys_accept4+0x120/0x1e0) from [<c002c9a0>]
> (ret_fast_syscall+0x0/0x2c)
> [ 3556.202819] Code: e5813000 e5901164 e580c160 e580c15c (e1d13bbc)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>   net/bluetooth/af_bluetooth.c |       4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index a6732b5..86386e9 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -199,6 +199,7 @@ struct sock *bt_accept_dequeue(struct sock *parent,
> struct socket *newsock) 
>       BT_DBG("parent %p", parent);
>   
> +    local_bh_disable();
>       list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
>           sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
>   
> @@ -217,11 +218,14 @@ struct sock *bt_accept_dequeue(struct sock
> *parent, struct socket *newsock)             if (newsock)
>                   sock_graft(sk, newsock);
>               release_sock(sk);

I will change lock,release_sock to bh_lock,unlock_sock

when bh are disabled we do not need to mark
socket as owned.

Other comments about the patch?

> +            local_bh_enable();
>               return sk;
>           }
>   
>           release_sock(sk);
>       }
> +    local_bh_enable();
> +
>       return NULL;
>   }
>   EXPORT_SYMBOL(bt_accept_dequeue);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at   http://vger.kernel.org/majordomo-info.html

