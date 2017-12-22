Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/6] tools/btpclient: Add advertising proxy to adapter
Date: Fri, 22 Dec 2017 11:48:27 +0100
Message-ID: <4965681.kZWkZL0VDl@ix>
In-Reply-To: <20171221164720.20925-3-grzegorz.kolodziejczyk@codecoup.pl>
References: <20171221164720.20925-1-grzegorz.kolodziejczyk@codecoup.pl> <20171221164720.20925-3-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday, 21 December 2017 17:47:17 CET Grzegorz Kolodziejczyk wrote:
> Advertising manager proxy is required to handle advertise related
> operations in adapter context.
> ---
>  tools/btpclient.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 27e5a498e..095c5ea3e 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -36,6 +36,7 @@
> 
>  struct btp_adapter {
>  	struct l_dbus_proxy *proxy;
> +	struct l_dbus_proxy *ad_proxy;
>  	uint8_t index;
>  	uint32_t supported_settings;
>  	uint32_t current_settings;
> @@ -659,6 +660,17 @@ static void proxy_added(struct l_dbus_proxy *proxy,
> void *user_data) device->proxy = proxy;
> 
>  		l_queue_push_tail(adapter->devices, device);
> +
> +		return;
> +	}
> +
> +	if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
> +		struct btp_adapter *adapter;
> +
> +		adapter = find_adapter_by_path(path);

This may return NULL if we failed to add proxy of adapter or due to invalid 
message. Please check that.

> +
> +		adapter->ad_proxy = proxy;
> +
>  		return;
>  	}
>  }


-- 
pozdrawiam
Szymon Janc
