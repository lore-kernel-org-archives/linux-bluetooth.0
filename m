Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05042905267bc91413@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1114768038.8836.42.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
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
Date: Fri, 29 Apr 2005 09:26:42 -0300

Hi Marcel,

Let me try justify why I need a new library.
1. A DBUS app should not contain specific bluetooth/Wi-Fi/GPRS connection c=
ode.
    In my opinion, it is better abstract the connection details.
2. Features required by DBUS app: signal strength, connection establishment=
,=20
    disconnection, new device notification(search for service
frequently), automatic
    IP assigment(with IP conflict resolution and IP announment),
device information,
    active connections, security info, connection lost, ...
    All these features should be provided by a BlueZ library. At the
moment, pand
    and hcitool provide part of these. However, they are command line
application
    and a DBUS app should use a workaround approach:  "execv" function
3. Consider an embedded device, control connections using a DBUS app=20
    is the better way to this task. Execute a command line app is not
appropriated
    to handle this context. An embedded app using  wireless connection
    should abstract connection establishment/control details.

This is the scenario that I am working on, if I can't contribute
developing this library,
I will try move all these required features to DBUS app level without
add functions/library
to BlueZ.

What is your opinion about this?

Best regards,
Claudio.


On 4/29/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I wrote the skeleton of the library. Please verify if I
> > am following the BlueZ principles.
> > At the moment, the code is not fully integrated
> > with BlueZ daemons and applications. Some functions
> > shall be changed due function outputs: the result
> > should be returned instead of displayed on the
> > screen.
> >
> > It is only a initial draft. The idea is provide a
> > library to user mode application controls bluetooth
> > connections. Please validate my suggestions before
> > I start coding and verify if this library can be
> > useful for BlueZ community. I know that some features
> > of this library are provided by "pand", but I need
> > control connections from a user mode application
> > or DBUS application.
>=20
> don't move anything around the utils directories. It is easier to do
> that later on when it is clear what to do. If you need some stuff that
> is not in the Bluetooth library duplicate the code for now.
>=20
> Since this is all about pand. Extend it with your functionality and put
> everything in the pand directory. I don't see any need for another
> library especially when you start talking about D-Bus integration.
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
>


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
