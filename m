Return-Path: <cyrus@holtmann.org>
Message-ID: <1357089527.19248.88.camel@aeonflux>
Subject: Re: [PATCH 1/2] core: Replace calls to g_queue_free_full function
From: Marcel Holtmann <marcel@holtmann.org>
To: Giovanni Gherdovich <g.gherdovich@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 01 Jan 2013 17:18:47 -0800
In-Reply-To: <1357039294-8878-1-git-send-email-g.gherdovich@gmail.com>
References: <1357039294-8878-1-git-send-email-g.gherdovich@gmail.com>
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
>  src/adapter.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index e71cea8..73c9e58 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1697,7 +1697,8 @@ static void adapter_free(gpointer user_data)
>  	if (adapter->auth_idle_id)
>  		g_source_remove(adapter->auth_idle_id);
>  
> -	g_queue_free_full(adapter->auths, g_free);
> +	g_queue_foreach(adapter->auths, (GFunc)g_free, NULL);

I do not like the usage of (GFunc) casting here. Please add a function
that properly frees this and has the right signature.

> +	g_queue_free(adapter->auths);
>  
>  	sdp_list_free(adapter->services, NULL);
>  

Regards

Marcel


