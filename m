Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050523080216e96744@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1116844053.30044.59.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
	 <1116844053.30044.59.camel@pegasus>
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
Date: Mon, 23 May 2005 12:02:32 -0300

Hi Marcel,

I will fix your suggestions.

Regarding our suggestion about the service name. I consider the
following basic features essential to establish and control connections:
* Search for a service (provided by sdptool)
* Display local devices (provided by hcitool)
* Switch master/slave role (provided by hcitool)
* Listen for PAN connections (provided by pand)
* Connect (provided by pand)
* Disconnect  (provided by pand)
* Display active connections  (provided by pand)

According to D-BUS specification  when messages are received over a
D-BUS connection,
they are sent to a specific object, not to the application as a whole.
Each object supports
one or more interfaces.
=20
We have two options:
1. define one object with only one interface
    eg:   =20
        object:org.bluez.pand
        interface:org.bluez.pand
2. define one object with multiple interfaces
    eg:   =20
        object:org.bluez.pand
        interface: org.bluez.pand
        interface: org.bluez.sdp
        interface: org.bluez.hci

For the both cases, pand will be the daemon responsible for
provide this interfaces/services.
What approach do you preffer?
The last alternative is better because it is possible define more
detailed rules in the dbus configuration file.=20



Another point is the header for dbus services, the client application
must know the message format, therefore the header file(dbus_services.h)
will be required. In the future, develop a library hidding D-BUS message
details is a better option.


Regards,
Claudio.

On 5/23/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I am sending a initial skeleton of pand DBUS support. I was not able to
> > access BlueZ CVS due firewall permissions.
> >
> > The path is based on bluez-utils-2.17.
>=20
> no problem the 2.17 is quite up-to-date.
>=20
> > Suggestions and comments are welcome!
>=20
> please use only the file dbus.c and put needed function prototypes into
> pand.h. The dbus_services.h is not needed. Put the declarations into
> dbus.c.
>=20
> Don't provide and "hcid" service within pand. If you wanna provide HCI
> task then hide them inside the pand D-Bus. Use org.bluez.pand as base
> name for all stuff.
>=20
> Never use dev_id. You can use the source Bluetooth address instead and
> then convert it to dev_id internally. Don't use bdaddr_t at all. Simply
> use the string representation of the Bluetooth device address.
>=20
> Don't use char to represent an one byte value. Use uint8_t.
>=20
> Once if we agree on the changes to Makefile.am, pand.h and main.c, then
> I can commit a simple framework with an empty dbus.c and you only need
> to send me changes to dbus.c from then on.
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
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
