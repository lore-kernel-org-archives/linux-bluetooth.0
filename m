Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f2050818135877575293@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <e1effdeb05081805054a0be4aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050816154545b6f046@mail.gmail.com>
	 <e1effdeb05081805054a0be4aa@mail.gmail.com>
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
Date: Thu, 18 Aug 2005 22:58:25 +0200

Hi Claudio,

> In my opinion the bluetooth address should be part of the object path.
> The approach of use the bdaddr in the object path make possible
> address multiple adapters. By other hand, each adapter should export
> a distinct D-Bus path.
>=20
> org/bluetool/00_12_D4_05_70_BA/hci
> org/bluetool/00_12_D4_05_70_BA/sdp
> org/bluetool/00_12_D4_05_70_BA/rfcomm
>=20

Probably my poor english caused some misunderstanding, the address
*IS* part of the object path already, I can handle several adapters
without any problems right now, and every adapter has a path like
/org/bluetool/<BDADDR>/device

> But considering that the most common scenario is only one bluetooth
> adapter this
> approach is feasible.
>=20
> > Device objects are, of course, the most important, since their methods
> > allow to actually manipulate the device the way it's done nowadays
> > with the bluez-utils, but using dbus messages (which can be also
> > handled asynchronously, something the cli utils can't do), since I
> > said devices are objects, they're expected to implement interfaces,
> > and in fact there's a couple of them (as in many programming
> > languages, also in DBUS nothing prevents an object to implement more
> > than one interface), they're
> > org.bluetool.device.hci
> > org.bluetool.device.sdp
> > org.bluetool.device.rfcomm
> > and so on..
> [Claudio Takahasi]
> Two approachs can be done here. You can use one object with multiples
> interfaces or you can use fallback approach where each service will
> have a specific path in the hierarchy(D-Bus object fallback).
> In the first case you shall create only one D-Bus message handler functio=
n
> (a very huge function) to handle all interfaces. In the second option,
> you can develop using a more modular approach, each profile shall have
> their own D-Bus message handler.
>=20

I've gone for the first approach, a single device object implements
several interfaces, and despite what you think, there's no "huge
dispatch function" involved, every interface is a class on its own
(remember we're talking C++ and not C here) resides in a seperate file
and contains only the code necessary to handle the messages for its
interface, message routing happens automatically in the DBus wrapper
and I don't have to do much else

>=20
> > what they do is more or less what's in the bluez-utils already, the
> > hci interface (this expression is rendundant, I know :) is a bit
> > particular, since most of the functionalities previously contained in
> > the hci utils are now grouped in just two methods,
> > org.bluetool.hci.GetProperty and org.bluetool.hci.SetProperty, they
> > take the property name (as a string) as the first parameter, while the
> > others depend upon the property (of course DBUS allows to do some type
> > checking and to report to the caller an error if the parameters are of
> > the wrong type or number, and errors are obviously reported using
> > ErrorMessages which DBus provides natively) doing so simplified a lot
> > the interface.
> [Claudio Takahasi]
> This approach of use "GetProperty"and "SetProperty" for the functionaliti=
es
> provided by hciconfig is more attractive, but the coding for verify the m=
essage
> signature will be more complex.
>=20
do you think? here's the code to set the device class (takes three
bytes as input)

void HciDevice::SetProperty( const DBus::CallMessage& msg )
{
=09DBus::ReturnMessage *reply =3D new DBus::ReturnMessage(msg);

=09try
=09{
=09=09DBus::MessageIter i =3D msg.r_iter();
=09=09std::string property =3D i.get_string();
=09=09++i;
=09
        // an if statement starts here.....

=09=09else
=09=09if( property =3D=3D "class" )
=09=09{
=09=09=09u8 major     =3D i.get_byte(); ++i;
=09=09=09u8 minor     =3D i.get_byte(); ++i;
=09=09=09u8 service   =3D i.get_byte();
=09=09=09Hci::LocalDevice::set_class(major,minor,service,reply,HCI_TIMEOUT)=
;

=09=09=09//beware, set_class this is an inherited member function
=09=09=09//NOT a static method
=09=09}

if the property is not a string or the parameters are not bytes, an
exception is thrown by the dbus wrapper (see the 'try' block at the
beginning?) and I send an error message back to the caller explaining
the error, otherwise everything goes on linearly

> > another thing BluetoolDevice class instances (I'm using a C++ wrapper
> > for DBus I've written myself, so dbus objects map directly to C++
> > objects) do, is to listen for HCI events on a dedicated socket and
> > keep track of all the events received, this allows to handle method
> > invocations from the bus in an almost asynchronous way, allowing to
> > handle several simultaneous requests (this has a limitation, two
> > requests of the same type, for example two inquiry scans, cannot be
> > done at the same time and the last one is queued), this also allows to
> > receive inquiry_result and [dis]connection_complete events, so, for
> > example, inquiry results can be put in a cache which can be fastly
> > accessed by clients without issuing an inquiry every time.
> > remote devices are objects as well, they have a path (which is a
> > subpath of the local discovering device) and have methods to read
> > their remote name, to create ACL or SCO connections towards them, to
> > query their service database etc..
> > talking about service databases, there's also a local service database
> > which contains (guess..) services (keep in mind, the `sdpd` program is
> > yet another thing) ,every service implements the
> > 'org.bluetool.service' interface, with provides Start and Stop methods
> > (and go figure what they do :) and GetOption and SetOption methods,
> > the last two can automatically write the current settings on a
> > configuration file, allowing persistence across several start/stops of
> > the service, the real services (which are subclasses of the class
> > introduced before) add other specific methods, but under the hood they
> > don't do much more than fork the appropriate process (`pand` or `dund`
> > for example) with the saved options, and kill it when it's not needed
> > anymore.
> [Claudio Takahasi]
> Could you provide more information about  service databases? I am not
> understanding exactly how it will works and how you intend to keep the
> backward compatibility with the bluez daemons(sdp, pand, dund, ...)
>=20
it's something I'm still working on, so I'll give you more news about
that soon, for now, just to explain a bit, the name "services" is
inappropriate (but I couldn't come up with a better one) they don't
provide the service (daemons do) they're just small helper programs
which sit on the bus waiting for orders, so you say "Start()" and it
starts the daemon, "Stop()" kills it, you say "ListConnections()" (for
example in pand) and it makes an ioctl() and returns the connection
list (nicely packed into a dbus message) to the caller.
What the "database" does (this database is not sdpd, it's an object
created by the bluetool daemon), is simply to find what "helpers" are
installed (ie: reading a list from a configuration file) and execute
them, not much more actually :) every helper in turn registers its own
object path and waits

> Regards,
> Claudio Takahasi
>=20
re,
Paul


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
