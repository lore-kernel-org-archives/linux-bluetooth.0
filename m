Return-Path: <hadess@hadess.net>
Message-ID: <1506085983.9350.33.camel@hadess.net>
Subject: Re: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 22 Sep 2017 15:13:03 +0200
In-Reply-To: <CABBYNZLeNiw_5A_mBbLm6Uq2B-8+KEhuMKAsVerSAKeS3WbE+g@mail.gmail.com>
References: <20170920125445.24792-1-hadess@hadess.net>
	 <20170920125445.24792-2-hadess@hadess.net>
	 <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org>
	 <1505925333.9350.7.camel@hadess.net>
	 <6DC51AD5-E9D5-4874-AAA8-38A4BF7C1668@holtmann.org>
	 <CABBYNZLeNiw_5A_mBbLm6Uq2B-8+KEhuMKAsVerSAKeS3WbE+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-20 at 21:57 +0300, Luiz Augusto von Dentz wrote:
> H Bastien,
> 
> On Wed, Sep 20, 2017 at 7:59 PM, Marcel Holtmann <marcel@holtmann.org
> > wrote:
> > Hi Bastien,
> > 
> > > > > The hostname plugin listens to property changes from systemd-
> > > > > hostnamed
> > > > > but doesn't fetch initial values. This means that unless the
> > > > > PrettyHostname or StaticHostname changes, the default adapter
> > > > > will
> > > > > be
> > > > > called "BlueZ 5.XX" matching the version number.
> > > > > 
> > > > > This is the case since the hostname plugin replaced the
> > > > > adaptername
> > > > > plugin in 2012.
> > > > > 
> > > > > Fetch the initial values for PrettyHostname,StaticHostname
> > > > > and
> > > > > Chassis when the plugin is initiated, so as to make the
> > > > > values
> > > > > available for adapter setup.
> > > > > ---
> > > > > plugins/hostname.c | 4 ++++
> > > > > 1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git a/plugins/hostname.c b/plugins/hostname.c
> > > > > index f876d0afb..db9187378 100644
> > > > > --- a/plugins/hostname.c
> > > > > +++ b/plugins/hostname.c
> > > > > @@ -307,6 +307,10 @@ static int hostname_init(void)
> > > > >             hostname_proxy = NULL;
> > > > >             g_dbus_client_unref(hostname_client);
> > > > >             hostname_client = NULL;
> > > > > +   } else {
> > > > > +           g_dbus_proxy_refresh_property(hostname_proxy,
> > > > > "PrettyHostname");
> > > > > +           g_dbus_proxy_refresh_property(hostname_proxy,
> > > > > "StaticHostname");
> > > > > +           g_dbus_proxy_refresh_property(hostname_proxy,
> > > > > "Chassis");
> > > > >     }
> > > > 
> > > > I am 100% certain that I tested this since this would be a
> > > > really
> > > > dumb plugin otherwise.
> > > 
> > > You don't say ;)
> > > 
> > > > However is it possible that when calling GetManagedObjects the
> > > > values are not returned correctly?
> > > 
> > > get_managed_objects() in gdbus/client.c is never called for this
> > > GDBusClient.
> 
> I guess this can only occur if the bus name does not exist, perhaps
> it
> has not been activated yet, that would explain why calling refresh
> would work since that activate the bus name. I wonder if GetNameOwner
> is not enough to activate a service?

It's not enough, GetNameOwner is a call to the daemon, the service
isn't involved at all. You need to start it by hand.

A few bindings will allow you to choose whether to autostart the
service if the target service doesn't exist when calling remote
methods.

>  Well perhaps we should use
> StartServiceByName then but it doesn't return the bus id so it only
> works if the service has activated since we have subscribed to
> NameOwnerChanged but in case it is already running we still have to
> call GetNameOwner. Btw is this running with dbus-daemon or the new
> dbus-broker? Perhaps the later doesn't active things in the same way
> dbus-daemon would.

It goes without saying that I wouldn't be sending bug reports like this
one if I was using dbus-broker.

The plugin seems to work correctly in
df0ad3ecb625b5968522acce8b7d33d68f30b4cb (plus build fixes), and
systemd-hostnamed is autostarted.

I tried bisecting, but ended up screwing up at some point, and didn't
fancy restarting again (after about 15 iterations, and having to
cherry-pick different build fixes every time, sigh), so I started
testing individual releases.

(4 other working versions)
5.46 works
5.47 fails

And after that:
ef024c2c44b4f0dab3c054d062a911cacef1fdc9 is the first bad commit
commit ef024c2c44b4f0dab3c054d062a911cacef1fdc9
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Aug 11 15:39:15 2017 +0300

    gdbus: Fix calling GetAll while GetManagedObjects is pending
    
    If proxies are created while the client is not ready put them into a
    pending list so only if they are not found in GetManagedObject reply
    call GetAll.

:040000 040000 01462de94f24f0f561aab0be34bcfc0935718da7 6917c7faea1135c53fc1d8d9d43d6347952e5d40 M	gdbus

Cheers
