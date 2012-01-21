Return-Path: <cyrus@holtmann.org>
Message-ID: <1327164001.1955.49.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Check for chan_type before locking sk
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 21 Jan 2012 17:40:01 +0100
In-Reply-To: <1327070100-4852-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327070100-4852-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Removes un-needed locking/unlocking if chan_type is not
> L2CAP_CHAN_CONN_ORIENTED and also protects from locking
> zero sk.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b303eae..916ddb1 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -770,13 +770,12 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>  		struct sock *sk = chan->sk;
>  
> -		bh_lock_sock(sk);
> -
>  		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> -			bh_unlock_sock(sk);
>  			continue;
>  		}

this actually raises the question how l2cap_chan is protected. Seems
like we are using the socket lock to protect it. Maybe that needs to be
untangled first.

Regards

Marcel


