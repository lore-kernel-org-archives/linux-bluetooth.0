Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 10:42:55 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Check MTU value in
 l2cap_sock_setsockopt_old
Message-ID: <20120531134255.GP18069@joana>
References: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
 <1338401329-31429-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338401329-31429-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-05-30 15:08:48 -0300]:

> If user tries to set an invalid MTU value, l2cap_sock_setsockopt_old
> should return -EINVAL.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/l2cap_sock.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index d856cc8..a7ac747 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -445,6 +445,22 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
>  	return err;
>  }
>  
> +static bool is_valid_mtu(struct l2cap_chan *chan, u16 mtu)

I prefer if we call this l2cap_valid_mtu()

> +{
> +	switch (chan->scid) {
> +	case L2CAP_CID_LE_DATA:
> +		if (mtu < L2CAP_LE_DEFAULT_MTU)
> +			return 0;

If you want to return bool you might want to return false here.

> +		break;
> +
> +	default:
> +		if (mtu < L2CAP_DEFAULT_MIN_MTU)
> +			return 0;
> +	}
> +
> +	return 1;

and true here.

	Gustavo
