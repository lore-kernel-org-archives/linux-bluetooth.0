Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 13 Sep 2006 23:41:24 +0200
References: <200609032015.51210.cijoml@volny.cz>
	<200609132256.43426.cijoml@volny.cz>
	<1158182872.4485.16.camel@localhost>
In-Reply-To: <1158182872.4485.16.camel@localhost>
MIME-Version: 1.0
Message-Id: <200609132341.24745.cijoml@volny.cz>
Subject: Re: [Bluez-users]
	=?iso-8859-2?q?bluez_utils_debian_package_doesn=27t?=
	=?iso-8859-2?q?=09autoswith=09dongle_on=3F?=
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

Hmm...

It finally registered itself, but why you used D-Bus? Wouldn't CORBA better =

fit this purpose?

Michal

Dne st=F8eda 13 z=E1=F8=ED 2006 23:27 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > can you help with that dbus thing? I can't get it work and there is
> > probably no howto :(
> >
> > hcid still fails for me saying that annoying dbus error
>
> I have tested this on Debian Unstable, Ubuntu Dapper and Fedora Core 5
> and I don't have any problems. However you need to install the D-Bus
> packages and make sure the system has been started. It is also a good
> idea to follow the configure options from the README file.
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
