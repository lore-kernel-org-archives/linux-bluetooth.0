Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 22 Jun 2006 15:53:51 +0200
From: =?iso-8859-1?Q?=22Hans-J=FCrgen_Lange=22?= <Hans-Juergen.Lange@gmx.de>
In-Reply-To: <1150983661.13991.51.camel@localhost>
Message-ID: <20060622135351.253940@gmx.net>
MIME-Version: 1.0
References: <20060622131954.253990@gmx.net>
	<1150983661.13991.51.camel@localhost>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcid does not start. Can't open
	system	message	bus connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


-------- Original-Nachricht --------
Datum: Thu, 22 Jun 2006 15:41:01 +0200
Von: Marcel Holtmann <marcel@holtmann.org>
An: BlueZ users <bluez-users@lists.sourceforge.net>
Betreff: Re: [Bluez-users] hcid does not start. Can\'t open system	message	=
bus connection

> Hi Hans-Juergen,
> =

> > I need bluetooth and wanted to use bluez-3.1 because this is the actual
> link from the home page.
> > Nothing works.
> > =

> > I dont have and dont want a system message bus. =

> =

> every modern distribution configures and starts the D-Bus system message
> bus. Check with your distribution.
> =

> > Earlier versions of bluez are not available from the homepage. Mailing
> lists archivs are not available. =

> =

> Every 2.x and 3.x source tarball is still available. However it is not
> linked from the website.
> =

> The Sourceforge mailing list archives are down. Use the Gmane ones.
> =

> > auth keyword in hcid.conf has been optimized out of the configuration
> but man pages describes them.
> =

> This has already been fixed in the CVS.
> =

> > Any idea how to get bluetooth working. Maybe another solution is present
> that do work???
> =

> Make sure you installed D-Bus and it starts the system message bus.
> =

> Regards
> =

> Marcel
> =

> =

> =

> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



Where can I download earlier Versions???
How to access the cvs???

I dont want to start something that I dont need. No part of my system do ne=
ed the system message bus. For what??? The machine I use is a diskless X te=
rminal. And therefor I dont want to load the CPU and memory with something =
I dont need.

Installation of a newer distribution is not possible because non will let m=
e install the system from a NFS server only by booting the kernel and setup=
 some parameters. Diskless means diskless. No floppy no CD only a remote bo=
ot prom.

BR
Hans-Juergen Lange
-- =



Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

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
