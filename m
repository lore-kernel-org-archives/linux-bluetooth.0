Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1405934433-29723-1-git-send-email-bharat.panda@samsung.com>
 <20140721094355.GA29317@t440s.lan>
 <00c501cfa4d9$77fc36b0$67f4a410$@samsung.com>
 <20140722080045.GC25167@t440s.lan>
In-reply-to: <20140722080045.GC25167@t440s.lan>
Subject: RE: [PATCH ] tools: Add unregister gatt service
Date: Thu, 24 Jul 2014 14:38:39 +0530
Message-id: <00e101cfa71e$dc9cba30$95d62e90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > > +static int id;
> > > > +
> > > >  struct characteristic {
> > > >  	char *uuid;
> > > >  	char *path;
> > > > @@ -332,10 +334,10 @@ static gboolean
> > > > register_characteristic(const char *chr_uuid,
> > > >
> > > >  static char *register_service(const char *uuid)  {
> > > > -	static int id = 1;
> > >
> > > Making id public looks unnecessary to me since after the
> > > registration you've got the path which you can pass to the
> > > unregistration procedure.
> >
> > The id was made public, because service path was not public. We need
> > to make either id or service path as public to unregister interface
> > path.
> 
> Can't you just pass it as user_data to unregister_external_service_reply?

Yes, I will modify it accordingly.
> 
> > > >  static gboolean signal_handler(GIOChannel *channel, GIOCondition
> cond,
> > > >  							gpointer
user_data)
> > > >  {
> > > > @@ -524,6 +596,7 @@ int main(int argc, char *argv[])
> > > >  	client = g_dbus_client_new(connection, "org.bluez",
> > > > "/org/bluez");
> > > >
> > > >  	g_dbus_client_set_connect_watch(client, connect_handler,
NULL);
> > > > +	g_dbus_client_set_disconnect_watch(client,
disconnect_handler,
> > > > +NULL);
> > >
> > > When exactly would disconnect_handler be called in practice? At
> > > least one case seems to be if bluetoothd exits in which case it
> > > seems quite wasteful to try to make any method calls to a
> > > non-existing service. What other scenarios would disconnect_handler
> > > be called in?
> >
> > On running the gatt-service, it registers the service and updates gatt
> > db with the service path.
> > On exiting the gatt-service, it should call "UnregisterService" and
> > clear the gatt service db.
> 
> How exactly does gatt-service exit? If it stops iterating the main loop
your D-
> Bus reply callback would never get called and most of the new code you're
> adding would never get run.

The gatt-service exits on IO interrupts, I have checked gatt-dbus.c, it
cleans up the client db on client disconnect.
So there should not be any disconnect handler for the same in
gatt-service.c. 

> 
> > Otherwise, on next run of gatt-service, when it registers the same
> > service path, it gets an error, service already exists.
> 
> bluetoothd should monitor all of its clients and clean up after them if
they
> exit without unregistering. If that's not happening then it's a bug that's
much
> more important to fix than what you're trying to do here. A quick look at
> src/gatt-dbus.c shows that it's at least trying to clean up, but maybe
there's a
> bug somewhere there.
To register and unregister multiple services, if gatt-service can be
modified so that it provides choice to user for registering/unregistering
multiple time.
Please suggest, if we can add switch case options to iterate through
resgister/unregister service as per the data input to gatt-service.

#gatt-service
Usage: gatt-service [Register/Unregister] [options]

Options:
	Service_UUID
	Included_serv_UUID
	Char_UUID
	Char value
	Desc UUID
	Desc value
Unregister:
	Service_UUID
 
Best Regards,
Bharat

