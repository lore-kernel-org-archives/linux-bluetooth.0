Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 10:04:53 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/6] android: Add supported uuids when adapter is
 initialized
Message-ID: <20131107080450.GA21468@aemeltch-MOBL1>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
 <1383657700-22313-5-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383657700-22313-5-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Tue, Nov 05, 2013 at 02:21:38PM +0100, Marcin Kraglak wrote:
> It will set class of device with proper service hints.
> We set it statically because we want to keep code simple.
> 
> ---
>  android/adapter.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 0f24cac..70b9265 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -52,6 +52,29 @@ static GIOChannel *notification_io = NULL;
>  /* This list contains addresses which are asked for records */
>  static GSList *browse_reqs;
>  
> +/*
> + * This is an array of supported uuids and service hints. We add them via mgmt
> + * interface when adapter is initialized. Uuids are in reverse orded.
> + */
> +static const struct mgmt_cp_add_uuid supported_services[] = {
> +	/* OBEX_OPP_UUID */
> +	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0x05, 0x11, 0x00, 0x00 },
> +	.svc_hint = 0x10 },

I think PBAP is missing here. BTW can we define those strings separately
so that it might be used to compare.

Socket HAL identify service by UUID so I need to derive RFCOMM channel
from it. I am thinking simply comparing those strings.

Any opinion on this?

Best regards 
Andrei Emeltchenko 
