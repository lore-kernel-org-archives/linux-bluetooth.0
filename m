Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jan 2010 09:25:04 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: =?utf-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Ping <pinglinux@gmail.com>
Subject: Re: [PATCH] Two small patches
Message-ID: <20100104232504.GB27365@barra.redhat.com>
References: <1262647038.2983.5.camel@pldmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1262647038.2983.5.camel@pldmachine>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 04, 2010 at 11:17:18PM +0000, Przemysław Firszt wrote:
> Hi,
> 2 patches:
> - use defined variable is_proximity 
> -remove duplicate comment from xf86WacomDefs.h
> 
> Those two are not important, but I don't want to leave it till later -
> "the later" it might never happen.
> --
> Przemo

> From a1865a5f06f165a398d9a87d34c96b59b1d8660c Mon Sep 17 00:00:00 2001
> From: Przemo Firszt <przemo@firszt.eu>
> Date: Mon, 4 Jan 2010 19:25:20 +0000
> Subject: [PATCH 2/3] is_proximity is defined, so let's use it
> 
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---
>  src/wcmCommon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/wcmCommon.c b/src/wcmCommon.c
> index 32ad82e..1c1cc2c 100644
> --- a/src/wcmCommon.c
> +++ b/src/wcmCommon.c
> @@ -779,7 +779,7 @@ void xf86WcmSendEvents(LocalDevicePtr local, const WacomDeviceState* ds)
>  	}
>  
>  	/* don't move the cursor when going out-prox */
> -	if (!ds->proximity)
> +	if (!is_proximity)
>  	{
>  		x = priv->oldX;
>  		y = priv->oldY;
> -- 
> 1.6.5.7
> 

I'd prefer a more verbose explanation here. Why not just use ds->proximity
and remove is_proximity? (I know the answer, but it'd be nice to get it from
the patch, not from the code)

> From 714b4b3b989ae5a36b839bd4fe229999233cd192 Mon Sep 17 00:00:00 2001
> From: Przemo Firszt <przemo@firszt.eu>
> Date: Mon, 4 Jan 2010 23:13:06 +0000
> Subject: [PATCH 3/3] Remove duplicate comment in xf86WacomDefs.h
> 
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---
>  src/xf86WacomDefs.h |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/src/xf86WacomDefs.h b/src/xf86WacomDefs.h
> index 1e4a441..34a9375 100644
> --- a/src/xf86WacomDefs.h
> +++ b/src/xf86WacomDefs.h
> @@ -324,10 +324,6 @@ struct _WacomChannel
>  
>  	WacomDeviceState work;                         /* next state */
>  
> -	/* the following struct contains the current known state of the
> -	 * device channel, as well as the previous MAX_SAMPLES states
> -	 * for use in detecting hardware defects, jitter, trends, etc. */
> -
>  	/* the following union contains the current known state of the
>  	 * device channel, as well as the previous MAX_SAMPLES states
>  	 * for use in detecting hardware defects, jitter, trends, etc. */
> -- 
> 1.6.5.7

merged, thanks.

Cheers,
  Peter
