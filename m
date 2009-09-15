Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Sep 2009 18:22:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?RISK=D3?= Gergely <gergely@risko.hu>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
Message-ID: <20090915152240.GA4378@jh-x301>
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu> <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com> <87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301> <871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301> <2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com> <87ws40e6iz.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87ws40e6iz.fsf@bubble.risko.hu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The general idea of the patch looks good but there are a few things I'd
still fix:

On Tue, Sep 15, 2009, RISKÓ Gergely wrote:
> -static DBusHandlerResult introspect(DBusConnection *connection,
> -				DBusMessage *message, struct generic_data *data)
> +static DBusMessage *introspect(DBusConnection *connection,
> +				DBusMessage *message, void *data_)

s/data_/user_data/ (to conform to the rest of the code and glib
conventions)

> +	struct generic_data *data = (struct generic_data *) data_;

Unnecessary explicit type-cast of a void pointer.

>  static struct generic_data *object_path_ref(DBusConnection *connection,
>  							const char *path)
>  {
>  	struct generic_data *data;
> +	struct interface_data *iface;
>  
>  	if (dbus_connection_get_object_path_data(connection, path,
>  						(void *) &data) == TRUE) {
> @@ -363,12 +355,23 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
>  
>  	invalidate_parent_data(connection, path);
>  
> +	/* Register the introspection interface */
> +	iface = g_new0(struct interface_data, 1);
> +	iface->name = g_strdup("org.freedesktop.DBus.Introspectable"); // TODO: macro

Either add the macro or remove this comment. Also, we don't use C++ style
commenting.

> +	iface->methods = introspect_methods;
> +	iface->signals = NULL;
> +	iface->properties = NULL;
> +	iface->user_data = data;
> +	iface->destroy = NULL;
> +	data->interfaces = g_slist_append(data->interfaces, iface);
> +

Instead of this duplicate interface initialization code I think it would
make sense to refactor and create a new private function, e.g

static void add_interface(struct generic_cata *data, ...

and call that from the necessary places (afaics there are two of them)

> +	/* Free the introspection interface */
> +	iface = find_interface(data->interfaces, "org.freedesktop.DBus.Introspectable");
> +	if (iface) {
> +		data->interfaces = g_slist_remove(data->interfaces, iface);
> +
> +		if (iface->destroy)
> +			iface->destroy(iface->user_data);
> +
> +		g_free(iface->name);
> +		g_free(iface);

Would it make sense to refactor create a remove_interface function for
this too (to balance with the add_interface function)?

Johan
