Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050711115470809e4a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] pand D-Bus service
In-Reply-To: <1120849681.7444.1.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05070811375af87810@mail.gmail.com>
	 <1120849681.7444.1.camel@notepaq>
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
Date: Mon, 11 Jul 2005 15:54:03 -0300

Hi Marcel,

According with your emails, bluetoothd shall provide=20
methods for settings and send signals.
I finished the D-Bus services for pand, now we need
define how organize these services.=20

In my opinion the bluetoothd should be responsible for
provide all D-Bus services, including pand, hidd, cip, ...
Create D-Bus services for each daemon will require=20
monitor a lot of dbus connections. It's easier and more
efficient create "profile objects" for each profile inside
bluetoothd. Buetoothd can monitor different interfaces and=20
objects.

Currently, my D-Bus pand implementation is providing:
  -adapters: show local bluetooth adapters
  -connect:connect to a bluetooth device
  -connections: show active connections
  -disconnect: kill connections
  -enable-bridge: enable automatic bridge creation on listening
  -find: search for a service
  -listen: start/stop listen for bluetooth connections
  -role: switch the role MASTER|SLAVE
  -udhcp:enable UDHCP on listen or connect
  -init: initialize the bluez pan daemon (pand)
  -kill: kill the pand


If you see the code of D-Bus hcid, the D-Bus message control functions
are similar. The best approach is move all to daemon directory.


What is your opinion?

Regards,
Claudio.


On 7/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > We exchanged some emails last month about D-Bus services
> > for pand. I implemented some D-Bus services, but ...
> > How will be the relationship between the pand and the "metaserver"?
> > It is not clear for me how the other daemons will
> > interact with the current bluez-utils daemons and tools
> > (pand, hidd, dund, rfcomm, ...).
>=20
> forget about the metaserver. This is something KDE specific at the
> moment.
>=20
> > Could you explain me how the D-Bus services will be organized?
>=20
> I am not 100% sure at the moment. Need to play with it a little bit
> more.
>=20
> Regards
>=20
> Marcel
>=20
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
