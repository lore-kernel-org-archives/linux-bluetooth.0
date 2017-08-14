Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] gdbus: Fix calling GetAll while GetManagedObject is pending
In-Reply-To: <20170814104602.32013-1-luiz.dentz@gmail.com>
References: <20170814104602.32013-1-luiz.dentz@gmail.com>
Date: Mon, 14 Aug 2017 10:16:53 -0700
Message-ID: <87pobydq7u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If proxies are created while the client is not ready put them into a
> pending list so only if they are not found in GetManagedObject reply
> call GetAll.
> ---
>  gdbus/client.c | 96 ++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 59 insertions(+), 37 deletions(-)
>

[...]

> @@ -424,6 +435,7 @@ static GDBusProxy *proxy_new(GDBusClient *client, const char *path,
>  							proxy->interface,
>  							properties_changed,
>  							proxy, NULL);
> +	proxy->pending = TRUE;
>
>  	return g_dbus_proxy_ref(proxy);
>  }
> @@ -478,15 +490,19 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
>  	if (client == NULL)
>  		return NULL;
>
> -	proxy = proxy_lookup(client, path, interface);
> +	proxy = proxy_lookup(client->proxy_list, path, interface);
>  	if (proxy)
>  		return g_dbus_proxy_ref(proxy);
>
> +

Extra empty line here.

>  	proxy = proxy_new(client, path, interface);
>  	if (proxy == NULL)
>  		return NULL;
>

Just that nitpick, looking good.


Cheers,
--
Vinicius
