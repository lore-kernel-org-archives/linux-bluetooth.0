Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] tools: btpclient: Clear advertising data on reset
Date: Wed, 31 Jan 2018 10:09:13 +0100
Message-ID: <5642552.UvG7uKk54W@ix>
In-Reply-To: <20180125155333.12734-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180125155333.12734-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday, 25 January 2018 16:53:29 CET Grzegorz Kolodziejczyk wrote:
> Advertising data should be cleared on gap reset command.
> ---
>  tools/btpclient.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 3c88f1496..bdc404dd9 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -390,6 +390,24 @@ static void unreg_advertising_setup(struct
> l_dbus_message *message, l_dbus_message_builder_destroy(builder);
>  }
> 
> +static void ad_cleanup_service(void *service)
> +{
> +	struct service_data *s = service;
> +
> +	l_free(s->uuid);
> +	l_free(s);
> +}
> +
> +static void ad_cleanup(void)
> +{
> +	l_free(ad.local_name);
> +	l_queue_destroy(ad.uuids, l_free);
> +	l_queue_destroy(ad.services, ad_cleanup_service);
> +	l_queue_destroy(ad.manufacturers, l_free);
> +
> +	memset(&ad, 0, sizeof(ad));
> +}
> +
>  static void unreg_advertising_reply(struct l_dbus_proxy *proxy,
>  						struct l_dbus_message *result,
>  						void *user_data)
> @@ -417,6 +435,8 @@ static void unreg_advertising_reply(struct l_dbus_proxy
> *proxy, l_info("Unable to remove propety instance");
>  	if (!l_dbus_unregister_interface(dbus, AD_IFACE))
>  		l_info("Unable to unregister ad interface");
> +
> +	ad_cleanup();
>  }
> 
>  static void btp_gap_reset(uint8_t index, const void *param, uint16_t
> length, @@ -449,7 +469,7 @@ static void btp_gap_reset(uint8_t index, const
> void *param, uint16_t length, NULL);
>  	}
> 
> -	if (adapter->ad_proxy)
> +	if (adapter->ad_proxy && ad.registered)
>  		if (!l_dbus_proxy_method_call(adapter->ad_proxy,
>  						"UnregisterAdvertisement",
>  						unreg_advertising_setup,
> @@ -646,24 +666,6 @@ failed:
>  	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
>  }
> 
> -static void ad_cleanup_service(void *service)
> -{
> -	struct service_data *s = service;
> -
> -	l_free(s->uuid);
> -	l_free(s);
> -}
> -
> -static void ad_cleanup(void)
> -{
> -	l_free(ad.local_name);
> -	l_queue_destroy(ad.uuids, l_free);
> -	l_queue_destroy(ad.services, ad_cleanup_service);
> -	l_queue_destroy(ad.manufacturers, l_free);
> -
> -	memset(&ad, 0, sizeof(ad));
> -}
> -
>  static void ad_init(void)
>  {
>  	ad.uuids = l_queue_new();


All patches applied (2/5 v2), thanks.

-- 
pozdrawiam
Szymon Janc


