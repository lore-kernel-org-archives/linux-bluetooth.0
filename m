Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05071113164320e725@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pand D-Bus service
In-Reply-To: <1121110034.5934.24.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05070811375af87810@mail.gmail.com>
	 <1120849681.7444.1.camel@notepaq>
	 <e1effdeb050711115470809e4a@mail.gmail.com>
	 <1121110034.5934.24.camel@notepaq>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Jul 2005 17:16:40 -0300

Hi Marcel,

My project goal is provide D-Bus support for pand=20
including automatic bridge creation and integration=20
with udhcp.

Setup the bt adapter is a dependency for me. bluetoothd is
the daemon that was missing for provide  adapter configuration,=20
periodic inquiry and link setup. Some services(list adapters,=20
search, role switch) are being provided by pand D-Bus.=20
I know that is a incorrect approach, but they are required.

I am running behind the schedule, there are a lot projects
(UPnP app, games) that require this feature for setup PANs.=20
Is it possible integrate the D-Bus services for pand?

After that can help you moving all code to bluetoothd.

If you what I can help you developing bluetoothd?

Regarding security, what are exactly the points that need
by improved or developed?

Regards,
Claudio.

On 7/11/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > According with your emails, bluetoothd shall provide
> > methods for settings and send signals.
> > I finished the D-Bus services for pand, now we need
> > define how organize these services.
> >
> > In my opinion the bluetoothd should be responsible for
> > provide all D-Bus services, including pand, hidd, cip, ...
> > Create D-Bus services for each daemon will require
> > monitor a lot of dbus connections. It's easier and more
> > efficient create "profile objects" for each profile inside
> > bluetoothd. Buetoothd can monitor different interfaces and
> > objects.
>=20
> this is my idea and then you can write a simple Python script and use
> all Bluetooth stuff over D-Bus. This way it should be possible to
> implement some graphical tools for using Bluetooth.
>=20
> > Currently, my D-Bus pand implementation is providing:
> >   -adapters: show local bluetooth adapters
> >   -connect:connect to a bluetooth device
> >   -connections: show active connections
> >   -disconnect: kill connections
> >   -enable-bridge: enable automatic bridge creation on listening
> >   -find: search for a service
> >   -listen: start/stop listen for bluetooth connections
> >   -role: switch the role MASTER|SLAVE
> >   -udhcp:enable UDHCP on listen or connect
> >   -init: initialize the bluez pan daemon (pand)
> >   -kill: kill the pand
> >
> >
> > If you see the code of D-Bus hcid, the D-Bus message control functions
> > are similar. The best approach is move all to daemon directory.
>=20
> The bluetoothd should handle every of these things. However the main
> focus at the moment is device configuration and the handling of security
> related stuff. I am not 100% sure about the interface, but in general I
> like to use something similar to Hal.
>=20
> Adding interfaces for PAN, HID etc. is not so important for me. Once we
> have the core stuff running, the should be really easy then.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar happen=
ing
> July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
> core and dual graphics technology at this free one hour event hosted by H=
P,
> AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
