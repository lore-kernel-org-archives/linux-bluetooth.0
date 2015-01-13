Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1420466575-14615-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1420466575-14615-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] Bluetooth: Remove dead code
Date: Tue, 13 Jan 2015 12:22:58 +0530
Message-id: <000401d02efd$92b05e60$b8111b20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Monday, January 05, 2015 7:33 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH] Bluetooth: Remove dead code
> 
> Variable 'controller' is assigned a value that is never used.
> Identified by cppcheck tool.
> 
> Signed-off-by: Gowtham Anandha Babu <gowtham.ab@samsung.com>
> ---
>  net/bluetooth/cmtp/capi.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c index
> 1ca8a87..75bd2c4 100644
> --- a/net/bluetooth/cmtp/capi.c
> +++ b/net/bluetooth/cmtp/capi.c
> @@ -253,8 +253,6 @@ static void cmtp_recv_interopmsg(struct
> cmtp_session *session, struct sk_buff *s
>  			if (skb->len < CAPI_MSG_BASELEN + 15)
>  				break;
> 
> -			controller = CAPIMSG_U32(skb->data,
> CAPI_MSG_BASELEN + 10);
> -
>  			if (!info && ctrl) {
>  				int len = min_t(uint,
> CAPI_MANUFACTURER_LEN,
>  						skb-
> >data[CAPI_MSG_BASELEN + 14]); @@ -270,8 +268,6 @@ static void
> cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
>  			if (skb->len < CAPI_MSG_BASELEN + 32)
>  				break;
> 
> -			controller = CAPIMSG_U32(skb->data,
> CAPI_MSG_BASELEN + 12);
> -
>  			if (!info && ctrl) {
>  				ctrl->version.majorversion =
> CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 16);
>  				ctrl->version.minorversion =
> CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 20); @@ -285,8 +281,6
> @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct
> sk_buff *s
>  			if (skb->len < CAPI_MSG_BASELEN + 17)
>  				break;
> 
> -			controller = CAPIMSG_U32(skb->data,
> CAPI_MSG_BASELEN + 12);
> -
>  			if (!info && ctrl) {
>  				int len = min_t(uint, CAPI_SERIAL_LEN,
>  						skb-
> >data[CAPI_MSG_BASELEN + 16]);
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

