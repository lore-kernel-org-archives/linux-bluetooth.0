Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/8] tools/btpclient: Restore default settings on reset
Date: Tue, 23 Jan 2018 14:48:48 +0100
Message-ID: <2383001.ylVEV99tJ0@ix>
In-Reply-To: <20180119164133.16767-4-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180119164133.16767-1-grzegorz.kolodziejczyk@codecoup.pl> <20180119164133.16767-4-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday, 19 January 2018 17:41:29 CET Grzegorz Kolodziejczyk wrote:
> Reset command will restore default settings of adapter.
> ---
>  tools/btpclient.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 708092937..c5f88e673 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -56,6 +56,7 @@ struct btp_adapter {
>  	uint8_t index;
>  	uint32_t supported_settings;
>  	uint32_t current_settings;
> +	uint32_t default_settings;
>  	struct l_queue *devices;
>  };
> 
> @@ -538,6 +539,8 @@ static void btp_gap_reset(uint8_t index, const void
> *param, uint16_t length, goto failed;
>  		}
> 
> +	adapter->current_settings = adapter->default_settings;
> +
>  	/* TODO for we assume all went well */
>  	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_RESET, index, 0, NULL);
>  	return;
> @@ -2207,6 +2210,8 @@ static void proxy_added(struct l_dbus_proxy *proxy,
> void *user_data) extract_settings(proxy, &adapter->current_settings,
>  						&adapter->supported_settings);
> 
> +		adapter->default_settings = adapter->current_settings;
> +
>  		l_queue_push_tail(adapters, adapter);
>  		return;
>  	}

Patch applied, thanks.

-- 
pozdrawiam
Szymon Janc


