Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20610190107je24b0bbg6bd5da0a05f6e0f2@mail.gmail.com>
References: <3f5a9ba20610152225h7e020518m3c6062ce9be25044@mail.gmail.com>
	<1161000951.10392.26.camel@localhost>
	<3f5a9ba20610190107je24b0bbg6bd5da0a05f6e0f2@mail.gmail.com>
Date: Thu, 19 Oct 2006 21:03:57 +0200
Message-Id: <1161284638.7885.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] the effect of linux 2.6.18 to the bluez
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

Am Donnerstag, den 19.10.2006, 16:07 +0800 schrieb Mingfan.Lu:

> I don't know whether the config make it happen or there is something
> wrong with it?
> So, Martin, How about you make config when you building your new
> kernel?

I build the kernels the "debian way" cause I use Ubuntu as well. So
basically:
(1) tar xjf linux-2.6.18.x.tar.bz2
(2) cd linux-2.6.18.x
(3) patch -p1 < ../patch-2.6.18-mh6
(4) cp /boot/config-2.6.15-26-686 .config
(5) make oldconfig
[edit some config options manually if necessary]
(6) fakeroot make-kpkg kernel_image modules_image --initrd --revision
mh6 binary
(7) cd ..
(8) dpkg -i kernel-image-2.6.18.xmh6_i386.deb

Edit /boot/grub/menu.lst if necessary and that's it.
Your problems are really strange. How do you measure the time? I don't
think it has anything to do with the config file per se. But I know of
some pretty neat and improved debugging facilities -- maybe you want to
check out that there is nothing in action that slows down the machine
just for the purpose of deadlock detections.

I'm sorry about it, but it seems extremely hard to me locating such a
problem that never affects one of my machines. :-/

Good luck,
Martin



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
