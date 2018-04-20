Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Fix accessing NULL adv_manager
Date: Fri, 20 Apr 2018 13:37:07 +0200
Message-ID: <3639790.BHHmaqKJhx@ix>
In-Reply-To: <20180420110238.24490-1-szymon.janc@codecoup.pl>
References: <20180420110238.24490-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday, 20 April 2018 13:02:38 CEST Szymon Janc wrote:
> adv_manager might be NULL also if BR/EDR only mdoe is set in main.conf
> or if btd_adv_manager_new failed so checking for LE in supported
> settings is not enough. This also makes btd_adv_manager_refresh
> consistent with other adv_manager API regarding passing NULL manager
> as function parameter.
> ---
>  src/adapter.c     | 3 +--
>  src/advertising.c | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index f91b04173..932b2a34d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -540,8 +540,7 @@ static void settings_changed(struct btd_adapter
> *adapter, uint32_t settings) g_dbus_emit_property_changed(dbus_conn,
> adapter->path,
>  					ADAPTER_INTERFACE, "Discoverable");
>  		store_adapter_info(adapter);
> -		if (adapter->supported_settings & MGMT_SETTING_LE)
> -			btd_adv_manager_refresh(adapter->adv_manager);
> +		btd_adv_manager_refresh(adapter->adv_manager);
>  	}
> 
>  	if (changed_mask & MGMT_SETTING_BONDABLE) {
> diff --git a/src/advertising.c b/src/advertising.c
> index b976562c4..0cb6eac3a 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1173,6 +1173,9 @@ void btd_adv_manager_destroy(struct btd_adv_manager
> *manager)
> 
>  void btd_adv_manager_refresh(struct btd_adv_manager *manager)
>  {
> +	if (!manager)
> +		return;
> +
>  	queue_foreach(manager->clients, (queue_foreach_func_t)refresh_adv,
>  									NULL);
>  }

Applied.

-- 
pozdrawiam
Szymon Janc


