Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 12:34:54 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: fix MTU L2CAP configuration parameter
Message-ID: <20100902093454.GC2041@null>
References: <1283343445-9328-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283343445-9328-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 01, 2010 at 02:17:25PM +0200, ext Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> When receiving L2CAP negative configuration response with respect
> to MTU parameter we modify wrong field. MTU here means proposed
> value of MTU that the remote device intends to transmit. So for local
> L2CAP socket it is pi->imtu.
> 

Yes imtu is negotiated in this phase.

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Acked-by: Ville Tervo <ville.tervo@nokia.com>

> ---
>  net/bluetooth/l2cap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index c784703..9fad312 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2771,10 +2771,10 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
>  		case L2CAP_CONF_MTU:
>  			if (val < L2CAP_DEFAULT_MIN_MTU) {
>  				*result = L2CAP_CONF_UNACCEPT;
> -				pi->omtu = L2CAP_DEFAULT_MIN_MTU;
> +				pi->imtu = L2CAP_DEFAULT_MIN_MTU;
>  			} else
> -				pi->omtu = val;
> -			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
> +				pi->imtu = val;
> +			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
>  			break;
>  
>  		case L2CAP_CONF_FLUSH_TO:
> -- 
> 1.7.0.4


-- 
Ville
