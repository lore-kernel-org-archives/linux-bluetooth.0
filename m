Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 09:58:32 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2] Bluetooth: Create function to return the ERTM header
 size
Message-ID: <20120529065828.GA15895@aemeltch-MOBL1>
References: <1338260107-12880-1-git-send-email-gustavo@padovan.org>
 <1338260317-13308-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338260317-13308-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, May 28, 2012 at 11:58:37PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Simplify the handling of different ERTM header size. We were the same
> check in some places of the code, and more is expected to come, so just
> replace them with a function.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c |   25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 6f30d1d..ad06393 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -814,17 +814,20 @@ static inline void __pack_control(struct l2cap_chan *chan,
>  	}
>  }
>  
> +static inline unsigned int l2cap_ertm_hdr_size(struct l2cap_chan *chan)
> +{
> +	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> +		return L2CAP_EXT_HDR_SIZE;
> +	else
> +		return L2CAP_ENH_HDR_SIZE;
> +}
> +
>  static struct sk_buff *l2cap_create_sframe_pdu(struct l2cap_chan *chan,
>  					       u32 control)
>  {
>  	struct sk_buff *skb;
>  	struct l2cap_hdr *lh;
> -	int hlen;
> -
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		hlen = L2CAP_EXT_HDR_SIZE;
> -	else
> -		hlen = L2CAP_ENH_HDR_SIZE;
> +	int hlen = l2cap_ertm_hdr_size(chan);

I prefer simpler name like:

int hlen = __hdr_size(chan); or __ertm_hdr_size

Otherwise looks good.

Best regards 
Andrei Emeltchenko 

