Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 14:22:11 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Get a more accurate PDU len
In-Reply-To: <1337979258-4492-1-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205251419260.2070@mathewm-linux>
References: <1337979258-4492-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 25 May 2012, Gustavo Padovan wrote:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> Both FCS and Extended header might be or might not be present in a ERTM
> channel.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> net/bluetooth/l2cap_core.c |    8 ++++++++
> 1 file changed, 8 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c07c134..40d1d6f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2143,6 +2143,14 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
> 	pdu_len = min_t(size_t, pdu_len, L2CAP_BREDR_MAX_PAYLOAD);
>
> 	/* Adjust for largest possible L2CAP overhead. */
> +	if (chan->fcs)
> +		pdu_len -= L2CAP_FCS_SIZE;
> +
> +	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> +		pdu_len -= L2CAP_EXT_HDR_SIZE;
> +	else
> +		pdu_len -= L2CAP_ENH_HDR_SIZE;
> +
> 	pdu_len -= L2CAP_EXT_HDR_SIZE + L2CAP_FCS_SIZE;

Don't you want to remove this last line?

>
> 	/* Remote device may have requested smaller PDUs */
> -- 
> 1.7.10.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
