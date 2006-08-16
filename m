Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200608161159.35033.akohlsmith-bluez@benshaw.com>
References: <200608161159.35033.akohlsmith-bluez@benshaw.com>
Date: Thu, 17 Aug 2006 01:11:39 +0200
Message-Id: <1155769899.4075.95.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] turning OFF dbus and other extras support?
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

Hi Andrew,

> It appears that the autoconf process is a little wonky at the present.  Are 
> these known issues?
> 
> Specifically, autoconf doesn't seem to listen to the negative-versions of 
> --enable (i.e. disable support), and the pkg-config output is taken as 
> gospel.

the pkg-config part only sets *_found and you need *_enable to actually
activate an optional feature.

> I can't disable fuse support with --enable-fuse=no or --disable-fuse (nor 
> cups, haven't tried others).  I'm running Slackware 10.2 which does have 
> pkg-config, and which does respond correctly.  I did not install bluez-libs 
> as a package, but it *is* installed; the environment variable overrides are 
> not heeded, so I have to mangle the Makefile or configure script manually to 
> get the thing to compile.

You should have. The sample calls for configure can be found in the
README and I simply don't see any problem at the moment. I need some
more input here.

> I was also hoping that you'd hear my plea for the ability to make dbus support 
> *optional* -- I'm using bluez in an embedded system and have to thus stick 
> with an older (and non-supported) version.  dbus support adds a LOT of 
> additional requirements, including XML, and that's a significant addition to 
> any small system.

I am not going to change this back. Otherwise we would have needed a
complete separate protocol and this would have bloated the Bluetooth
code. And the requirement of XML is a myth. It brings its own XML parser
with it.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
