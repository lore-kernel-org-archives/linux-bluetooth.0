Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix adapter drivers unload order
From: Bastien Nocera <hadess@hadess.net>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Date: Fri, 18 Mar 2011 11:43:57 +0000
In-Reply-To: <1300436729-3578-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1300436729-3578-1-git-send-email-dmitriy.paliy@nokia.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1300448640.2478.0.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2011-03-18 at 10:25 +0200, Dmitriy Paliy wrote:
> Order of unloading drivers shell be preserved as given in
> audio_manager_exit. It was reverted in 'c772636 Fix unloading of adapter
> drivers', which causes in turn bluetoothd crash on exit.
> 
> Removing of media end-point results in removing of A2DP end-point for
> the corresponding A2DP server but not vice versa. Therefore, unregistering
> and destroying A2DP server, which clears all A2DP end-points, before media
> server is incorrect.
> ---
>  src/adapter.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 8c368fe..9fa7c4d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2258,8 +2258,8 @@ static void probe_driver(struct btd_adapter *adapter, gpointer user_data)
>  		return;
>  	}
>  
> -	adapter->loaded_drivers = g_slist_prepend(adapter->loaded_drivers,
> -									driver);
> +	adapter->loaded_drivers = g_slist_append(adapter->loaded_drivers,
> +								driver);

That's usually g_slist_prepend() followed by a g_slist_reverse(), not a
g_slist_append().

>  }
>  
>  static void load_drivers(struct btd_adapter *adapter)


