Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Apr 2011 13:00:58 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] Add Type property to Device
Message-ID: <20110411160058.GB2195@joana>
References: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Dieb Martins <andre.dieb@signove.com> [2011-03-30 15:33:55 -0300]:

> ---
>  doc/device-api.txt |    4 ++++
>  src/device.c       |   18 ++++++++++++++++++
>  src/device.h       |    2 ++
>  3 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index d1feb18..a667296 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -130,6 +130,10 @@ Properties	string Address [readonly]
>  			Proposed icon name according to the freedesktop.org
>  			icon naming specification.
>  
> +		string Type [readonly]
> +
> +			Device type (BR/EDR, LE, BR/EDR/LE).
> +
>  		uint32 Class [readonly]
>  
>  			The Bluetooth class of device of the remote device.
> diff --git a/src/device.c b/src/device.c
> index d567952..96683de 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -228,6 +228,20 @@ static void device_free(gpointer user_data)
>  	g_free(device);
>  }
>  
> +const char *devtype2str(device_type_t type)
> +{
> +	switch (type) {
> +	case DEVICE_TYPE_BREDR:
> +		return "BR/EDR";
> +	case DEVICE_TYPE_LE:
> +		return "LE";
> +	case DEVICE_TYPE_DUALMODE:
> +		return "BR/EDR/LE";

I think that  use "Dual Mode" is much better here.

-- 
Gustavo F. Padovan
http://profusion.mobi
