Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f2050816154545b6f046@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
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
Date: Wed, 17 Aug 2005 00:45:24 +0200

On 8/16/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi folks,
>=20
> I am posting a new draft of D-Bus architecture and Interfaces.
>=20
> If someone has comments regarding the design, interfaces or any kind
> of question send us a feedback.
>=20
> This last draft contains some changes based on Johan Hedberg feedback
> and new services.
>=20
> Major changes:
> * Return "D-Bus error messages" instead of "method return" following
> the Johan Hedberg suggestion
> * Defined standard error messages
> * Added "architecture" overview section.
> * Using just one interface for request and signals instead of distinct
> interfaces. The message type can be discovered using the message type
> attribute embedded in the D-Bus message header.
>=20
> Location:
> The document (draft 00.05) can be found at: http://www.cin.ufpe.br/~ckt/b=
luez
>=20
> Next action:
> * define SDP D-Bus services and architecture.
> * Multi-level disconnection/connection signals. Is it really
> necessary? eg: send disconnect signal at pan and hci D-Bus interfaces.
> * Signal level. Is it possible check it? IS it really necessary?
> * Unify rfcomm and dun D-Bus services. Is it feasible?
>=20
>=20
> Suggestions a welcome!
>=20
> Regards,
> Claudio
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20

Hi Claudio,
your project seems pretty interesting to me, mostly because I've been
implementing something almost identical for the last weeks, I hope
I've gained some experience and that I could be useful commenting the
way I'm doing it:
I've got a dbus service at the root, let's call it 'org.bluetool'
(it's not going to be the definitive name tough :)
as the dbus specification says, services provide objects, and the main
object here is the 'manager', (at /org/bluetool/manager'), its main
role is to track the lifecycle of the bluetooth devices on the
computer, it's interface (called, surprisingly 'org.bluetool.manager')
emits two signals, when a device is added/removed (more or less the
way the HAL does) and contains one method, "ListDevices", which
returns a list of strings, each one representing a Device object
(identified by its unique BDADDR, paths have the form
"/org/bluetool/devices/00_12_D4_05_70_BA".
Device objects are, of course, the most important, since their methods
allow to actually manipulate the device the way it's done nowadays
with the bluez-utils, but using dbus messages (which can be also
handled asynchronously, something the cli utils can't do), since I
said devices are objects, they're expected to implement interfaces,
and in fact there's a couple of them (as in many programming
languages, also in DBUS nothing prevents an object to implement more
than one interface), they're
org.bluetool.device.hci
org.bluetool.device.sdp
org.bluetool.device.rfcomm
and so on..
what they do is more or less what's in the bluez-utils already, the
hci interface (this expression is rendundant, I know :) is a bit
particular, since most of the functionalities previously contained in
the hci utils are now grouped in just two methods,
org.bluetool.hci.GetProperty and org.bluetool.hci.SetProperty, they
take the property name (as a string) as the first parameter, while the
others depend upon the property (of course DBUS allows to do some type
checking and to report to the caller an error if the parameters are of
the wrong type or number, and errors are obviously reported using
ErrorMessages which DBus provides natively) doing so simplified a lot
the interface.
another thing BluetoolDevice class instances (I'm using a C++ wrapper
for DBus I've written myself, so dbus objects map directly to C++
objects) do, is to listen for HCI events on a dedicated socket and
keep track of all the events received, this allows to handle method
invocations from the bus in an almost asynchronous way, allowing to
handle several simultaneous requests (this has a limitation, two
requests of the same type, for example two inquiry scans, cannot be
done at the same time and the last one is queued), this also allows to
receive inquiry_result and [dis]connection_complete events, so, for
example, inquiry results can be put in a cache which can be fastly
accessed by clients without issuing an inquiry every time.
remote devices are objects as well, they have a path (which is a
subpath of the local discovering device) and have methods to read
their remote name, to create ACL or SCO connections towards them, to
query their service database etc..
talking about service databases, there's also a local service database
which contains (guess..) services (keep in mind, the `sdpd` program is
yet another thing) ,every service implements the
'org.bluetool.service' interface, with provides Start and Stop methods
(and go figure what they do :) and GetOption and SetOption methods,
the last two can automatically write the current settings on a
configuration file, allowing persistence across several start/stops of
the service, the real services (which are subclasses of the class
introduced before) add other specific methods, but under the hood they
don't do much more than fork the appropriate process (`pand` or `dund`
for example) with the saved options, and kill it when it's not needed
anymore.
As you'll see my project is pretty huge, especially because I had to
complete it in just a couple of weeks and the time is almost over,
every critique/suggestion would be greatly appreciated,

Regards,
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
