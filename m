Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: kde-bluetooth@liste.ferrara.linux.it
In-Reply-To: <200507071900.33313.bluez-devel@schaettgen.de>
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1120759981.18553.52.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 07 Jul 2005 20:13:01 +0200

Hi Fred,

> > I am working on a Gnome VFS method for Bluetooth and we need to find =
a
> > common way for using Bluetooth URIs and their related MIME types. At =
the
> > moment I am open for any proposals. So please comment on this topic.
>=20
> What is this VFS module supposed to do? Device discovery, service disco=
very..?

all these tasks are done inside bluetoothd (needs to be written) and the
VFS module is used for displaying them. The communication will be done
via D-Bus.

An after-talk beer session at the LinuxTag with one of the D-Bus guys
convinced me that there is no other way that makes sense. I have a rough
design on how these things will interact, but only a bare minimum is
implemented at the moment. The kernel needs an extra event mechanism for
all this stuff and I have to write bluetoothd of course. The basic idea
looks like this:

	kernel <-> bluetoothd <-> applications

The Nautilus integration is the next logical step and this means a
Bluetooth Gnome VFS module. In general I wanna integrate Bluetooth into
the desktop without writing any new applications. My idea is to make it
mostly invisible for the user that they are using Bluetooth.

> Oh, wait... did you say Gnome? You are using a graphical desktop? Is yo=
ur text=20
> terminal broken? *g*

I hope not ;)

> In kdebluetooth we have three ioslaves (which I assume is roughly the s=
ame as=20
> a gnome VFS module):
> bluetooth:/ simply do an inquiry and list the devices found
> sdp://[xx:xx:xx:xx:xx:xx]/ lists the services of a given device
> For conveniance it=B4s also possible to replace the [<bdaddr>] with the=
 device=20
> name (which is looked up in kdebluetooth=B4s persistant name cache).
> The [xx:xx...] syntax is inspired by the syntax used for IPv6 addresses=
 in=20
> URLs (RFC 2732).
> The third ioslave is for a the OBEX file transfer profile, so it=B4s no=
t really=20
> relevant here.

The IO slaves and the Gnome VFS are almost the same.

Another way is to strip the colon from the device address. This method
was used in the ESDP and JSR-82 specifications. I used the latter method
in the URIs for the CUPS backend.

Main question is how we deal with different local devices. We need a
method to specify an optional source. No specification really deals with
multiple Bluetooth devices attached to the same host.

> For the mimetypes of the devices listed by the bluetooth ioslave we use=
=20
> different types for each device class. The mimetypes are called=20
> =A8bluetooth/computer-device-class=A8 for instance. afaik the subclass =
should=20
> start with x-, and I=B4m also not sure if the class string =A8bluetooth=
=A8 is ok,=20
> but it works and no one complained...
> We could have used a single mimetype for all classes and hardcode the i=
con.=20
> Since there are no custom actions for special device classes and since =
the=20
> device classes all known in advance, it doesn=B4t really matter how it=B4=
s done.
> For services (listed by the sdp-ioslave) we use mimetypes like=20
> =A8bluetooth/handsfree-profile=A8. For each mimetype file we have a cor=
responding=20
> desktop file which maps a list of UIDs to a mimetype, so new profiles c=
an be=20
> installed by third party applications (there aren=B4t any so far, but=20
> anyway... ;)
> By using different mimetypes for each profile, the user can change the=20
> association of bluetooth services with applications. Sometimes it=B4s a=
 bit=20
> nasty if you want to open a handsfree service with a generic terminal=20
> program, that depends only on rfcomm for instance. At least in KDE it s=
eems=20
> to be impossible to assign two mimetypes to an item. The other solution=
 would=20
> be a hierarchy among the mimetypes (rfcomm<-handsfree for instance).
>=20
> Another option would be to use a single mimetype (associated with a hel=
per=20
> application) for all services and do the service<->application associat=
ion=20
> without mimetypes.

I think we need at least two different MIME types. One for devices and
one for the service records. Having different types for every UUID is
also a good idea. Thoughts?

Actually I have no ideas for their string representation. Does anybody
know a reference for this?

> When the user finally clicks a service listed by the sdp ioslave, an=20
> application must be started and it must be provided with everything it =
needs=20
> to know to connect to the given service.
> Since in kdebluetooth we chose to start applications directly without t=
he=20
> helper mentioned above, we can only pass an URL to the application. Thi=
s URL=20
> must contain not only the bluetooth address, but also the rfcomm (or l2=
cap=20
> etc.) channel given in the service record.=20
> In kdebluetooth this is encoded like that:
> sdp://[00:e0:03:32:00:00]/params?name=3Dfred%27s%206230&rfcommchannel=3D=
1
> The name of the device was =A8Fred=B4s 6230=A8 in this example. This sc=
heme would=20
> allow to append other parameters, for instance for l2cap-based services.
> It would also be possible to encode the complete sdp record of the serv=
ice=20
> into the URL, but we didn=B4t have any need for it.
> Since KDE ships with a URL class, it is pretty easy to extract the devi=
ce=20
> address and the rfcommchannel from such an URL. Gnome surely has an=20
> equivalent to KDE=B4s KURL, but for plain C/C++ apps the quoting might =
make it=20
> more difficult than necessary.

For these kind of things it would be great to go along with the JSR-82
specification and their ideas of a Bluetooth URI. However I am not 100%
sure about that at the moment, because some of the JSR-82 stuff is crap.

> There are several things we didn=B4t implement, like..
> - browse groups
> - searching for a given UID instead of browsing everything

I don't think that these stuff is needed for the graphical interfaces of
Bluetooth. If people want that, then they should use the command line.

> In kdebluetooth the ioslaves are used only directly by the user. Applic=
ations=20
> could also us it internally to search for devices/services, but we chos=
e to=20
> use BlueZ directly - with some C++-wrappers around it of course, so tha=
t it=20
> looks less scary to people not hacking the kernel all day long.

My current idea is to present that via D-Bus and then use whenever
possible Python as programming language. Not that I am a really good
Python programmer, but it seems reasonable to me.

> Now this was just a short overview over the approach of kdebluetooth. T=
he=20
> design was mostly driven by our own needs and the limited degrees of fr=
eedom=20
> that the ioslave framework offers. Squeezing bluetooth into an infrastr=
ucture=20
> that was once created to browse a file systems make some things more=20
> complicated than necessary. KDE developers tend to put everything and h=
is=20
> mother into an ioslave, because it=B4s so simple to start, integrates s=
o nicely=20
> with the desktop and all the UI comes for free. The problems start when=
 you=20
> realize that this UI isn=B4t really best for your application.
> But anyway, it would certainly be good to agree on a common scheme if y=
ou=20
> introduce equivalents to our ioslaves in gnome.
> If you have kdebluetooth installed you can try =A8kioclient -U ls 'blue=
tooth:/'=A8=20
> etc. in case I forgot some details about the URLs we are using.

Last time I played with the KDE-Bluetooth thing it was working great and
the version included in SuSE 9.3 is really usable. However we need some
kind of standard between Gnome and KDE (and every other desktop). At the
moment my mind is totally open for anything. The more feedback the
better.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
