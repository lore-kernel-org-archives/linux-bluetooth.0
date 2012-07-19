Return-Path: <cyrus@holtmann.org>
Message-ID: <1342685013.24426.7.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/5] gdbus: Add skeleton of DBus.Properties
 interface
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Jul 2012 10:03:33 +0200
In-Reply-To: <1342668008-5522-2-git-send-email-lucas.demarchi@profusion.mobi>
References: <1342668008-5522-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1342668008-5522-2-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> This interface is responsible for handling properties of all objects in
> a given path. Right now it only registers itself, doing nothing useful.
> A conversion to this new layout will be done by subsequent patches.
> 
> org.freedesktop.org.DBus.Properties spec can be found at
> http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties
> ---
>  gdbus/object.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 900e7ab..72f77d4 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -491,6 +491,50 @@ static const GDBusMethodTable introspect_methods[] = {
>  	{ }
>  };
>  
> +static DBusMessage *properties_get(DBusConnection *connection,
> +					DBusMessage *message, void *user_data)
> +{
> +	return NULL;
> +}
> +
> +static DBusMessage *properties_get_all(DBusConnection *connection,
> +					DBusMessage *message, void *user_data)
> +{
> +	return NULL;
> +}
> +
> +static DBusMessage *properties_set(DBusConnection *connection,
> +					DBusMessage *message, void *user_data)
> +{
> +	return NULL;
> +}
> +
> +static const GDBusMethodTable properties_methods[] = {
> +	{ GDBUS_METHOD("Get",
> +			GDBUS_ARGS({ "interface_name", "s" },
> +						{ "property_name", "s" }),

this should be "interface" and "name". Why are we so verbose here?

> +			GDBUS_ARGS({ "value", "v" }),
> +			properties_get) },
> +	{ GDBUS_METHOD("Set", NULL,
> +			GDBUS_ARGS({ "interface_name", "s" },
> +					{ "property_name", "s" },
> +					{ "value", "v" }),
> +			properties_set) },
> +	{ GDBUS_METHOD("GetAll",
> +			GDBUS_ARGS({ "interface_name", "s" }),
> +			GDBUS_ARGS({ "props", "a{sv}" }),

And this should be "properties". Here you are trying to be super short.

> +			properties_get_all) },
> +	{ }
> +};
> +
> +static const GDBusSignalTable properties_signals[] = {
> +	{ GDBUS_SIGNAL("PropertiesChanged",
> +			GDBUS_ARGS({ "interface_name", "s" },
> +					{ "changed_properties", "a{sv}" },
> +					{ "invalidated_properties", "as"})) },
> +	{ }
> +};
> +
>  static void add_interface(struct generic_data *data, const char *name,
>  				const GDBusMethodTable *methods,
>  				const GDBusSignalTable *signals,
> @@ -541,6 +585,9 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
>  	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE,
>  			introspect_methods, NULL, NULL, data, NULL);
>  
> +	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
> +					properties_signals, NULL, data, NULL);
> +
>  	return data;
>  }
>  
> @@ -580,6 +627,7 @@ static void object_path_unref(DBusConnection *connection, const char *path)
>  		return;
>  
>  	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
> +	remove_interface(data, DBUS_INTERFACE_PROPERTIES);
>  
>  	invalidate_parent_data(connection, path);
>  

Regards

Marcel


