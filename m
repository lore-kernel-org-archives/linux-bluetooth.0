Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Dec 2013 07:07:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Use min_t for calculating chan->imtu
Message-ID: <20131206050709.GA30989@x220.p-661hnu-f1>
References: <1386306115-30686-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386306115-30686-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 06, 2013, johan.hedberg@gmail.com wrote:
> Since there's a nice convenient helper for calculating the minimum of
> two values, let's use that one.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6e6f308af036..8f42cae96dc3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -505,11 +505,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan)
>  	chan->sdu_len = 0;
>  	chan->tx_credits = 0;
>  	chan->rx_credits = le_max_credits;
> -
> -	if (chan->imtu < L2CAP_LE_DEFAULT_MPS)
> -		chan->mps = chan->imtu;
> -	else
> -		chan->mps = L2CAP_LE_DEFAULT_MPS;
> +	chan->imtu = min_t(u16, chan->imtu, L2CAP_LE_DEFAULT_MPS);

Ignore this one. It should obviously be assigning to chan->mps and not
chan->imtu.

Johan
