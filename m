Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Message-id: <4FBB8544.3040408@samsung.com>
Date: Tue, 22 May 2012 21:23:32 +0900
From: Chanyeol Park <chanyeol.park@samsung.com>
To: Minho Ban <mhban@samsung.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Bluetooth: prevent double l2cap_chan_destroy
References: <4FB992C8.8090105@samsung.com> <20120521162137.GE16942@joana>
 <4FBAFEF5.2000207@samsung.com>
In-reply-to: <4FBAFEF5.2000207@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On 2012년 05월 22일 11:50, Minho Ban wrote:
> @@ -1343,10 +1343,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>                  l2cap_chan_lock(chan);
>
>                  l2cap_chan_del(chan, err);
> +               chan->ops->close(chan->data);
>
>                  l2cap_chan_unlock(chan);
>
> -               chan->ops->close(chan->data);
>                  l2cap_chan_put(chan);
>          }
I think this patch does not make sense Because inside chan->ops->close() 
"chan" could be freed in the l2cap_chan_destroy().

> close callback must locate within chan_lock unless it can be scheduled to other thread
> which may wait for chan_lock in l2cap_sock_shutdown and this lead to duplicate sock_kill.
>
>   static void l2cap_sock_kill(struct sock *sk)
>   {
> -       if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
> +       if (!sock_flag(sk, SOCK_ZAPPED) || sock_flag(sk, SOCK_DEAD) ||
> +                       sk->sk_socket)
>                  return;
>
>          BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>
> Duplicate sock_kill may happen anyway, need test SOCK_DEAD if chan_destroy is already called.
Even l2cap_sock_kill() is called twice, " if (!sock_flag(sk, 
SOCK_ZAPPED) || sk->sk_socket)" can't filter it.
I tested Mr.ban case. it works fine with me.

BR
Chanyeol Park.
