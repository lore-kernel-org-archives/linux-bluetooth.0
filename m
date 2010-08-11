Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] add mailing list as bug report address to configure.ac
From: Marcel Holtmann <marcel@holtmann.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1281104400-9019-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281104400-9019-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 13:39:03 -0400
Message-ID: <1281548343.12579.244.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Uwe,

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  configure.ac |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b004f6e..2804d29 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,5 +1,5 @@
>  AC_PREREQ(2.60)
> -AC_INIT(bluez, 4.69)
> +AC_INIT(bluez, 4.69, [linux-bluetooth@vger.kernel.org])
>  
>  AM_INIT_AUTOMAKE([foreign subdir-objects])
>  AM_CONFIG_HEADER(config.h)

I prefer not doing this. Can we not just use the README file for this.
Hold on, we are already doing this ;)

Regards

Marcel


