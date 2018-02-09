Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Remove spurious propery change signal
Date: Fri, 09 Feb 2018 15:39:09 +0100
Message-ID: <1999580.8F7ljUYkF6@ix>
In-Reply-To: <20180208160306.15837-1-szymon.janc@codecoup.pl>
References: <20180208160306.15837-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday, 8 February 2018 17:03:06 CET Szymon Janc wrote:
> There is no "Connectable" property on Adapter1 interface.
> ---
>  src/adapter.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 50cf46b11..93e36d00d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -535,10 +535,6 @@ static void settings_changed(struct btd_adapter
> *adapter, uint32_t settings) trigger_passive_scanning(adapter);
>  	}
> 
> -	if (changed_mask & MGMT_SETTING_CONNECTABLE)
> -		g_dbus_emit_property_changed(dbus_conn, adapter->path,
> -					ADAPTER_INTERFACE, "Connectable");
> -
>  	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
>  		g_dbus_emit_property_changed(dbus_conn, adapter->path,
>  					ADAPTER_INTERFACE, "Discoverable");

Applied.

-- 
pozdrawiam
Szymon Janc


