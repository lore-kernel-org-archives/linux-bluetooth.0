Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 11:33:36 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded zero initialization
Message-ID: <20120328143336.GA3962@joana>
References: <1332935794-15319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332940001-20336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332940001-20336-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-28 16:06:41 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove zero initialization since channel is allocated with kzalloc
> in l2cap_chan_create.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 53e563f..1d3e9c3 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1011,7 +1011,6 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
>  		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
>  		chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
>  		chan->sec_level = BT_SECURITY_LOW;
> -		chan->flags = 0;
>  		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
>  	}

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
