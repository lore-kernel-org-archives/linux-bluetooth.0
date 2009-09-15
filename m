Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add introspection interface to the output of
 introspection calls.
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: =?ISO-8859-1?Q?RISK=D3?= Gergely <gergely@risko.hu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Context Devel mailing list <context-devel@projects.maemo.org>
In-Reply-To: <20090915152240.GA4378@jh-x301>
References: <87eiqq3ge7.fsf@bubble.risko.hu>
	 <87k50hoee1.fsf@bubble.risko.hu>
	 <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	 <87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301>
	 <871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301>
	 <2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com>
	 <87ws40e6iz.fsf@bubble.risko.hu>  <20090915152240.GA4378@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Sep 2009 10:27:05 -0700
Message-Id: <1253035625.28416.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The general idea of the patch looks good but there are a few things I'd
> still fix:
> 
> On Tue, Sep 15, 2009, RISKÓ Gergely wrote:
> > -static DBusHandlerResult introspect(DBusConnection *connection,
> > -				DBusMessage *message, struct generic_data *data)
> > +static DBusMessage *introspect(DBusConnection *connection,
> > +				DBusMessage *message, void *data_)
> 
> s/data_/user_data/ (to conform to the rest of the code and glib
> conventions)
> 
> > +	struct generic_data *data = (struct generic_data *) data_;
> 
> Unnecessary explicit type-cast of a void pointer.
> 
> >  static struct generic_data *object_path_ref(DBusConnection *connection,
> >  							const char *path)
> >  {
> >  	struct generic_data *data;
> > +	struct interface_data *iface;
> >  
> >  	if (dbus_connection_get_object_path_data(connection, path,
> >  						(void *) &data) == TRUE) {
> > @@ -363,12 +355,23 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
> >  
> >  	invalidate_parent_data(connection, path);
> >  
> > +	/* Register the introspection interface */
> > +	iface = g_new0(struct interface_data, 1);
> > +	iface->name = g_strdup("org.freedesktop.DBus.Introspectable"); // TODO: macro
> 
> Either add the macro or remove this comment. Also, we don't use C++ style
> commenting.
> 
> > +	iface->methods = introspect_methods;
> > +	iface->signals = NULL;
> > +	iface->properties = NULL;
> > +	iface->user_data = data;
> > +	iface->destroy = NULL;
> > +	data->interfaces = g_slist_append(data->interfaces, iface);
> > +
> 
> Instead of this duplicate interface initialization code I think it would
> make sense to refactor and create a new private function, e.g
> 
> static void add_interface(struct generic_cata *data, ...
> 
> and call that from the necessary places (afaics there are two of them)
> 
> > +	/* Free the introspection interface */
> > +	iface = find_interface(data->interfaces, "org.freedesktop.DBus.Introspectable");
> > +	if (iface) {
> > +		data->interfaces = g_slist_remove(data->interfaces, iface);
> > +
> > +		if (iface->destroy)
> > +			iface->destroy(iface->user_data);
> > +
> > +		g_free(iface->name);
> > +		g_free(iface);
> 
> Would it make sense to refactor create a remove_interface function for
> this too (to balance with the add_interface function)?

what are we gaining from doing it like this? I really don't see the
benefit of doing it. Someone please explain it to me. It does add more
code than it deletes.

Regards

Marcel


