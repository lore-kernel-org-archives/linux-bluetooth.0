Return-Path: <cyrus@holtmann.org>
Date: Sat, 18 Aug 2012 15:14:29 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3 13/15] gdbus: Implement PropertiesChanged signal
Message-ID: <20120818181429.GA30527@echo>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1345272662-2850-14-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345272662-2850-14-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On 03:51 Sat 18 Aug, Lucas De Marchi wrote:
> ---
>  gdbus/gdbus.h  |   4 +++
>  gdbus/object.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 110 insertions(+), 2 deletions(-)

[snip]

> @@ -1397,3 +1405,99 @@ gboolean g_dbus_emit_signal_valist(DBusConnection *connection,
>  	return emit_signal_valist(connection, path, interface,
>  							name, type, args);
>  }
> +
> +static void process_properties_from_interface(struct generic_data *data,
> +						struct interface_data *iface)
> +{
> +	GSList *l;
> +	DBusMessage *signal;
> +	DBusMessageIter iter, dict, array;
> +
> +	if (iface->pending_prop == NULL)
> +		return;
> +
> +	signal = dbus_message_new_signal(data->path,
> +			DBUS_INTERFACE_PROPERTIES, "PropertiesChanged");
> +	if (signal == NULL) {
> +		error("Unable to allocate new " DBUS_INTERFACE_PROPERTIES
> +						".PropertiesChanged signal");
> +		return;
> +	}
> +
> +	iface->pending_prop = g_slist_reverse(iface->pending_prop);
> +
> +	dbus_message_iter_init_append(signal, &iter);
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,	&iface->name);
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
> +			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
> +
> +	for (l = iface->pending_prop; l != NULL; l = l->next) {
> +		GDBusPropertyTable *p = l->data;
> +
> +		if (p->get == NULL)
> +			continue;
> +
> +		if (p->exists != NULL && !p->exists(p, iface->user_data))
> +			continue;

I was thinking about if the following scenario where I want a property that
only gets notified when it changes, but I can't do Get() on it is something
that we want to support. (Yeah, using signals makes more sense for this, but
the question remains ;-))

I was with the impression that that was one of the purposes of the exists()
method.

Anyway, looks good to me.

> +
> +		append_property(iface, p, &dict);
> +	}
> +
> +	dbus_message_iter_close_container(&iter, &dict);
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +				DBUS_TYPE_STRING_AS_STRING, &array);
> +	dbus_message_iter_close_container(&iter, &array);
> +
> +	g_dbus_send_message(data->conn, signal);
> +
> +	g_slist_free(iface->pending_prop);
> +	iface->pending_prop = NULL;
> +}
> +
> +static void process_property_changes(struct generic_data *data)
> +{
> +	GSList *l;
> +
> +	for (l = data->interfaces; l != NULL; l = l->next) {
> +		struct interface_data *iface = l->data;
> +
> +		process_properties_from_interface(data, iface);
> +	}
> +
> +	data->pending_prop = FALSE;
> +}
> +
> +void g_dbus_emit_property_changed(DBusConnection *connection,
> +				const char *path, const char *interface,
> +				const char *name)
> +{
> +	const GDBusPropertyTable *property;
> +	struct generic_data *data;
> +	struct interface_data *iface;
> +
> +	if (!dbus_connection_get_object_path_data(connection, path,
> +					(void **) &data) || data == NULL)
> +		return;
> +
> +	iface = find_interface(data->interfaces, interface);
> +	if (iface == NULL)
> +		return;
> +
> +	property = find_property(iface->properties, name);
> +	if (property == NULL) {
> +		error("Could not find property %s in %p", name,
> +							iface->properties);
> +		return;
> +	}
> +
> +	data->pending_prop = TRUE;
> +	iface->pending_prop = g_slist_prepend(iface->pending_prop,
> +						(void *) property);
> +
> +	if (!data->process_id) {
> +		data->process_id = g_idle_add(process_changes, data);
> +		return;
> +	}
> +}
> -- 
> 1.7.11.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
