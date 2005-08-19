Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <8c9e090508191027e4646f1@mail.gmail.com>
From: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <elvis.pfutzenreuter@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <9307f5f2050818135877575293@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_949_27446233.1124472468027"
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050816154545b6f046@mail.gmail.com>
	 <e1effdeb05081805054a0be4aa@mail.gmail.com>
	 <9307f5f2050818135877575293@mail.gmail.com>
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
Date: Fri, 19 Aug 2005 14:27:48 -0300

------=_Part_949_27446233.1124472468027
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Probably my poor english caused some misunderstanding, the address
> *IS* part of the object path already, I can handle several adapters
> without any problems right now, and every adapter has a path like
> /org/bluetool/<BDADDR>/device


Maybe even the "device" word in the path is unnecessary, since the address=
=20
implies the notion of an adapter? Also, if you want to support multiple BT=
=20
adapters, there could be a "default" path (independent of the address) so=
=20
most applications would just use that instead of first finding the mac=20
addresses of the adapters... How many machines in the world have more than =
1=20
adapter? :)=20


if the property is not a string or the parameters are not bytes, an
> exception is thrown by the dbus wrapper (see the 'try' block at the
> beginning?) and I send an error message back to the caller explaining
> the error, otherwise everything goes on linearly
>=20
> What the "database" does (this database is not sdpd, it's an object
> created by the bluetool daemon), is simply to find what "helpers" are
> installed (ie: reading a list from a configuration file) and execute
> them, not much more actually :) every helper in turn registers its own
> object path and waits


So, as I could understand, you would use one process per profile, and the=
=20
main deamon would forward orders via DBUS to these 'slaves'?

Another thing, will all these deamons be integrated into bluez-utils? Or it=
=20
would be an independent BT deamon initiative? Which would be the dependency=
=20
relationship with bluez-utils, and other libraries like, possibly, glib?

A last comment (given that my DBUS knowledge is poor) would be that throwin=
g=20
all interfaces on the same object turns more difficult to the clients to=20
identify which services are available (they would have to use some form of=
=20
interface introspection (which is probably more boring than just scanning=
=20
the object namespace?). Also, I don't know if it is possible to turn on/tur=
n=20
off some interface on an object at will during runtime - registering and=20
unregistering an object I know it is quite easy :P
--
Elvis

------=_Part_949_27446233.1124472468027
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Probably my =
poor english caused some misunderstanding, the address<br>*IS* part of the =
object path already, I can handle several adapters
<br>without any problems right now, and every adapter has a path like<br>/o=
rg/bluetool/&lt;BDADDR&gt;/device</blockquote><div><br>
Maybe even the &quot;device&quot; word in the path is unnecessary, since th=
e
address implies the notion of an adapter? Also, if you want to support
multiple BT adapters, there could be a &quot;default&quot; path (independen=
t of
the address) so most applications would just use that instead of first
finding the mac addresses of the adapters... How many machines in the
world have more than 1 adapter? :)&nbsp;<br>
</div><div><br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">if the prop=
erty is not a string or the parameters are not bytes, an<br>exception is th=
rown by the dbus wrapper (see the 'try' block at the
<br>beginning?) and I send an error message back to the caller explaining<b=
r>the error, otherwise everything goes on linearly<br><br>What the &quot;da=
tabase&quot; does (this database is not sdpd, it's an object<br>created by =
the bluetool daemon), is simply to find what &quot;helpers&quot; are
<br>installed (ie: reading a list from a configuration file) and execute<br=
>them, not much more actually :) every helper in turn registers its own<br>=
object path and waits</blockquote><div><br>
So, as I could understand, you would use one process per profile, and
the main deamon would forward orders via DBUS to these 'slaves'?<br>
<br>
Another thing, will all these deamons be integrated into bluez-utils?
Or it would be an independent BT deamon initiative? Which would be the
dependency relationship with bluez-utils, and other libraries like,
possibly, glib?<br>
<br>
A last comment (given that my DBUS knowledge is poor) would be that
throwing all interfaces on the same object turns more difficult to the
clients to identify which services are available (they would have to
use some form of interface introspection (which is probably more boring
than just scanning the object namespace?). Also, I don't know if it is
possible to turn on/turn off some interface on an object at will during
runtime - registering and unregistering an object I know it is quite
easy :P<br>
&nbsp;</div></div>--<br>Elvis<br><br>

------=_Part_949_27446233.1124472468027--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
