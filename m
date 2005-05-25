Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050525152067a5cbd3@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1116925644.30044.140.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
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
Date: Wed, 25 May 2005 19:20:34 -0300

Hi Marcel,

A new patch is available in the link below:
http://www.indt.org.br/maemo/bluez/


The DBUS.TXT file contains information to run the sample and
how configure the service.

Suggestions and comments are welcome!

Regards,
Claudio.


On 5/24/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > Regarding our suggestion about the service name. I consider the
> > following basic features essential to establish and control connections=
:
> > * Search for a service (provided by sdptool)
> > * Display local devices (provided by hcitool)
> > * Switch master/slave role (provided by hcitool)
> > * Listen for PAN connections (provided by pand)
> > * Connect (provided by pand)
> > * Disconnect  (provided by pand)
> > * Display active connections  (provided by pand)
> >
> > According to D-BUS specification  when messages are received over a
> > D-BUS connection,
> > they are sent to a specific object, not to the application as a whole.
> > Each object supports
> > one or more interfaces.
> >
> > We have two options:
> > 1. define one object with only one interface
> >     eg:
> >         object:org.bluez.pand
> >         interface:org.bluez.pand
> > 2. define one object with multiple interfaces
> >     eg:
> >         object:org.bluez.pand
> >         interface: org.bluez.pand
> >         interface: org.bluez.sdp
> >         interface: org.bluez.hci
> >
> > For the both cases, pand will be the daemon responsible for
> > provide this interfaces/services.
> > What approach do you preffer?
> > The last alternative is better because it is possible define more
> > detailed rules in the dbus configuration file.
>=20
> this might be, but until we don't fully understand what functionality we
> need to provide over D-Bus I like to go with 1). In general the first
> version of an API sucks and I don't wanna spread it over different
> interfaces and have to deprecate them.
>=20
> > Another point is the header for dbus services, the client application
> > must know the message format, therefore the header file(dbus_services.h=
)
> > will be required. In the future, develop a library hidding D-BUS messag=
e
> > details is a better option.
>=20
> Then make it dbus.h for the service definitions and move the rest into
> dbus.c and the function declaration into pand.h. For now copy the dbus.h
> to the client application and we will sort out the details of it later.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
