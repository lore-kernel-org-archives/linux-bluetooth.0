Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44E33635.1030007@ipb.pt>
Date: Wed, 16 Aug 2006 16:13:57 +0100
From: Rui Pedro Lopes <rlopes@ipb.pt>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20060816142750.29806.qmail@web51415.mail.yahoo.com>
In-Reply-To: <20060816142750.29806.qmail@web51415.mail.yahoo.com>
Subject: Re: [Bluez-users] Totally confused
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

manojt ambe wrote:
> I modified /usr/local/etc/dbus-1/system.conf as below. After this
> the pin problem went away. I am using bluez 3.1 and dbus 0.62.  Pls
> find system.conf attached.
> 
> <!-- This is included last so local configuration can override what's
> in this standard file -->
> <include
> ignore_missing="yes">/etc/dbus-1/system.d/bluez-hcid.conf</include>
>
I believe that this line is useless, because the previous includes
everything in the system.d directory, including bluez-hcid.conf.
However, I tried using yout system.conf and I keep getting the same
problem...

Cheers,

/rp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4zY1AhGrHSs5PNIRAhXBAJ9iI56ZHOlbiLOQnp14lttQlVTjEwCghOAz
hh7EwZaL8ODWxuA3/c3ndZA=
=J/+l
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
