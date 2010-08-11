Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] add three missing api documents to EXTRA_DIST
From: Marcel Holtmann <marcel@holtmann.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1281104283-8792-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1281104283-8792-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1281104283-8792-2-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 11 Aug 2010 13:38:24 -0400
Message-ID: <1281548304.12579.243.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Uwe,

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> there are still a few files in bluez.git/doc that are not listed in EXTRA_DIST:
> 
>  - bluez-docs.xml
>  - gtk-doc.make
>  - version.xml.in

they are not suppose to be there. They are leftovers and might be should
removed since we don't really do gtk-doc generation anymore.

> I didn't know if I should add these, too, so I just point that out.
> 
> Best regards
> Uwe
> 
>  Makefile.am |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 4bb82fe..7007026 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -316,9 +316,12 @@ EXTRA_DIST += \
>  	      doc/audio-api.txt \
>  	      doc/control-api.txt \
>  	      doc/device-api.txt \
> +	      doc/health-api.txt \
> +	      doc/hfp-api.txt \
>  	      doc/input-api.txt \
>  	      doc/manager-api.txt \
>  	      doc/network-api.txt \
> +	      doc/node-api.txt \
>  	      doc/serial-api.txt \
>  	      doc/service-api.txt \

please send a patch that just adds hfp-api.txt to EXTRA_DIST.

The node-api.txt has never been implemented and might become obsolete
soon. So that should not be in the distribution.

The health-api.txt will come soon, but until we merged the code for it,
I prefer not adding it into the distribution.

Regards

Marcel


