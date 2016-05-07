Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/4] doc/gatt-api: Merge RegisterProfile with RegisterApplication
In-Reply-To: <1462561862-500-2-git-send-email-luiz.dentz@gmail.com>
References: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com> <1462561862-500-2-git-send-email-luiz.dentz@gmail.com>
Date: Sat, 07 May 2016 17:15:53 -0300
Message-ID: <87posxei9y.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Since RegisterApplication makes use of ObjectManager it is also possible
> to verify the existance of GattProfile objects unifying the API for both
> services (GATT server) and profiles (GATT client).
> ---

Just cosmetic stuff.

>  doc/gatt-api.txt    |  37 ++---
>  src/gatt-database.c | 414 +++++++++++++++++++++-------------------------------
>  2 files changed, 172 insertions(+), 279 deletions(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 683b1b7..9404986 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -218,8 +218,8 @@ Properties	string UUID [read-only]
>  				"encrypt-authenticated-read"
>  				"encrypt-authenticated-write"
>

[...]

> +static void add_profile(void *data, void *user_data)
> +{
> +	struct btd_adapter *adapter = user_data;
> +
> +	btd_profile_register(data);
> +	adapter_add_profile(adapter, data);
> +}
> +
> +static struct external_profile *create_profile(struct gatt_app *app,
> +						GDBusProxy *proxy,
> +						const char *path)
> +

Extra empty line.

> +{
> +	struct external_profile *profile;
> +	DBusMessageIter iter, array;
> +
> +	if (!path || !g_str_has_prefix(path, "/"))
> +		return NULL;
> +
> +	profile = new0(struct external_profile, 1);
> +
> +	profile->app = app;
> +	profile->proxy = g_dbus_proxy_ref(proxy);
> +	profile->profiles = queue_new();
> +
> +	if (!g_dbus_proxy_get_property(proxy, "UUIDs", &iter)) {
> +		DBG("UUIDs property not found");
> +		goto fail;
> +	}
> +
> +	dbus_message_iter_recurse(&iter, &array);
> +
> +	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
> +		const char *uuid;
> +
> +		dbus_message_iter_get_basic(&array, &uuid);
> +
> +		if (profile_add(profile, uuid) < 0)
> +			goto fail;
> +
> +		dbus_message_iter_next(&array);
> +	}
> +
> +	if (queue_isempty(profile->profiles))
> +		goto fail;
> +
> +	queue_foreach(profile->profiles, add_profile, app->database->adapter);
> +	queue_push_tail(app->profiles, profile);
> +
> +	return profile;
> +
> +fail:
> +	profile_free(profile);
> +	return NULL;
> +}
> +


Cheers,
--
Vinicius
