Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
References: <1120747365.18553.15.camel@pegasus> <200507080315.50686.bluez-devel@schaettgen.de> <1120804711.18553.100.camel@pegasus>
In-Reply-To: <1120804711.18553.100.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507081451.38781.bluez-devel@schaettgen.de>
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
Date: Fri, 8 Jul 2005 14:51:38 +0200

On Friday, 8. July 2005 08:38, Marcel Holtmann wrote:
=2E..
> I don't see the advantage of having two different VFS modules for device
> and service discovery. And since both are only presenting stuff that can
> be retrieved from bluetoothd they won't be highly complex.

This one VFS module is just doing two different things, so it cleaner to=20
separate it. If you want those modules to show virtual folder for various=20
purposes (recently seen devices, paired devices, hierarchical browse groups=
,=20
whatever), then you have a clean namespace available for both parts.
It=B4s no big advantage, but it=B4s not more difficult either. And it=B4s t=
he status=20
quo for kdebluetooth.

> Since Nautilus is supporting "Open with" it might be possible to assign
> multiple applications to one MIME type. This also means that we need
> different MIME types for each service/profile.

AFAIK =A8Open with...=A8 is just good for opening a file with a given mimet=
ype=20
with another application that supports the same mimetype (like different te=
xt=20
editors).

=2E..
> It was a long time ago when I read the RFC 2046. However after looking
> through it, I think we must use the application main type with the x-
> subtype. What about stuff like this:
>
> 	application/x-bt.device
> 	application/x-bt.service
>
> 	application/x-bt.handsfree
>
> On the other hand I remembered that the BIP already needed special MIME
> types and it seems they are using x-bt/img-listing and so on for it.

I really don=B4t care much.
But I wonder if this isn=B4t actually an abuse of mimetypes. Aren=B4t mimet=
ypes=20
supposed to declare the format of a file? Yet we are not talking about file=
=20
contents at all here. Instead we associate a mimetype with a certain URL=20
format.
At the moment, an item with the mimetype =A8bluetooth/obex-push-profile=A8 =
can=20
only live inside the sdp kioslave.
Maybe a more correct way would in fact be to have a helper application=20
associated with the type application/x-bt.service, which gets the informati=
on=20
what device to connect to not from the URL, but from the URL contents.=20
application/x-bt.service could simply be a file that contains the whole=20
service record as xml, similar to the service record files for the=20
metaserver. The applications would have to parse this xml file, which isn=
=B4t=20
very lightweight, but it gives all available information and we don=B4t hav=
e to=20
worry how to squezze everything into an URL.

The only drawback I see here is that the user can=B4t change the=20
service<->application association with the UI of the desktop. This UI is=20
about associating mimetypes with applications, but we would have our own=20
UID<->application mapping then. It=B4s more work for us, but it appears to =
be a=20
better and more flexible design.

Instead of handling a given mimetype, application would have to install a=20
bluetooth specific registration file instead. We could even let the helper=
=20
application (let=B4s call it service dispatcher) open the connection and pa=
ss a=20
file descriptor to the application, just the the metaserver, but for outgoi=
ng=20
connection. This could be nice for very simple applications. =A8Real=A8=20
application should get the bdaddr and rfcomm channel etc. from the service=
=20
dispatcher though, so they can reconnect themselves.

=2E..
> It will be root only, because otherwise it can't listen for kernel
> events. We also need one central daemon to deal with all the stuff and
> so a session version makes no sense. However there is also no need it,
> because it will communicate only over D-Bus and this can be made session
> aware. The D-Bus also have somekind of activation mechanism that should
> make it possible to start application, but I never looked at that. Right
> now there are other things with higher priority.

Oh, I didn=B4t know that. The pin helper isn=B4t started via dbus currently=
, or is=20
it?

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
