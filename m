Return-Path: <hadess@hadess.net>
Message-ID: <1505925333.9350.7.camel@hadess.net>
Subject: Re: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 20 Sep 2017 18:35:33 +0200
In-Reply-To: <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org>
References: <20170920125445.24792-1-hadess@hadess.net>
	 <20170920125445.24792-2-hadess@hadess.net>
	 <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-20 at 17:48 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > The hostname plugin listens to property changes from systemd-
> > hostnamed
> > but doesn't fetch initial values. This means that unless the
> > PrettyHostname or StaticHostname changes, the default adapter will
> > be
> > called "BlueZ 5.XX" matching the version number.
> > 
> > This is the case since the hostname plugin replaced the adaptername
> > plugin in 2012.
> > 
> > Fetch the initial values for PrettyHostname, StaticHostname and
> > Chassis when the plugin is initiated, so as to make the values
> > available for adapter setup.
> > ---
> > plugins/hostname.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> > 
> > diff --git a/plugins/hostname.c b/plugins/hostname.c
> > index f876d0afb..db9187378 100644
> > --- a/plugins/hostname.c
> > +++ b/plugins/hostname.c
> > @@ -307,6 +307,10 @@ static int hostname_init(void)
> > 		hostname_proxy = NULL;
> > 		g_dbus_client_unref(hostname_client);
> > 		hostname_client = NULL;
> > +	} else {
> > +		g_dbus_proxy_refresh_property(hostname_proxy,
> > "PrettyHostname");
> > +		g_dbus_proxy_refresh_property(hostname_proxy,
> > "StaticHostname");
> > +		g_dbus_proxy_refresh_property(hostname_proxy,
> > "Chassis");
> > 	}
> 
> I am 100% certain that I tested this since this would be a really
> dumb plugin otherwise.

You don't say ;)

>  However is it possible that when calling GetManagedObjects the
> values are not returned correctly?

get_managed_objects() in gdbus/client.c is never called for this
GDBusClient.

>  Can we check that. Or does the property watch has an issue not
> calling the callback correctly.

The property watch code in add_property() and in properties_changed()
is never called either.

This is the debug I used:
https://github.com/hadess/bluez/commit/54ce125be92700f0fba64c7892d3a4296441bc7c

The only debug message I actually see after reverting the patch you're
commenting on is:
** Message: g_dbus_proxy_set_property_watch() success

Cheers
