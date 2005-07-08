Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200507081451.38781.bluez-devel@schaettgen.de>
References: <1120747365.18553.15.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
	 <200507081451.38781.bluez-devel@schaettgen.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1120833804.18553.117.camel@pegasus>
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
Date: Fri, 08 Jul 2005 16:43:24 +0200

Hi Fred,

> > I don't see the advantage of having two different VFS modules for dev=
ice
> > and service discovery. And since both are only presenting stuff that =
can
> > be retrieved from bluetoothd they won't be highly complex.
>=20
> This one VFS module is just doing two different things, so it cleaner t=
o=20
> separate it. If you want those modules to show virtual folder for vario=
us=20
> purposes (recently seen devices, paired devices, hierarchical browse gr=
oups,=20
> whatever), then you have a clean namespace available for both parts.
> It=B4s no big advantage, but it=B4s not more difficult either. And it=B4=
s the status=20
> quo for kdebluetooth.

actually my plan was not to do that much inside the VFS module. My plan
is to leave some stuff for other people, because I am not really an UI
programmer ;)

> > Since Nautilus is supporting "Open with" it might be possible to assi=
gn
> > multiple applications to one MIME type. This also means that we need
> > different MIME types for each service/profile.
>=20
> AFAIK =A8Open with...=A8 is just good for opening a file with a given m=
imetype=20
> with another application that supports the same mimetype (like differen=
t text=20
> editors).

What is the difference. You have multiple applications dealing with the
MIME type for handsfree and one is default. I think that is what you was
asking for.

> > It was a long time ago when I read the RFC 2046. However after lookin=
g
> > through it, I think we must use the application main type with the x-
> > subtype. What about stuff like this:
> >
> > 	application/x-bt.device
> > 	application/x-bt.service
> >
> > 	application/x-bt.handsfree
> >
> > On the other hand I remembered that the BIP already needed special MI=
ME
> > types and it seems they are using x-bt/img-listing and so on for it.
>=20
> I really don=B4t care much.

I actually like to get opinion on it.

> But I wonder if this isn=B4t actually an abuse of mimetypes. Aren=B4t m=
imetypes=20
> supposed to declare the format of a file? Yet we are not talking about =
file=20
> contents at all here. Instead we associate a mimetype with a certain UR=
L=20
> format.

In general yes, but they always have been misused.

> At the moment, an item with the mimetype =A8bluetooth/obex-push-profile=
=A8 can=20
> only live inside the sdp kioslave.
> Maybe a more correct way would in fact be to have a helper application=20
> associated with the type application/x-bt.service, which gets the infor=
mation=20
> what device to connect to not from the URL, but from the URL contents.=20
> application/x-bt.service could simply be a file that contains the whole=
=20
> service record as xml, similar to the service record files for the=20
> metaserver. The applications would have to parse this xml file, which i=
sn=B4t=20
> very lightweight, but it gives all available information and we don=B4t=
 have to=20
> worry how to squezze everything into an URL.

I am not really happy with adding somekind of XML overhead.

> The only drawback I see here is that the user can=B4t change the=20
> service<->application association with the UI of the desktop. This UI i=
s=20
> about associating mimetypes with applications, but we would have our ow=
n=20
> UID<->application mapping then. It=B4s more work for us, but it appears=
 to be a=20
> better and more flexible design.
>=20
> Instead of handling a given mimetype, application would have to install=
 a=20
> bluetooth specific registration file instead. We could even let the hel=
per=20
> application (let=B4s call it service dispatcher) open the connection an=
d pass a=20
> file descriptor to the application, just the the metaserver, but for ou=
tgoing=20
> connection. This could be nice for very simple applications. =A8Real=A8=
=20
> application should get the bdaddr and rfcomm channel etc. from the serv=
ice=20
> dispatcher though, so they can reconnect themselves.

Too far in the future for me, because I am still working on the basis.

> > It will be root only, because otherwise it can't listen for kernel
> > events. We also need one central daemon to deal with all the stuff an=
d
> > so a session version makes no sense. However there is also no need it=
,
> > because it will communicate only over D-Bus and this can be made sess=
ion
> > aware. The D-Bus also have somekind of activation mechanism that shou=
ld
> > make it possible to start application, but I never looked at that. Ri=
ght
> > now there are other things with higher priority.
>=20
> Oh, I didn=B4t know that. The pin helper isn=B4t started via dbus curre=
ntly, or is=20
> it?

The current PIN helper can't do that, because it is D-Bus 0.23 based and
back then the activation service was no available. I am not fully happy
with switching over to D-Bus 0.34 at the moment. This might leave some
distributions behind and they may change parts of the API anyway.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
