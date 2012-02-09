Return-Path: <cyrus@holtmann.org>
Message-ID: <1328797725.28848.22.camel@aeonflux>
Subject: Re: [RFCv3 03/16] Bluetooth: Do not use sk lock in get_chan
 functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 15:28:45 +0100
In-Reply-To: <1328797057-26331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328797057-26331-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When needed we take explicit lock.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ae08944..dcf4792 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -105,9 +105,8 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
>  
>  	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_scid(conn, cid);
> -	if (c)
> -		lock_sock(c->sk);
>  	mutex_unlock(&conn->chan_lock);
> +
>  	return c;
>  }

so this is dangerous since now we are creating an imbalance with the
socket locks. Are we fixing that one later on?

Regards

Marcel


