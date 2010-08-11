Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] list api docs alphabetically and one per line in
 EXTRA_DIST
From: Marcel Holtmann <marcel@holtmann.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1281104283-8792-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281104283-8792-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 13:35:38 -0400
Message-ID: <1281548138.12579.240.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Uwe,

> This makes further changes to the list easier to review
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  Makefile.am |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 65d4312..4bb82fe 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -309,11 +309,18 @@ udevdir = $(libexecdir)/udev
>  dist_udev_SCRIPTS = scripts/bluetooth_serial
>  endif
>  
> -EXTRA_DIST += doc/manager-api.txt \
> -		doc/adapter-api.txt doc/device-api.txt \
> -		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
> -		doc/serial-api.txt doc/network-api.txt \
> -		doc/input-api.txt doc/audio-api.txt doc/control-api.txt
> +EXTRA_DIST += \
> +	      doc/adapter-api.txt \
> +	      doc/agent-api.txt \
> +	      doc/attribute-api.txt \
> +	      doc/audio-api.txt \
> +	      doc/control-api.txt \
> +	      doc/device-api.txt \
> +	      doc/input-api.txt \
> +	      doc/manager-api.txt \
> +	      doc/network-api.txt \
> +	      doc/serial-api.txt \
> +	      doc/service-api.txt \

I prefer actually to not to do this and keep them in a bit more logical
order. The manager is the initial one, followed by adapter etc.

Regards

Marcel


