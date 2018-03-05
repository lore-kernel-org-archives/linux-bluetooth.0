Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/9] tools/btpclient: Fix setting supported includes includes
Date: Mon, 05 Mar 2018 09:48:47 +0100
Message-ID: <2806931.uzD6t9JXx9@ix>
In-Reply-To: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180228124129.25851-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday, 28 February 2018 13:41:21 CET Grzegorz Kolodziejczyk wrote:
> Included values should be string type instead of address of pointer to
> string.
> ---
>  tools/btpclient.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 61bde820e..d37232f07 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -888,19 +888,19 @@ static bool ad_includes_getter(struct l_dbus *dbus,
>  	if (ad.tx_power) {
>  		const char *str = "tx-power";
> 
> -		l_dbus_message_builder_append_basic(builder, 's', &str);
> +		l_dbus_message_builder_append_basic(builder, 's', str);
>  	}
> 
>  	if (ad.name) {
>  		const char *str = "local-name";
> 
> -		l_dbus_message_builder_append_basic(builder, 's', &str);
> +		l_dbus_message_builder_append_basic(builder, 's', str);
>  	}
> 
>  	if (ad.appearance) {
>  		const char *str = "appearance";
> 
> -		l_dbus_message_builder_append_basic(builder, 's', &str);
> +		l_dbus_message_builder_append_basic(builder, 's', str);
>  	}
> 
>  	l_dbus_message_builder_leave_array(builder);

All patches applied (after fixing commit message in patch 5 and dead code in 
last patch). Thanks.

-- 
pozdrawiam
Szymon Janc


