Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH BlueZ v0 1/9] gdbus: Add g_dbus_client_set_proxies_ready_watch()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393607136-16908-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 4 Mar 2014 22:37:08 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F4FB24C3-8BD8-4415-AF9D-E97FEBB06781@holtmann.org>
References: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org> <1393607136-16908-2-git-send-email-claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> This patch adds a new gdbus helper to notify the clients that
> GetManagedObjects reply was received and the last proxy has been
> informed previously by the proxy_added callback.
> ---
> gdbus/client.c | 18 ++++++++++++++++++
> gdbus/gdbus.h  |  4 ++++
> 2 files changed, 22 insertions(+)
> 
> diff --git a/gdbus/client.c b/gdbus/client.c
> index be8cc29..f479742 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -56,6 +56,8 @@ struct GDBusClient {
> 	void *signal_data;
> 	GDBusProxyFunction proxy_added;
> 	GDBusProxyFunction proxy_removed;
> +	GDBusClientReadyFunction ready;
> +	void *ready_data;
> 	GDBusPropertyFunction property_changed;
> 	void *user_data;
> 	GList *proxy_list;
> @@ -982,6 +984,9 @@ static void parse_managed_objects(GDBusClient *client, DBusMessage *msg)
> 
> 		dbus_message_iter_next(&dict);
> 	}
> +
> +	if (client->ready)
> +		client->ready(client->ready_data);
> }
> 
> static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
> @@ -1261,3 +1266,16 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
> 
> 	return TRUE;
> }
> +
> +gboolean g_dbus_client_set_proxies_ready_watch(GDBusClient *client,
> +						GDBusClientReadyFunction ready,
> +						void *user_data)
> +{
> +	if (client == NULL)
> +		return FALSE;
> +
> +	client->ready = ready;
> +	client->ready_data = user_data;
> +
> +	return TRUE;
> +}
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index 9542109..aa407aa 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -337,6 +337,7 @@ gboolean g_dbus_proxy_method_call(GDBusProxy *proxy, const char *method,
> 				GDBusReturnFunction function, void *user_data,
> 				GDBusDestroyFunction destroy);
> 
> +typedef void (* GDBusClientReadyFunction) (void *user_data);
> typedef void (* GDBusProxyFunction) (GDBusProxy *proxy, void *user_data);
> typedef void (* GDBusPropertyFunction) (GDBusProxy *proxy, const char *name,
> 					DBusMessageIter *iter, void *user_data);
> @@ -365,6 +366,9 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
> 					GDBusProxyFunction proxy_removed,
> 					GDBusPropertyFunction property_changed,
> 					void *user_data);
> +gboolean g_dbus_client_set_proxies_ready_watch(GDBusClient *client,
> +						GDBusClientReadyFunction ready,
> +						void *user_data);

this names is a bit confusing. On one hand it is proxies ready on the other it is client ready. We need to be a bit specific here.

My initial thinking is this should be

	g_dbus_client_set_ready_watch()

and then use GDBusClientFunction(GDBusClient, user_data) as callback function.

Regards

Marcel

