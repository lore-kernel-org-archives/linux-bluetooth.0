Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Nov 2013 10:02:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/6] android: Add supported uuids when adapter is
 initialized
Message-ID: <20131106080254.GA15573@x220.p-661hnu-f1>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
 <1383657700-22313-5-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383657700-22313-5-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Nov 05, 2013, Marcin Kraglak wrote:
> It will set class of device with proper service hints.
> We set it statically because we want to keep code simple.
> 
> ---
>  android/adapter.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

I've applied patches 1-3, but am a bit confused about this one.

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
> +	/* HFP_AG_UUID */
> +	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0x1f, 0x11, 0x00, 0x00 },
> +	.svc_hint = 0x40 },
> +	/* ADVANCED_AUDIO_UUID */
> +	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0x0d, 0x11, 0x00, 0x00 },
> +	.svc_hint = 0x08 },
> +	/* PANU_UUID */
> +	{ .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0x15, 0x11, 0x00, 0x00 },
> +	.svc_hint = 0x02 }
> +};

I seem to remember the discussion around this drifting back to doing the
registration dynamically. Do I remember wrong? Wasn't it so that at
least some UUIDs (such as PAN) with a bluedroid based system only appear
when you actually enable support for the profile in the UI?

Johan
