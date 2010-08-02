Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 8/8] Bluetooth:  Use 3-DH5 payload size for default
 ERTM max PDU size.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-9-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-9-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:48:28 -0700
Message-ID: <1280778508.12579.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

this should have a commit message with technical details to explain why
it is a good idea.

> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 16e412f..93aba17 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -35,7 +35,7 @@
>  #define L2CAP_DEFAULT_MAX_TX		3
>  #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
>  #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
> -#define L2CAP_DEFAULT_MAX_PDU_SIZE	672
> +#define L2CAP_DEFAULT_MAX_PDU_SIZE	1011    /* Sized for 3-DH5 packet */
>  #define L2CAP_DEFAULT_ACK_TO		200
>  #define L2CAP_LOCAL_BUSY_TRIES		12

Also the default PDU size for basic mode should stay with 672. And only
for ERTM move it to 1010. Is this ensured?

And then again here. Is that explained in the commit message?

Regards

Marcel

 


