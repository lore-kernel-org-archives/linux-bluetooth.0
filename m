Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] profiles/network: Minor style fix
Date: Thu, 26 Feb 2015 10:32:50 +0100
Message-ID: <12182616.g15YdARg1m@uw000953>
In-Reply-To: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 19 of February 2015 15:16:34 Grzegorz Kolodziejczyk wrote:
> This patch fixes style issues e.g. line aligns, braces.
> ---
>  profiles/network/bnep.c   | 10 ++++++----
>  profiles/network/server.c | 11 +++++------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 09d4b65..70d2e56 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -506,10 +506,11 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
>  
>  	if (ioctl(sk, SIOCBRADDIF, &ifr) < 0) {
>  		err = -errno;
> -		error("bnep: Can't add %s to the bridge %s: %s(%d)",
> -					devname, bridge, strerror(-err), -err);
> -	} else
> +		error("bnep: Can't add %s to the bridge %s: %s(%d)", devname,
> +						bridge, strerror(-err), -err);

I find original code more readable(ie if all parameters fit in single line).

> +	} else {
>  		info("bridge %s: interface %s added", bridge, devname);
> +	}
>  
>  	close(sk);
>  
> @@ -539,8 +540,9 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>  		err = -errno;
>  		error("bnep: Can't delete %s from the bridge %s: %s(%d)",
>  					devname, bridge, strerror(-err), -err);
> -	} else
> +	} else {
>  		info("bridge %s: interface %s removed", bridge, devname);
> +	}
>  
>  	close(sk);
>  
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index 3fb031f..ebbe056 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -650,8 +650,7 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
>  	na = g_new0(struct network_adapter, 1);
>  	na->adapter = btd_adapter_ref(adapter);
>  
> -	na->io = bt_io_listen(NULL, confirm_event, na,
> -				NULL, &err,
> +	na->io = bt_io_listen(NULL, confirm_event, na, NULL, &err,
>  				BT_IO_OPT_SOURCE_BDADDR,
>  				btd_adapter_get_address(adapter),
>  				BT_IO_OPT_PSM, BNEP_PSM,
> @@ -697,10 +696,10 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
>  	if (g_slist_length(na->servers) > 0)
>  		goto done;
>  
> -	if (!g_dbus_register_interface(btd_get_dbus_connection(),
> -					path, NETWORK_SERVER_INTERFACE,
> -					server_methods, NULL, NULL,
> -					na, path_unregister)) {
> +	if (!g_dbus_register_interface(btd_get_dbus_connection(), path,
> +						NETWORK_SERVER_INTERFACE,
> +						server_methods, NULL, NULL, na,
> +						path_unregister)) {
>  		error("D-Bus failed to register %s interface",
>  						NETWORK_SERVER_INTERFACE);
>  		server_free(ns);
> 

-- 
Best regards, 
Szymon Janc
