Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
References: <1120747365.18553.15.camel@pegasus>
In-Reply-To: <1120747365.18553.15.camel@pegasus>
Cc: kde-bluetooth@liste.ferrara.linux.it
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200507071900.33313.bluez-devel@schaettgen.de>
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
Date: Thu, 7 Jul 2005 19:00:32 +0200

On Thursday, 7. July 2005 16:42, Marcel Holtmann wrote:
> Hi Folks,
>
> I am working on a Gnome VFS method for Bluetooth and we need to find a
> common way for using Bluetooth URIs and their related MIME types. At the
> moment I am open for any proposals. So please comment on this topic.

What is this VFS module supposed to do? Device discovery, service discovery=
=2E.?
Oh, wait... did you say Gnome? You are using a graphical desktop? Is your t=
ext=20
terminal broken? *g*

In kdebluetooth we have three ioslaves (which I assume is roughly the same =
as=20
a gnome VFS module):
bluetooth:/ simply do an inquiry and list the devices found
sdp://[xx:xx:xx:xx:xx:xx]/ lists the services of a given device
=46or conveniance it=C2=B4s also possible to replace the [<bdaddr>] with th=
e device=20
name (which is looked up in kdebluetooth=C2=B4s persistant name cache).
The [xx:xx...] syntax is inspired by the syntax used for IPv6 addresses in=
=20
URLs (RFC 2732).
The third ioslave is for a the OBEX file transfer profile, so it=C2=B4s not=
 really=20
relevant here.

=46or the mimetypes of the devices listed by the bluetooth ioslave we use=20
different types for each device class. The mimetypes are called=20
=C2=A8bluetooth/computer-device-class=C2=A8 for instance. afaik the subclas=
s should=20
start with x-, and I=C2=B4m also not sure if the class string =C2=A8bluetoo=
th=C2=A8 is ok,=20
but it works and no one complained...
We could have used a single mimetype for all classes and hardcode the icon.=
=20
Since there are no custom actions for special device classes and since the=
=20
device classes all known in advance, it doesn=C2=B4t really matter how it=
=C2=B4s done.
=46or services (listed by the sdp-ioslave) we use mimetypes like=20
=C2=A8bluetooth/handsfree-profile=C2=A8. For each mimetype file we have a c=
orresponding=20
desktop file which maps a list of UIDs to a mimetype, so new profiles can b=
e=20
installed by third party applications (there aren=C2=B4t any so far, but=20
anyway... ;)
By using different mimetypes for each profile, the user can change the=20
association of bluetooth services with applications. Sometimes it=C2=B4s a =
bit=20
nasty if you want to open a handsfree service with a generic terminal=20
program, that depends only on rfcomm for instance. At least in KDE it seems=
=20
to be impossible to assign two mimetypes to an item. The other solution wou=
ld=20
be a hierarchy among the mimetypes (rfcomm<-handsfree for instance).

Another option would be to use a single mimetype (associated with a helper=
=20
application) for all services and do the service<->application association=
=20
without mimetypes.

When the user finally clicks a service listed by the sdp ioslave, an=20
application must be started and it must be provided with everything it need=
s=20
to know to connect to the given service.
Since in kdebluetooth we chose to start applications directly without the=20
helper mentioned above, we can only pass an URL to the application. This UR=
L=20
must contain not only the bluetooth address, but also the rfcomm (or l2cap=
=20
etc.) channel given in the service record.=20
In kdebluetooth this is encoded like that:
sdp://[00:e0:03:32:00:00]/params?name=3Dfred%27s%206230&rfcommchannel=3D1
The name of the device was =C2=A8Fred=C2=B4s 6230=C2=A8 in this example. Th=
is scheme would=20
allow to append other parameters, for instance for l2cap-based services.
It would also be possible to encode the complete sdp record of the service=
=20
into the URL, but we didn=C2=B4t have any need for it.
Since KDE ships with a URL class, it is pretty easy to extract the device=20
address and the rfcommchannel from such an URL. Gnome surely has an=20
equivalent to KDE=C2=B4s KURL, but for plain C/C++ apps the quoting might m=
ake it=20
more difficult than necessary.

There are several things we didn=C2=B4t implement, like..
=2D browse groups
=2D searching for a given UID instead of browsing everything

In kdebluetooth the ioslaves are used only directly by the user. Applicatio=
ns=20
could also us it internally to search for devices/services, but we chose to=
=20
use BlueZ directly - with some C++-wrappers around it of course, so that it=
=20
looks less scary to people not hacking the kernel all day long.

Now this was just a short overview over the approach of kdebluetooth. The=20
design was mostly driven by our own needs and the limited degrees of freedo=
m=20
that the ioslave framework offers. Squeezing bluetooth into an infrastructu=
re=20
that was once created to browse a file systems make some things more=20
complicated than necessary. KDE developers tend to put everything and his=20
mother into an ioslave, because it=C2=B4s so simple to start, integrates so=
 nicely=20
with the desktop and all the UI comes for free. The problems start when you=
=20
realize that this UI isn=C2=B4t really best for your application.
But anyway, it would certainly be good to agree on a common scheme if you=20
introduce equivalents to our ioslaves in gnome.
If you have kdebluetooth installed you can try =C2=A8kioclient -U ls 'bluet=
ooth:/'=C2=A8=20
etc. in case I forgot some details about the URLs we are using.

regards
=46red

=2D-=20
=46red Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
