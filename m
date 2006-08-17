Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060817112226.GA5118@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<66dc03c80608161821pda00e42ra69e3775814614de@mail.gmail.com>
	<20060817081503.GA1086@srcf.ucam.org>
	<1155819475.4075.126.camel@aeonflux.holtmann.net>
	<20060817112226.GA5118@srcf.ucam.org>
Date: Thu, 17 Aug 2006 15:51:04 +0200
Message-Id: <1155822664.4075.142.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus interface - determining whether
	a	device	exists
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

Hi Matthew,

> > what you actually want is something like l2ping so see if a device is
> > alive or not. At the moment I am not considering such an extension,
> > because we shouldn't page devices to see if they are active or not.
> 
> Why not? It seems more sensible to do that than to blindly attempt to 
> set up a hid connection without knowing whether the device actually 
> exists or not.

the HID case doesn't fly. All HID devices only need an initial connect
and the they reconnect to the host.

But again, the costs of getting this knowledge are to expensive. In most
cases you have to serialize page attempts and make sure you don't
interrupt inquiries or disturb other connections. For example the high
quality audio part might not really like that you try to page other
devices a lot of times. It will work, but if the audio stream breaks to
often you have a bad user experience.

Once we offer such a method it gets used and it will get abused for
weird tricks application wanna play. So you need a better argument to
convince me to include something like this.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
