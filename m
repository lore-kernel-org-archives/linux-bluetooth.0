Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05070805454b8960b6@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
Cc: kde-bluetooth@liste.ferrara.linux.it
In-Reply-To: <1120804711.18553.100.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
	 <1120759981.18553.52.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
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
Date: Fri, 8 Jul 2005 09:45:13 -0300

Hi folks,

I am not complete aware of all subjects under discussion, but I would
like comment some points ...

On 7/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Fred,
>=20
> > > An after-talk beer session at the LinuxTag with one of the D-Bus guys
> > > convinced me that there is no other way that makes sense.
> >
> > Indeed. That=B4s also more or less what we are doing. Well, the ioslave=
s do the
> > inquiry and sdp requests on their own, but the name cache is accessed v=
ia
> > DCOP. I wouldn=B4t mind if BlueZ could do part of the work. Qt support =
for dbus
> > wasn=B4t all that good last time I checked, but this will certainly cha=
nge if
> > KDE4 starts using dbus more than just removable media.
>=20
> I will move the device and service discovery into bluetoothd and also
> the name cache. Actually hcid already maintains a name cache, but at the
> moment you can access it only via the filesystem.
>=20
> > > I have a rough
> > > design on how these things will interact, but only a bare minimum is
> > > implemented at the moment. The kernel needs an extra event mechanism =
for
> > > all this stuff and I have to write bluetoothd of course. The basic id=
ea
> > > looks like this:
> >
> > What is that extra event mechanism good for? Can=B4t you monitor everyt=
hing that
> > is needed without new extensions?
>=20
> But you need to do everything twice. Inside the kernel and then again in
> userspace. The kernel needs to keep track of a lot of stuff anyway and
> so I don't wanna redo that in userspace.
>=20
> The best example is the Inquiry Result with RSSI event. Some vendor got
> it wrong and so I had to implement a workaround in the kernel, in hcid
> and in hcidump. The hcidump part will never go away, because I need to
> keep it separate to be able to detect errors, but the kernel and hcid
> (bluetoothd in the future) shouldn't need to do that twice.
>=20
> > Oh, btw. is there a way to get the number of transfered packets/bytes?
>=20
> The "struct hci_dev_info" contain them. Check hciconfig for an example.
>=20
> > > > The [xx:xx...] syntax is inspired by the syntax used for IPv6 addre=
sses
> > > > in URLs (RFC 2732).
> > ...
> > > Another way is to strip the colon from the device address. This metho=
d
> > > was used in the ESDP and JSR-82 specifications. I used the latter met=
hod
> > > in the URIs for the CUPS backend.
> >
> > Ok, someone flip a coin please ;)
>=20
> I checked the RFC 2732 and I think both are fine. Maybe it is a good
> idea to also support both.
>=20
> > > Main question is how we deal with different local devices. We need a
> > > method to specify an optional source. No specification really deals w=
ith
> > > multiple Bluetooth devices attached to the same host.
> >
> > We could simply append the device number to the device address and defa=
ult to
> > the first usable device if that suffix is missing. Like [xx:xx:xx:xx:xx=
:xx.2]
> > for instance.
>=20
> I don't like it. My thoughts were something like:
>=20
>         hci0@aabbccddeeff or 112233445566@aabbccddeeff
>=20
> But actually I must admit I am not really convinced.
>=20
> > But remember that you are targeting desktop users now. We support sever=
al
> > devices only by setting a special environment variable/command line par=
ameter
> > and before that we=B4ve had about one complaint in total regarding miss=
ing
> > support for multiple adapters. A workaround for special needs is obviou=
sly
> > enough, no need to complicate the UI for the vast majority with just a =
single
> > adapter.
>=20
> This is no argument for me. We always will have the special case where
> only one adapter exists and BDADDR_ANY is enough, but this is Linux and
> we do it the right way and support everything possible. You need to redo
> your thinking. Multiple adapters is the normal case and only one adapter
> is a special case.
>=20
> And if I start using graphical toys for Bluetooth then they must support
> it, because for me the normal case is three attached adapters ;)
>=20
> > > I think we need at least two different MIME types. One for devices an=
d
> > > one for the service records. Having different types for every UUID is
> > > also a good idea. Thoughts?
> >
> > Sure, when I said =A8one mimetype=A8 I was talking just about the sdp i=
oslave
> > which does the services. Do you want to use one VFS module for everythi=
ng? We
> > used to have one kioslave for both device discovery and service listing=
, but
> > it=B4s cleaner if it=B4s separated in my eyes.
> > If you have one mimetype per UUID, then which one do you pick for the f=
ile
> > item? Or can you assign several mimetypes to one item with gnome=B4s VF=
S?
> > That=B4s one of the points where doing bluetooth with kioslaves looked =
like a
> > not so good idea.
>=20
> I don't see the advantage of having two different VFS modules for device
> and service discovery. And since both are only presenting stuff that can
> be retrieved from bluetoothd they won't be highly complex.
>=20
> Since Nautilus is supporting "Open with" it might be possible to assign
> multiple applications to one MIME type. This also means that we need
> different MIME types for each service/profile.
>=20
> > > Actually I have no ideas for their string representation. Does anybod=
y
> > > know a reference for this?
> >
> > String representation of what? Mime types? This might help in that case=
:
> > http://www.iana.org/assignments/media-types/
> > I never bothered reading it though.
>=20
> It was a long time ago when I read the RFC 2046. However after looking
> through it, I think we must use the application main type with the x-
> subtype. What about stuff like this:
>=20
>         application/x-bt.device
>         application/x-bt.service
>=20
>         application/x-bt.handsfree
>=20
> On the other hand I remembered that the BIP already needed special MIME
> types and it seems they are using x-bt/img-listing and so on for it.
>=20
> > > For these kind of things it would be great to go along with the JSR-8=
2
> > > specification and their ideas of a Bluetooth URI. However I am not 10=
0%
> > > sure about that at the moment, because some of the JSR-82 stuff is cr=
ap.
> >
> > If it does all we need - fine. How would a JSR-82 style URL look like t=
o
> > access some service of a device?
>=20
> They only define btspp:, btl2cap: and btgoep: and it is mostly used for
> protocol transports. As I said, some of it is crap.
>=20
> > > Last time I played with the KDE-Bluetooth thing it was working great =
and
> > > the version included in SuSE 9.3 is really usable. However we need so=
me
> > > kind of standard between Gnome and KDE (and every other desktop). At =
the
> > > moment my mind is totally open for anything. The more feedback the
> > > better.
> >
> > The metaserver feature of kbluetoothd really shouldn=B4t be KDE-specifi=
c in my
> > eyes. It=B4s extremly helpful to implement new services, which can then=
 be
> > controlled in a consistent and secure fashion. It proved to work very w=
ell
> > for us in all the time, but having it implemented in BlueZ (with KDE an=
d
> > Gnome providing just a GUI for it) it might even used by third parties.=
 It=B4s
> > hard to sell if it=B4s tied to KDE.
>=20
> Before talking about any metaserver, I need to resolve some other basic
> issues like authentication, authorization etc.
[Claudio Takahasi]
I am not understaning how the metaserver will work. How the current bluez=
=20
daemons (pand, dund, hidd, rfcomm, ... ) must work with this metaserver.
Could you write more details about the architecture of the metaserver and
how it will interact with the bluez daemons?


>=20
> > Another service that might be worth sharing is the device discovery. Th=
is is a
> > service offered by kbluetoothd which searches for nearby devices regula=
rly
> > and starts scripts when devices come and go. It totally sucks UI-wise, =
but it
> > is good for many interesting applications. And if you have more than on=
e
> > application where each one polls for new devices, then it makes a lot o=
f
> > sense to have just a central service doing that on behalf of them.
> > The biggest problem is how to deal with devices that are not discoverab=
le. In
> > kbluetoothd the user (or applications via DCOP) can configure a list of
> > devices that are paged to find out if they are around. But those connec=
tion
> > attempts don=B4t do any good when you try to use the adapter for someth=
ing else
> > meanwhile.
>=20
> The inquiries in background is something I don't really like about it,
> because for some devices this is simply disturbing and if you play music
> over A2DP you might kill the audio stream with it. However I wanna move
> that all into bluetoothd (including somekind of SDP cache).
>=20
> > Will the bluetoothd run in the user session or as root? Maybe it should=
 be
> > able to do both, just like the dbus daemon itself. If bluetoothd contai=
ns a
> > metaserver eventually it should be possible to have it launch applicati=
ons
> > with a GUI, like kbluetoothd is doing now. But we can=B4t start system =
services
> > on demand, even though this can be desirable too.
>=20
> It will be root only, because otherwise it can't listen for kernel
> events. We also need one central daemon to deal with all the stuff and
> so a session version makes no sense. However there is also no need it,
> because it will communicate only over D-Bus and this can be made session
> aware. The D-Bus also have somekind of activation mechanism that should
> make it possible to start application, but I never looked at that. Right
> now there are other things with higher priority.
>=20
> Regards
>=20
> Marcel
>=20
[Claudio Takahasi]
Basically two bus type are available: system and session.
System bus is not able to start applications with user interfaces
because the dbus-daemon is running with root permissions.
I already implemented D-Bus service for pand including daemon
initiation and it is working fine.
Use DBUS for request BlueZ services will be nice because it's=20
possible handle security issues and concurrency.
DBus signal can be used to notify all D-BUS registered applications about
new devices, new services, connection problems, ...

D-Bus is under development and some changes can occur, but it's
possible develop some workarround to make the application compliant
with Dbus 0.34, 0.33 and 0.23.

Regarding MIME types and Gnome VFS  I am not familiar enough to
send comments.... sorry.


Regards,
Claudio

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
