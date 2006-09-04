Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Hentai Pantsu <sugoi.sama@gmail.com>
Date: Mon, 4 Sep 2006 02:02:13 +0000 (UTC)
Message-ID: <loom.20060904T035200-810@post.gmane.org>
References: <7f52ac20609020846t3084fd6h441e2332029f9972@mail.gmail.com>
	<1157319053.32195.11.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel]
	=?utf-8?q?hid2hic_among_others_fails_to_build=09in_?=
	=?utf-8?q?bluez-utils-3=2E4?=
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

> > 
> > When typing "make all | grep hid2" it doesn't print anything.
> > 
> > The bluez-utils tarball compiles and installs, among others, hidd.
> > 
> > 
> > What's wrong with this? :(
> 
> no idea. It works fine for me.


shh... i finally solved the problem after some head banging... There is an order
that needs to be followed:
1) install bluez-libs
2) install libopenobex1-dev, libusb-dev    # obex depends on bluez-libs
3) install bluez-utils                     # utils depends on obex
...


> 
> > I'm using Debian unstable (their package is version 3.1, that's why i
> > have to install bluez from scratch)
> 
> Tell them to update their packages. The 3.1 version has too many bugs
> anyway.


Tell me about it. It's Debian *unstable*, it is supposed to have the latest
packages...
I'll msg them...

Problem solved. Thanks.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
