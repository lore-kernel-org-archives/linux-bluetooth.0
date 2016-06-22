Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH bluetooth-next 1/2] 6lowpan: ndisc: fix double read unlock
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
References: <20160621082719.9903-1-aar@pengutronix.de>
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de,
	dan.carpenter@oracle.com
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <576A92EA.9020906@osg.samsung.com>
Date: Wed, 22 Jun 2016 15:30:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160621082719.9903-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

On 21/06/16 10:27, Alexander Aring wrote:
> This patch removes a double unlock case to accessing neighbour private
> data.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   net/6lowpan/ndisc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
> index ae1d419..030504e 100644
> --- a/net/6lowpan/ndisc.c
> +++ b/net/6lowpan/ndisc.c
> @@ -135,8 +135,9 @@ static int lowpan_ndisc_opt_addr_space(const struct net_device *dev,
>   			read_unlock_bh(&neigh->lock);
>   			addr_space += __ndisc_opt_addr_space(IEEE802154_SHORT_ADDR_LEN, 0);
>   			*ha = ha_buf;
> +		} else {
> +			read_unlock_bh(&neigh->lock);
>   		}
> -		read_unlock_bh(&neigh->lock);
>   		break;
>   	case NDISC_NEIGHBOUR_ADVERTISEMENT:
>   	case NDISC_NEIGHBOUR_SOLICITATION:

Dan, thanks for finding this one!

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com> regards Stefan Schmidt



