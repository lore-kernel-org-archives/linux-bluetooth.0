Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050708092343073205@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
In-Reply-To: <1120834052.18553.123.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
	 <1120759981.18553.52.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
	 <e1effdeb05070805454b8960b6@mail.gmail.com>
	 <1120834052.18553.123.camel@pegasus>
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
Date: Fri, 8 Jul 2005 13:23:31 -0300

Hi Marcel,

On 7/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > Basically two bus type are available: system and session.
> > System bus is not able to start applications with user interfaces
> > because the dbus-daemon is running with root permissions.
>=20
> why is activation not working with the system bus. However we might have
> to use system and session bus at the same time.
No, It is working fine. I tested in D-Bus 0.23, 0.33 and 0.34.
I developed the D-Bus service for pand and it's possible start this daemon
using system Bus because there no graphical interface involved.
System bus is intended to be common for all user sessions and=20
session bus is restricted to the current user session.
If you need start a program that has graphical interface the activate reque=
st
should be sent to the session bus instance.

>=20
> > Use DBUS for request BlueZ services will be nice because it's
> > possible handle security issues and concurrency.
>=20
> This is the basic idea and it is the reason for putting everything
> inside bluetoothd and designing a new kernel interface.

I see a new repository in the CVS(Bluehood).  I think that this
daemon will be the metaserver, is that correct?

>=20
> > DBus signal can be used to notify all D-BUS registered applications abo=
ut
> > new devices, new services, connection problems, ...
>=20
> The new InquiryResult and RemoteName signals are implemented in hcid for
> testing. Start "dbus-monitor --system" and call "hcitool scan".
I didn't find  this code in the bluez-utils-2.18 code. Where is it? Could
you send me the CVS branch or the code?
I found references in the kbluetoothd(neighbourmonitor.cpp), but there is n=
o=20
D-Bus messages involved.

>=20
> > D-Bus is under development and some changes can occur, but it's
> > possible develop some workarround to make the application compliant
> > with Dbus 0.34, 0.33 and 0.23.
>=20
> I already did that, but I am not very happy with it. I actually really
> like to see the 1.0 release of their API.
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
