Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Steve Finney <sfinney@healthhero.com>
Date: Wed, 28 Jun 2006 17:11:30 +0000 (UTC)
Message-ID: <loom.20060628T190947-394@post.gmane.org>
References: <loom.20060628T033626-329@post.gmane.org>
	<1151479698.9544.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] cross-compiling bluez-utils.3.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> the D-Bus library is mandatory now. Hence the new major version number.

> Regards

> Marcel

D-Bus seems like a useful tool for desktops, but possibly overkill 
and/or unnecessary for embedded systems. Also, as noted before, D-Bus
will not build out of the box for cross-compiled systems such as ARM.
Since a lot of embedded systems use Bluetooth, this seems problematic.

What exactly does D-Bus supply in terms of necessary/useful functionality for
Bluetooth, and how difficult would it be to work around having to use it? (I
have not taken a serious look at the new release yet, as I'm still working
on a basic understanding of the 2.21 version).
sf






Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
