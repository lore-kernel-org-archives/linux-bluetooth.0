Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 11:44:46 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 13/18] Bluetooth: Flag ACL frames as complete for AMP
 controllers
Message-ID: <20121019084445.GJ4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-14-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-14-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 18, 2012 at 10:58:45AM -0700, Mat Martineau wrote:
> AMP controllers expect to transmit only "complete" ACL frames.  These
> frames have both the "start" and "cont" bits set.  AMP does not allow
> fragmented ACLs.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d83faa9..a8fc10d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -762,6 +762,15 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
>  	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
>  	       skb->priority);
>  
> +	if (chan->hs_hcon && !__chan_is_moving(chan)) {
> +		if (chan->hs_hchan)
> +			hci_send_acl(chan->hs_hchan, skb, ACL_COMPLETE);
> +		else
> +			kfree_skb(skb);
> +
> +		return;
> +	}
> +
>  	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
>  	    lmp_no_flush_capable(hcon->hdev))
>  		flags = ACL_START_NO_FLUSH;
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
