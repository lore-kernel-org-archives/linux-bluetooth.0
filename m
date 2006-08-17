Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200608162208.37986.akohlsmith-bluez@benshaw.com>
References: <200608161159.35033.akohlsmith-bluez@benshaw.com>
	<1155769899.4075.95.camel@aeonflux.holtmann.net>
	<200608162208.37986.akohlsmith-bluez@benshaw.com>
Date: Thu, 17 Aug 2006 14:43:19 +0200
Message-Id: <1155818599.4075.110.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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

> > the pkg-config part only sets *_found and you need *_enable to actually
> > activate an optional feature.
> 
> Seems like a weak way to check for a library, but I imagine that only the 
> slackware and slackware-derived distros would have this particular issue:
> 
> checking pkg-config is at least version 0.9.0... yes
> checking for BLUEZ... Package bluez was not found in the pkg-config search 
> path.
> Perhaps you should add the directory containing `bluez.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'bluez' found
> configure: error: Bluetooth library is required
> 
> $ BLUEZ_CFLAGS=-I~/files/bluez-libs-3.2/include 
> BLUEZ_LIBS="-L~/files/bluez-libs/src/.libs -lbluetooth" ./configure
> 
> This lets it work, so there's a viable workaround for us old coots.  :-)

you might wanna try to set PKG_CONFIG_PATH to make it find the needed
bluez.pc file. Check "man pkg-config" for more details.

> > You should have. The sample calls for configure can be found in the
> > README and I simply don't see any problem at the moment. I need some
> > more input here.
> 
> No, I was mistaken here.  I reran the configuration with the command line 
> above and pkg-config told the configure script that fuse, openobex and libusb 
> weren't found, but let it build regardless.

If these libraries are not found, none of them get build. You might see
make entering these subdirectories, but that's it.

> > I am not going to change this back. Otherwise we would have needed a
> > complete separate protocol and this would have bloated the Bluetooth
> > code. And the requirement of XML is a myth. It brings its own XML parser
> > with it.
> 
> A complete separate protocol to do what?  v2.25 seems to get by fine without a 
> notification subsystem.

It is more than simple notification thingy. You can control all needed
functionality. And this is why it is 3.x now and no longer 2.x.

> Regarding dbus and an xml requirement -- the dbus wiki page seems to disagree 
> with you on this.  From http://www.freedesktop.org/wiki/Software/dbus:
> 
> "D-Bus' only *required* dependency is an XML parser (either libxml or expat)."

Then go with expat. It is small and lightweight.

> I will make another attempt at building dbus and bluez-3.2 under my embedded 
> environment.  I may have been overly impatient in trying to get it to work.

Nobody said, that it is easy, but even the Nokia 770 for example is
happy with D-Bus and I know that a lot of embedded people actually use
D-Bus instead inventing a message bus over and over.

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
