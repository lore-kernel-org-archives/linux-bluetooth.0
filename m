Return-Path: <cyrus@holtmann.org>
Message-ID: <1357164488.19248.92.camel@aeonflux>
Subject: Re: [PATCH 1/2] core: Replace calls to g_queue_free_full function
From: Marcel Holtmann <marcel@holtmann.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 02 Jan 2013 14:08:08 -0800
In-Reply-To: <1357162287-14216-1-git-send-email-g.gherdovich@gmail.com>
References: <1357162287-14216-1-git-send-email-g.gherdovich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Giovanni,

> The function g_queue_free_full is available only from GLib 2.32.
> If BlueZ has to build against GLib 2.28, as stated in the configure.ac,
> this patch replaces the calls to g_queue_free_full in the "core" BlueZ module
> with its body, taken from the sources of GLib 2.32.
> ---
>  src/adapter.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index e71cea8..f7fc00e 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1688,6 +1688,15 @@ int btd_adapter_stop(struct btd_adapter *adapter)
>  	return 0;
>  }
>  
> +static void g_free_wrapper(gpointer mem, gpointer dummy)
> +{
> +	/* 
> +	 * Wrapper around GLib's g_free to match the signature
> +	 * required for the second argument of g_queue_foreach.
> +	 */
> +	g_free(mem);
> +}
> +

I would have done this:

	static void free_service_auth(gpointer data, gpointer user_data)
	{
		struct service_auth *auth = data;

		g_free(auth);
	}

>  static void adapter_free(gpointer user_data)
>  {
>  	struct btd_adapter *adapter = user_data;
> @@ -1697,7 +1706,8 @@ static void adapter_free(gpointer user_data)
>  	if (adapter->auth_idle_id)
>  		g_source_remove(adapter->auth_idle_id);
>  
> -	g_queue_free_full(adapter->auths, g_free);
> +	g_queue_foreach(adapter->auths, g_free_wrapper, NULL);
> +	g_queue_free(adapter->auths);
>  
>  	sdp_list_free(adapter->services, NULL);
>  

Regards

Marcel


