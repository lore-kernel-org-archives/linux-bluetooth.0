Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Feb 2014 10:33:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: Re: [PATCH BlueZ v7 07/11] gatt: Add external services tracking
Message-ID: <20140224083344.GA29475@x220.p-661hnu-f1>
References: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
 <1392835893-6723-8-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392835893-6723-8-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Feb 19, 2014, Claudio Takahasi wrote:
> From: Alvaro Silva <alvaro.silva@openbossa.org>
> 
> All primary services declarations provided by an external application
> will be automatically inserted in the attribute database.
> ---
>  src/gatt-dbus.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)

I've applied patches 1-6 but this one seems a bit strange.

> +static void proxy_added(GDBusProxy *proxy, void *user_data)
> +{
> +	struct external_app *eapp = user_data;
> +	const char *interface, *path;
> +
> +	interface = g_dbus_proxy_get_interface(proxy);
> +	path = g_dbus_proxy_get_path(proxy);
> +
> +	DBG("path %s iface %s", path, interface);
> +
> +	if (g_strcmp0(interface, SERVICE_IFACE) != 0)
> +		return;
> +
> +	eapp->proxies = g_slist_append(eapp->proxies, proxy);
> +}
> +
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +	struct external_app *eapp = user_data;
> +	const char *interface, *path;
> +
> +	interface = g_dbus_proxy_get_interface(proxy);
> +	path = g_dbus_proxy_get_path(proxy);
> +
> +	DBG("path %s iface %s", path, interface);
> +
> +	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
> +}
> +
> +

Double empty line above - please fix (not related to my main issue with
this patch though)

> +static gboolean finish_register(gpointer user_data)
> +{
> +	struct external_app *eapp = user_data;
> +	GSList *list;
> +
> +	/*
> +	 * It is not possible to detect when the last proxy object
> +	 * was reported. "Proxy added" handler reports objects
> +	 * added on demand or returned by GetManagedObjects().
> +	 * This timer helps to register all the GATT declarations
> +	 * (services, characteristics and descriptors) after fetching
> +	 * all the D-Bus objects.
> +	 */
> +
> +	eapp->register_timer = 0;
> +
> +	for (list = eapp->proxies; list; list = g_slist_next(list)) {
> +		const char *interface, *path;
> +		GDBusProxy *proxy = list->data;
> +
> +		interface = g_dbus_proxy_get_interface(proxy);
> +		path = g_dbus_proxy_get_path(proxy);
> +
> +		if (g_strcmp0(SERVICE_IFACE, interface) != 0)
> +			continue;
> +
> +		if (g_strcmp0(path, eapp->path) != 0)
> +			continue;
> +
> +		if (register_external_service(proxy) < 0) {
> +			DBG("Inconsistent external service: %s", path);
> +			continue;
> +		}
> +
> +		DBG("External service: %s", path);
> +	}
> +
> +	return FALSE;
> +}

This whole timer thing seems too hackish to me.

A better way to fix this might be to have something like
g_dbus_client_set_proxies_complete_watch (or some better name) to let
the code wait until GetManagedObjects has returned and the initial
proxies added. Do you agree?

Johan
