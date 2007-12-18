Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1198011146.8815.9.camel@cookie.hadess.net>
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1197870459.8050.80.camel@aeonflux>
	<5f84803c0712170754n14d401a7l225d3d9b2f413850@mail.gmail.com>
	<1197917583.8050.87.camel@aeonflux>
	<5f84803c0712171129o770c38e5g35d57dea64be94f5@mail.gmail.com>
	<1197922624.8050.107.camel@aeonflux>
	<5f84803c0712171247t7879a8adp6d17981697396527@mail.gmail.com>
	<1197925294.8050.111.camel@aeonflux>
	<5f84803c0712181037w39132b53x1488195f71802479@mail.gmail.com>
	<1198005009.8050.185.camel@aeonflux>
	<5f84803c0712181151n258c0e6bmf237ed82be97f4f@mail.gmail.com>
	<1198007917.8050.188.camel@aeonflux>
	<1198011146.8815.9.camel@cookie.hadess.net>
Date: Tue, 18 Dec 2007 22:00:07 +0100
Message-Id: <1198011607.8050.195.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] [RESEND] make bluez GNOME UIs singletons
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Bastien,

> > > This would require defining GObject properties and get and set
> > > operations.  Also, the register function is what actually initiates
> > > the connection to the bus and requests the bus name.  This sort of
> > > operation might fail and shouldn't be done in an object constructor.
> > > The register function seemed like the simplest solution. 
> > 
> > I did it the way I think it should be done to make it a lot simpler. It
> > works, but I am not sure if it is the best way. Feel free to improve it.
> > The stuff is in the CVS now.
> 
> Chris is right, object creation should never fail.

then we should not use an object for the singleton support. The overhead
for an application to get it right is too much. The singleton support
should be as less intrusive as possible.

So maybe something like bluetooth_instance_init(...) and a corresponding
bluetooth_instance_cleanup() would be better.

This is purely from the application standpoint. If it internally uses an
BluetoothInstance object, I don't really care.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
