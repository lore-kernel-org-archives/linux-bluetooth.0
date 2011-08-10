Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix PTS DID test case TP/SDI/BV-03-I
From: Marcel Holtmann <marcel@holtmann.org>
To: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Aug 2011 08:16:37 -0700
In-Reply-To: <1312985204-10311-1-git-send-email-arkadiusz.lichwa@tieto.com>
References: <1312985204-10311-1-git-send-email-arkadiusz.lichwa@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312989400.3373.125.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arek,

> Now it's allowed to specify arbitrary vendor ID assigner in main.conf
> file to be able verify PTS against DID test case TP/SDI/BV-03-I.
> Available supported vendor assigner's are: BT SIG (0x1) and
> USB Implementer's Forum (0x2).
> ---
>  src/hcid.h         |    2 +-
>  src/main.conf      |    7 ++++---
>  src/sdpd-server.c  |   18 +++++++-----------
>  src/sdpd-service.c |   14 +++++++++++---
>  src/sdpd.h         |    4 ++--
>  5 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/src/hcid.h b/src/hcid.h
> index ea038e9..60e0ede 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -42,7 +42,7 @@ struct main_opts {
>  
>  	uint8_t		mode;
>  	uint8_t		discov_interval;
> -	char		deviceid[15]; /* FIXME: */
> +	char		deviceid[20]; /* FIXME: */
>  };
>  
>  enum {
> diff --git a/src/main.conf b/src/main.conf
> index 8cd132f..76779ba 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -37,9 +37,10 @@ InitiallyPowered = true
>  # Remember the previously stored Powered state when initializing adapters
>  RememberPowered = true
>  
> -# Use vendor, product and version information for DID profile support.
> -# The values are separated by ":" and VID, PID and version.
> -#DeviceID = 1234:5678:abcd
> +# Use vendor assigner, vendor, product and version information for DID profile
> +# support. The values are separated by ":" and VID assigner, VID, PID and
> +# version. The values need to be in hex format.
> +#DeviceID = 2:1234:5678:abcd

you need to ensure that this does not break backward compatibility.

So I rather have this done like 1234:5678 is allowed and falls back to
to no version. And theat 1234:5678:abcd is the one with version and both
default to Bluetooth vendor.

Then allow bluetooth:1234:5678:abcd to do the same actually and
usb:1234:5678:abcd for USB ids.

I am against numbers for the vendor ID  origin.

Regards

Marcel


