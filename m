Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] tools/btpclient: Fix ad property manufacturer data name
Date: Tue, 13 Feb 2018 09:15:20 +0100
Message-ID: <2532752.SEh91lMQ4G@ix>
In-Reply-To: <20180212160102.31451-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180212160102.31451-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday, 12 February 2018 17:00:59 CET Grzegorz Kolodziejczyk wrote:
> This patch fixes wrong naming of advertising instance data property.
> ---
>  tools/btpclient.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 097732eb8..61bde820e 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -971,7 +971,7 @@ static void setup_ad_interface(struct l_dbus_interface
> *interface) ad_serviceuuids_getter, NULL);
>  	l_dbus_interface_property(interface, "ServiceData", 0, "a{sv}",
>  						ad_servicedata_getter, NULL);
> -	l_dbus_interface_property(interface, "ManufacturerServiceData", 0,
> +	l_dbus_interface_property(interface, "ManufacturerData", 0,
>  					"a{qv}", ad_manufacturerdata_getter,
>  					NULL);
>  	l_dbus_interface_property(interface, "Includes", 0, "as",

Patches 1 and 2 are now applied, thanks.

-- 
pozdrawiam
Szymon Janc


