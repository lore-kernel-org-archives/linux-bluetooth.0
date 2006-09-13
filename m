Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 13 Sep 2006 22:56:43 +0200
References: <200609032015.51210.cijoml@volny.cz>
	<200609062040.14856.cijoml@volny.cz>
	<1157588855.30159.49.camel@aeonflux.holtmann.net>
In-Reply-To: <1157588855.30159.49.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200609132256.43426.cijoml@volny.cz>
Subject: Re: [Bluez-users]
	=?iso-8859-2?q?bluez_utils_debian_package_doesn=27t?=
	=?iso-8859-2?q?_autoswith=09dongle_on=3F?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

can you help with that dbus thing? I can't get it work and there is probabl=
y =

no howto :(

hcid still fails for me saying that annoying dbus error

Michal

Dne =E8tvrtek 07 z=E1=F8=ED 2006 02:27 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > Second problem is, that hcid doesn't start:
> >
> > Sep  6 20:39:17 localhost hcid[27463]: Bluetooth HCI daemon
> > Sep  6 20:39:17 localhost hcid[27463]: Can't open system message bus
> > connection: Failed to connect to socket /var/run/dbus/system_bus_socket:
> > No such file or directory
> > Sep  6 20:39:17 localhost hcid[27463]: Unable to get on D-Bus
> >
> > What is this about??? I can't find any Debian package for this...
>
> make sure that dbus or dbus-1 is installed and the system message is
> running. You might have to reboot the system.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
