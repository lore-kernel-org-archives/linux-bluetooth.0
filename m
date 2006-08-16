Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-users@lists.sf.net
Date: Wed, 16 Aug 2006 11:59:34 -0400
MIME-Version: 1.0
Message-Id: <200608161159.35033.akohlsmith-bluez@benshaw.com>
Subject: [Bluez-users] turning OFF dbus and other extras support?
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

It appears that the autoconf process is a little wonky at the present.  Are 
these known issues?

Specifically, autoconf doesn't seem to listen to the negative-versions of 
--enable (i.e. disable support), and the pkg-config output is taken as 
gospel.

I can't disable fuse support with --enable-fuse=no or --disable-fuse (nor 
cups, haven't tried others).  I'm running Slackware 10.2 which does have 
pkg-config, and which does respond correctly.  I did not install bluez-libs 
as a package, but it *is* installed; the environment variable overrides are 
not heeded, so I have to mangle the Makefile or configure script manually to 
get the thing to compile.

I was also hoping that you'd hear my plea for the ability to make dbus support 
*optional* -- I'm using bluez in an embedded system and have to thus stick 
with an older (and non-supported) version.  dbus support adds a LOT of 
additional requirements, including XML, and that's a significant addition to 
any small system.

-A.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
