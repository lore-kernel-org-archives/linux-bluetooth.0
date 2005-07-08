Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
References: <1120747365.18553.15.camel@pegasus> <200507071900.33313.bluez-devel@schaettgen.de> <1120759981.18553.52.camel@pegasus>
In-Reply-To: <1120759981.18553.52.camel@pegasus>
Cc: kde-bluetooth@liste.ferrara.linux.it
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507080315.50686.bluez-devel@schaettgen.de>
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
Date: Fri, 8 Jul 2005 03:15:50 +0200

On Thursday, 7. July 2005 20:13, Marcel Holtmann wrote:
=2E..
> > What is this VFS module supposed to do? Device discovery, service
> > discovery..?
>
> all these tasks are done inside bluetoothd (needs to be written) and the
> VFS module is used for displaying them. The communication will be done
> via D-Bus.
>
> An after-talk beer session at the LinuxTag with one of the D-Bus guys
> convinced me that there is no other way that makes sense.

Indeed. That=B4s also more or less what we are doing. Well, the ioslaves do=
 the=20
inquiry and sdp requests on their own, but the name cache is accessed via=20
DCOP. I wouldn=B4t mind if BlueZ could do part of the work. Qt support for =
dbus=20
wasn=B4t all that good last time I checked, but this will certainly change =
if=20
KDE4 starts using dbus more than just removable media.

> I have a rough=20
> design on how these things will interact, but only a bare minimum is
> implemented at the moment. The kernel needs an extra event mechanism for
> all this stuff and I have to write bluetoothd of course. The basic idea
> looks like this:

What is that extra event mechanism good for? Can=B4t you monitor everything=
 that=20
is needed without new extensions?
Oh, btw. is there a way to get the number of transfered packets/bytes? =20

=2E..
> > The [xx:xx...] syntax is inspired by the syntax used for IPv6 addresses
> > in URLs (RFC 2732).
=2E..
> Another way is to strip the colon from the device address. This method
> was used in the ESDP and JSR-82 specifications. I used the latter method
> in the URIs for the CUPS backend.

Ok, someone flip a coin please ;)

> Main question is how we deal with different local devices. We need a
> method to specify an optional source. No specification really deals with
> multiple Bluetooth devices attached to the same host.

We could simply append the device number to the device address and default =
to=20
the first usable device if that suffix is missing. Like [xx:xx:xx:xx:xx:xx.=
2]=20
for instance. =20
But remember that you are targeting desktop users now. We support several=20
devices only by setting a special environment variable/command line paramet=
er=20
and before that we=B4ve had about one complaint in total regarding missing=
=20
support for multiple adapters. A workaround for special needs is obviously=
=20
enough, no need to complicate the UI for the vast majority with just a sing=
le=20
adapter.

=2E..
[mimetypes used by kde=B4s ioslaves]
=2E..
> I think we need at least two different MIME types. One for devices and
> one for the service records. Having different types for every UUID is
> also a good idea. Thoughts?

Sure, when I said =A8one mimetype=A8 I was talking just about the sdp iosla=
ve=20
which does the services. Do you want to use one VFS module for everything? =
We=20
used to have one kioslave for both device discovery and service listing, bu=
t=20
it=B4s cleaner if it=B4s separated in my eyes.
If you have one mimetype per UUID, then which one do you pick for the file=
=20
item? Or can you assign several mimetypes to one item with gnome=B4s VFS?
That=B4s one of the points where doing bluetooth with kioslaves looked like=
 a=20
not so good idea.

> Actually I have no ideas for their string representation. Does anybody
> know a reference for this?

String representation of what? Mime types? This might help in that case:
http://www.iana.org/assignments/media-types/
I never bothered reading it though.

=2E..
> For these kind of things it would be great to go along with the JSR-82
> specification and their ideas of a Bluetooth URI. However I am not 100%
> sure about that at the moment, because some of the JSR-82 stuff is crap.

If it does all we need - fine. How would a JSR-82 style URL look like to=20
access some service of a device?

> Last time I played with the KDE-Bluetooth thing it was working great and
> the version included in SuSE 9.3 is really usable. However we need some
> kind of standard between Gnome and KDE (and every other desktop). At the
> moment my mind is totally open for anything. The more feedback the
> better.

The metaserver feature of kbluetoothd really shouldn=B4t be KDE-specific in=
 my=20
eyes. It=B4s extremly helpful to implement new services, which can then be=
=20
controlled in a consistent and secure fashion. It proved to work very well=
=20
for us in all the time, but having it implemented in BlueZ (with KDE and=20
Gnome providing just a GUI for it) it might even used by third parties. It=
=B4s=20
hard to sell if it=B4s tied to KDE.

Another service that might be worth sharing is the device discovery. This i=
s a=20
service offered by kbluetoothd which searches for nearby devices regularly =
=20
and starts scripts when devices come and go. It totally sucks UI-wise, but =
it=20
is good for many interesting applications. And if you have more than one=20
application where each one polls for new devices, then it makes a lot of=20
sense to have just a central service doing that on behalf of them.
The biggest problem is how to deal with devices that are not discoverable. =
In=20
kbluetoothd the user (or applications via DCOP) can configure a list of=20
devices that are paged to find out if they are around. But those connection=
=20
attempts don=B4t do any good when you try to use the adapter for something =
else=20
meanwhile.

Will the bluetoothd run in the user session or as root? Maybe it should be=
=20
able to do both, just like the dbus daemon itself. If bluetoothd contains a=
=20
metaserver eventually it should be possible to have it launch applications=
=20
with a GUI, like kbluetoothd is doing now. But we can=B4t start system serv=
ices=20
on demand, even though this can be desirable too.=20

=46red


=2D-=20
=46red Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
