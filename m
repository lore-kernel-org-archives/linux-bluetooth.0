Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0504291520167b9bb8@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1114778617.8836.88.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
	 <1114778617.8836.88.camel@pegasus>
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
Date: Fri, 29 Apr 2005 19:20:54 -0300

Hi Marcel,

My application will provide a DBUS service and
APIs to alows user mode applications interact
with diferent types of Wireless/Wired connections.
This is the reason to create a BlueZ library based
on pand and hcitool functions. My application should
the able to retrieve bluetooth device information,
including establish connection, disconnect, link
status, new devices/services, ...
The DBUS service will not be provided at BlueZ level.

The current DBUS message in the hcid is used to handle
security/authentication issues. This message has a
different proposal. Therefore, use the same macro
"--enable-dbus" to enable/disable is not a good ideia.

Another important information is: the user mode
application doesn't need root privileges to create
a bluetooth connection, because it will request using
APIs and DBUS service.

Can I create a library in the pand directory and
reuse the common codes?
I suggest a directive like "--enable-panz" because
this library aims provide functions to hide connection
details.
Do you agree?


Regards,
Claudio.

On 4/29/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > Let me try justify why I need a new library.
> > 1. A DBUS app should not contain specific bluetooth/Wi-Fi/GPRS connecti=
on code.
> >     In my opinion, it is better abstract the connection details.
> > 2. Features required by DBUS app: signal strength, connection establish=
ment,
> >     disconnection, new device notification(search for service
> > frequently), automatic
> >     IP assigment(with IP conflict resolution and IP announment),
> > device information,
> >     active connections, security info, connection lost, ...
> >     All these features should be provided by a BlueZ library. At the
> > moment, pand
> >     and hcitool provide part of these. However, they are command line
> > application
> >     and a DBUS app should use a workaround approach:  "execv" function
> > 3. Consider an embedded device, control connections using a DBUS app
> >     is the better way to this task. Execute a command line app is not
> > appropriated
> >     to handle this context. An embedded app using  wireless connection
> >     should abstract connection establishment/control details.
> >
> > This is the scenario that I am working on, if I can't contribute
> > developing this library,
> > I will try move all these required features to DBUS app level without
> > add functions/library
> > to BlueZ.
>=20
> think about adding all you need to pand and then start it for example
> with a --dbus option to activate that service via D-Bus.
>=20
> When writing code use the BlueZ coding style. This means, use tabs. For
> the patches, create them with "cvs diff -u" from the BlueZ CVS and make
> sure that you executed "make maintainer-clean" first.
>=20
> Regards
>=20
> Marcel
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=3D105hix
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20


--=20
_______________________________________
Claudio Takahasi
INdT - Nokia Technology Institute
Phone: +55 81 21223034
Recife - Pernambuco - Brazil


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
