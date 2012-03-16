Return-Path: <cyrus@holtmann.org>
Message-ID: <1331913063.14217.148.camel@aeonflux>
Subject: Re: [PATCH 1/7] Parse config DeviceID string on bluetoothd startup
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Fri, 16 Mar 2012 08:51:03 -0700
In-Reply-To: <1331908913-10330-1-git-send-email-szymon.janc@tieto.com>
References: <1331908913-10330-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Instead of parsing config DeviceID string on sdp server startup, parse
> it in main while reading config file. This allow to store logical DID
> values in main_opts (instead of raw config string) and make use of them
> in bluetoothd code.
> ---
>  src/hcid.h         |    6 +++++-
>  src/main.c         |   20 +++++++++++++++++---
>  src/sdpd-server.c  |   19 ++++---------------
>  src/sdpd-service.c |   16 +++++++++-------
>  src/sdpd.h         |    5 ++---
>  5 files changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/src/hcid.h b/src/hcid.h
> index e2eaf86..53b098a 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -42,7 +42,11 @@ struct main_opts {
>  
>  	uint8_t		mode;
>  	uint8_t		discov_interval;
> -	char		deviceid[15]; /* FIXME: */
> +
> +	gboolean	did;

store the uint16_t did_source here. 0x0000 means off like it does for
the kernel.

> +	uint16_t	did_vendor;
> +	uint16_t	did_product;
> +	uint16_t	did_version;
>  };

Regards

Marcel


