Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20060628T190947-394@post.gmane.org>
References: <loom.20060628T033626-329@post.gmane.org>
	<1151479698.9544.1.camel@localhost>
	<loom.20060628T190947-394@post.gmane.org>
Date: Wed, 28 Jun 2006 19:33:40 +0200
Message-Id: <1151516020.26495.10.camel@localhost>
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

Hi Steve,

> D-Bus seems like a useful tool for desktops, but possibly overkill 
> and/or unnecessary for embedded systems. Also, as noted before, D-Bus
> will not build out of the box for cross-compiled systems such as ARM.
> Since a lot of embedded systems use Bluetooth, this seems problematic.

I am aware of embedded systems and a long time this was the reason for
keeping D-Bus optional. In the long run it is not worth it and it would
only increase the complexity. Devices like the Nokia 770 proved that we
can handle D-Bus in the embedded area and if there are problems, they
must be addressed in D-Bus.

> What exactly does D-Bus supply in terms of necessary/useful functionality for
> Bluetooth, and how difficult would it be to work around having to use it? (I
> have not taken a serious look at the new release yet, as I'm still working
> on a basic understanding of the 2.21 version).

D-Bus is a message bus (IPC based). Something like RPC and it makes
writing client applications a lot easier. The BlueZ D-Bus API provides a
clean interface to basic Bluetooth tasks. You don't need any knowledge
about HCI anymore. You can also write your application in C, C++, Java,
Python, C# etc. and they don't need to be put under GPL.

Trying to implement your own message bus to avoid the D-Bus dependency
is not worth it. We considered it in the beginning, but this would
increase the complexity without any real benefit.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
