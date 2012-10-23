Return-Path: <cyrus@holtmann.org>
Message-ID: <1351003922.1785.33.camel@aeonflux>
Subject: Re: [PATCH v1 5/5] Bluetooth: Fix L2CAP dynamic PSM bind issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 07:52:02 -0700
In-Reply-To: <1350999140-7481-5-git-send-email-s.syam@samsung.com>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
	 <1350999140-7481-5-git-send-email-s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> Dynamic PSM choosen by the kernel should bound to either BDADDR_ANY
> or the same adapter address(not both) for a particular adapter.
> 
> The problem here is by giving PSM 0, the kernel should return the first
> available PSM in the non-reserverd space, but since we reuse the same
> code to do the matching it end up given both Obexd and HDP the same
> PSM.
> 
> Provid a helper function to handle the dymanic PSM auto selection.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/l2cap_core.c |   55 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d42cdb1..33b5d34 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -119,6 +119,43 @@ static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
>  	return NULL;
>  }
>  
> +/* Returns free dynamic PSM */
> +static u16 __l2cap_global_get_dyna_chan_by_addr(bdaddr_t *src)
> +{

this is a bad name. No idea what kind of meaning "dyna" has.

And btw. there is no such thing as dynamic PSM. It has nothing dynamic
about it. It is an auto-selected PSM. And in the end, it just selects
the next free one.

> +	struct l2cap_chan *c;
> +	u16 p;
> +	bool found;
> +
> +	for (p = 0x1001; p < 0x1100; p += 2) {
> +		found = false;
> +
> +		list_for_each_entry(c, &chan_list, global_l) {
> +			if (c->sport != p)
> +				continue;
> +
> +			/* PSM match found */
> +			found = true;
> +
> +			/* Exact match */
> +			if (!bacmp(&bt_sk(c->sk)->src, src))
> +				break;
> +
> +			/* BDADDR_ANY match */
> +			if (!bacmp(&bt_sk(c->sk)->src, BDADDR_ANY) ||
> +			    !bacmp(src, BDADDR_ANY))
> +				break;
> +
> +			/* Match found only for other adapter address */
> +			return p;
> +		}
> +
> +		if (!found)
> +			return p;
> +	}
> +
> +	return 0;
> +}
> +

This code needs a comment on how it is suppose to work and why it is
correct.

>  int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
>  {
>  	int err;
> @@ -135,16 +172,16 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
>  		chan->sport = psm;
>  		err = 0;
>  	} else {
> -		u16 p;
> -
> +		/* No PSM given by user space */
> +		u16 dpsm;
>  		err = -EINVAL;
> -		for (p = 0x1001; p < 0x1100; p += 2)
> -			if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src)) {
> -				chan->psm   = cpu_to_le16(p);
> -				chan->sport = cpu_to_le16(p);
> -				err = 0;
> -				break;
> -			}
> +
> +		dpsm = __l2cap_global_get_dyna_chan_by_addr(src);
> +		if (dpsm) {
> +			chan->psm = dpsm;
> +			chan->sport = dpsm;
> +			err = 0;
> +		}
>  	}
>  
>  done:

Regards

Marcel


