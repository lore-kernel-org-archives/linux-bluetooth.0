Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 May 2012 16:28:53 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATC -v2 2/2] Bluetooth: Fix skb length calculation
In-Reply-To: <1336598836-28478-2-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205091627350.2090@mathewm-linux>
References: <1336598836-28478-1-git-send-email-gustavo@padovan.org> <1336598836-28478-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, 9 May 2012, Gustavo Padovan wrote:

> When we add a fragment to a skb, len, data_len and truesize fields needs
> to be updated.

truesize is not updated in this version of the patch.  Also, change 
"needs" to "need"

>
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
> net/bluetooth/l2cap_core.c |    3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 66a1a55..f45f92d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1851,6 +1851,9 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> 		sent += count;
> 		len  -= count;
>
> +		skb->len += (*frag)->len;
> +		skb->data_len += (*frag)->len;
> +
> 		frag = &(*frag)->next;
> 	}
>
> -- 
> 1.7.10.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
