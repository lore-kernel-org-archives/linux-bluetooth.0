Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Jul 2010 20:25:06 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Zhenhua Zhang <zhenhua.zhang@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] bluetooth: Add reference count for bluetooth utils
Message-ID: <20100731232506.GC29039@vigoh>
References: <1280387901-8581-1-git-send-email-zhenhua.zhang@intel.com>
 <1280387901-8581-2-git-send-email-zhenhua.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280387901-8581-2-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhenhua,

* Zhenhua Zhang <zhenhua.zhang@intel.com> [2010-07-29 15:18:16 +0800]:

> Add bluetooth_ref()/bluetooth_unref() to support reference count in
> bluetooth utils.
> ---
>  plugins/bluetooth.c |   62 +++++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 5a85eaa..10cc49d 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -39,6 +39,7 @@
>  static DBusConnection *connection;
>  static GHashTable *uuid_hash = NULL;
>  static GHashTable *adapter_address_hash = NULL;
> +static gint ref_count;
>  
>  void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
>  				char *buf, int size)
> @@ -503,13 +504,10 @@ static guint adapter_added_watch;
>  static guint adapter_removed_watch;
>  static guint property_watch;
>  
> -int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *profile)
> +static int bluetooth_init()
>  {
>  	int err;
>  
> -	if (uuid_hash)
> -		goto done;
> -
>  	connection = ofono_dbus_get_connection();
>  
>  	bluetooth_watch = g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
> @@ -542,13 +540,6 @@ int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *profile)
>  	adapter_address_hash = g_hash_table_new_full(g_str_hash, g_str_equal,
>  						g_free, g_free);
>  
> -done:
> -	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
> -
> -	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> -				manager_properties_cb, NULL, NULL, -1,
> -				DBUS_TYPE_INVALID);
> -
>  	return 0;
>  
>  remove:
> @@ -556,14 +547,27 @@ remove:
>  	g_dbus_remove_watch(connection, adapter_added_watch);
>  	g_dbus_remove_watch(connection, adapter_removed_watch);
>  	g_dbus_remove_watch(connection, property_watch);
> +
>  	return err;
>  }
>  
> -void bluetooth_unregister_uuid(const char *uuid)
> +static int bluetooth_ref()
>  {
> -	g_hash_table_remove(uuid_hash, uuid);
> +	g_atomic_int_inc(&ref_count);
> +
> +	if (ref_count > 1)
> +		return 0;
> +
> +	return bluetooth_init();
> +}
> +
> +static void bluetooth_unref()
> +{
> +	gboolean is_zero;
> +
> +	is_zero = g_atomic_int_dec_and_test(&ref_count);
>  
> -	if (g_hash_table_size(uuid_hash))
> +	if (is_zero == FALSE)
>  		return;

We can remove the is_zero variable, and test g_atomic_int_dec_and_test()
directly. What do you think?

>  
>  	g_dbus_remove_watch(connection, bluetooth_watch);
> @@ -571,9 +575,33 @@ void bluetooth_unregister_uuid(const char *uuid)
>  	g_dbus_remove_watch(connection, adapter_removed_watch);
>  	g_dbus_remove_watch(connection, property_watch);
>  
> -	g_hash_table_destroy(uuid_hash);
> -	g_hash_table_destroy(adapter_address_hash);
> -	uuid_hash = NULL;
> +	if (uuid_hash)
> +		g_hash_table_destroy(uuid_hash);
> +
> +	if (adapter_address_hash)
> +		g_hash_table_destroy(adapter_address_hash);
> +}
> +
> +int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *profile)
> +{
> +	int err = bluetooth_ref();
> +
> +	if (err != 0)
> +		return err;
> +
> +	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
> +
> +	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
> +				manager_properties_cb, NULL, NULL, -1,
> +				DBUS_TYPE_INVALID);
> +	return 0;
> +}
> +
> +void bluetooth_unregister_uuid(const char *uuid)
> +{
> +	g_hash_table_remove(uuid_hash, uuid);
> +
> +	bluetooth_unref();
>  }
>  
>  OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
