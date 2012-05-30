Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 14:33:46 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>, marcel@holtmann.org
cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v3 1/2] Bluetooth: Create function to return the ERTM
 header size
In-Reply-To: <1338308957-17282-1-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205301432460.16153@mathewm-linux>
References: <1338308957-17282-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Tue, 29 May 2012, Gustavo Padovan wrote:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> Simplify the handling of different ERTM header size. We were the same
> check in some places of the code, and more is expected to come, so just
> replace them with a function.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> net/bluetooth/l2cap_core.c |   25 +++++++++++--------------
> 1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3daac2c..acd43aa 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -822,17 +822,20 @@ static inline void __pack_control(struct l2cap_chan *chan,
> 	}
> }
>
> +static inline unsigned int __ertm_hdr_size(struct l2cap_chan *chan)
> +{
> +	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> +		return L2CAP_EXT_HDR_SIZE;
> +	else
> +		return L2CAP_ENH_HDR_SIZE;
> +}
> +
> static struct sk_buff *l2cap_create_sframe_pdu(struct l2cap_chan *chan,
> 					       u32 control)
> {
> 	struct sk_buff *skb;
> 	struct l2cap_hdr *lh;
> -	int hlen;
> -
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		hlen = L2CAP_EXT_HDR_SIZE;
> -	else
> -		hlen = L2CAP_ENH_HDR_SIZE;
> +	int hlen = __ertm_hdr_size(chan);
>
> 	if (chan->fcs == L2CAP_FCS_CRC16)
> 		hlen += L2CAP_FCS_SIZE;
> @@ -2017,10 +2020,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> 	if (!conn)
> 		return ERR_PTR(-ENOTCONN);
>
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		hlen = L2CAP_EXT_HDR_SIZE;
> -	else
> -		hlen = L2CAP_ENH_HDR_SIZE;
> +	hlen = __ertm_hdr_size(chan);
>
> 	if (sdulen)
> 		hlen += L2CAP_SDULEN_SIZE;
> @@ -2086,10 +2086,7 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
> 	if (chan->fcs)
> 		pdu_len -= L2CAP_FCS_SIZE;
>
> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -		pdu_len -= L2CAP_EXT_HDR_SIZE;
> -	else
> -		pdu_len -= L2CAP_ENH_HDR_SIZE;
> +	pdu_len -= __ertm_hdr_size(chan);
>
> 	/* Remote device may have requested smaller PDUs */
> 	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
> -- 
> 1.7.10.2

Looks good to me.

Reviewed-by: Mat Martineau <mathewm@codeaurora.org>

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

