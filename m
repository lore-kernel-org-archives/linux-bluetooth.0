Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/12] profiles/network: Minor style fix
Date: Mon, 02 Mar 2015 13:12:04 +0100
Message-ID: <2115161.2GRNqdNpiW@uw000953>
In-Reply-To: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 26 of February 2015 12:53:23 Grzegorz Kolodziejczyk wrote:
> This patch fixes style issues e.g. line aligns, braces.
> ---
>  profiles/network/bnep.c   |  6 ++++--
>  profiles/network/server.c | 11 +++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 09d4b65..e3a2b89 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -508,8 +508,9 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
>  		err = -errno;
>  		error("bnep: Can't add %s to the bridge %s: %s(%d)",
>  					devname, bridge, strerror(-err), -err);
> -	} else
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

Patches 1 and 2 are now applied, thanks. 

-- 
Best regards, 
Szymon Janc
