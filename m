Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Andrei Emeltchenko' <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1417772907-31708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-reply-to: <1417772907-31708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Subject: RE: [RFC] monitor: Fix RFCOMM parity type mask
Date: Fri, 05 Dec 2014 16:12:03 +0530
Message-id: <000401d01078$1ea58bb0$5bf0a310$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Andrei Emeltchenko
> Sent: Friday, December 05, 2014 3:18 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: [RFC] monitor: Fix RFCOMM parity type mask
> 
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  monitor/rfcomm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c index fe3afb7..71a2792
> 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -67,7 +67,7 @@ static char *cr_str[] = {
>  #define GET_RPN_DB(parity)	(parity & 0x03)
>  #define GET_RPN_SB(parity)	((parity & 0x04) >> 2)
>  #define GET_RPN_PARITY(parity)	((parity & 0x08) >> 3)
> -#define GET_RPN_PTYPE(parity)	((parity & 0x03) >> 3)
> +#define GET_RPN_PTYPE(parity)	((parity & 0x10) >> 4)
>  #define GET_RPN_XIN(io)		(io & 0x01)
>  #define GET_RPN_XOUT(io)	((io & 0x02) >> 1)
>  #define GET_RPN_RTRI(io)	((io & 0x04) >> 2)
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html


I missed it during the implementation. Anyway, the parity type bits are in
BIT5 and BIT6 as per the specification.
So it will be 0x30 instead of 0x10.

 Regards,
Gowtham Anandha Babu

