Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 6/9] Bluetooth: Add definitions for L2CAP fixed
 channels
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Wed, 19 Oct 2011 12:03:58 -0700
In-Reply-To: <1319046247-3391-7-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
	 <1319046247-3391-7-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319051041.15441.167.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Symbolic fixed channel IDs will be used instead of magic numbers.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 4f4f318..b8b25f6 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -119,6 +119,10 @@ struct l2cap_conninfo {
>  #define L2CAP_FCS_NONE		0x00
>  #define L2CAP_FCS_CRC16		0x01
>  
> +/* L2CAP fixed channels */
> +#define L2CAP_FC_L2CAP		0x02
> +#define L2CAP_FC_A2MP		0x08
> +

while you are at it, please add the known fixed channels for SMP and LE
signaling here. They should be in use already somewhere ;)

>  /* L2CAP Control Field bit masks */
>  #define L2CAP_CTRL_SAR			0xC000
>  #define L2CAP_CTRL_REQSEQ		0x3F00

Regards

Marcel


