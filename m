Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Sep 2009 14:39:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?RISK=D3?= Gergely <gergely@risko.hu>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
Message-ID: <20090916113959.GA4314@jh-x301>
References: <87k50hoee1.fsf@bubble.risko.hu> <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com> <87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301> <871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301> <2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com> <87ws40e6iz.fsf@bubble.risko.hu> <20090915152240.GA4378@jh-x301> <87eiq7du6t.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87eiq7du6t.fsf@bubble.risko.hu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gregely,

On Wed, Sep 16, 2009, RISKÓ Gergely wrote:
> Diffstat says 58 insertions, 43 deletions, I think the extra 15 lines
> really worth that bluez no longer treats the introspection as a very
> specific interface.

Looks good to me, except for the following (rather minor) issues:

> +static void add_interface(struct generic_data *data, const char *name,
> +			     GDBusMethodTable *methods,
> +			     GDBusSignalTable *signals,
> +			     GDBusPropertyTable *properties,
> +			     void *user_data,
> +			     GDBusDestroyFunction destroy)

There seems to be mixed tabs & spaces here for indentation. Can you
confirm this? We only use tabs for indentation in BlueZ (which I believe
is also the usual kernel coding style).

> +static gboolean remove_interface(struct generic_data *data, const char *name)
> +{
> +	struct interface_data *iface;
> +
> +	iface = find_interface(data->interfaces, name);
> +	if (iface) {
> +		data->interfaces = g_slist_remove(data->interfaces, iface);
> +
> +		if (iface->destroy)
> +			iface->destroy(iface->user_data);
> +
> +		g_free(iface->name);
> +		g_free(iface);
> +		return TRUE;
> +	} else
> +		return FALSE;
> +}

Marcel usually likes to do this as follows (and I agree with him):

iface = find_interface(data->interfaces, name);
if (!iface)
	return FALSE;

...rest of the code...

return TRUE;

That saves you one level of indentation for most of the function and could
be considered also esier to read.

With those things fixed I think this is now up to Marcel whether he agrees
with the change. In my opinion, even though it increases the total line
count it still makes the code look nicer/cleaner since it removes the
special casing for the introspection. E.g. one added benefit that wasn't
previously mentioned is that now g_dbus_register_interface will correctly
return an error if someone tries to register the introspection interface
themselves.

Johan
