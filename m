Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4532A5C1.4080504@xmission.com>
References: <453296A6.5030505@xmission.com>
	<1160943663.14340.10.camel@localhost> <4532A5C1.4080504@xmission.com>
Date: Sun, 15 Oct 2006 23:29:21 +0200
Message-Id: <1160947761.14340.13.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] pskey gone, but bccmd won't build
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

Hi Brad,

> >> I noticed pskey disappear from utils/tools in cvs. Is bccmd preferred
> >> for setting pskey values? bccmd won't build from the current utils.
> > 
> > bccmd is the successor of pskey and you should use --enable-bccmd to
> > build and install it correctly.
> 
> (I can't do a toplevel make: there is a dbus problem on ubuntu and
> --disable-dbus doesn't really disable dbus)

the D-Bus is mandatory, so you can't disable it. However there is no
D-Bus problem with Ubuntu Dapper or Edgy. I tested both by myself.

> shouldn't this work?
> 
> $ ./configure --enable-bccmd
>  ...
> $ make -C common/
>  ...
> $ make -C tools
>  ...
> $ make -C tools bccmd
> make: Entering directory
> `/media/usbdisk/goo/home/bmidgley/src/bluez/utils/tools'
> /bin/sh ../libtool --mode=link gcc -I/usr/local/include
> -I/usr/local/include -Wall -O2 -D_FORTIFY_SOURCE=2  -o bccmd
> gcc -I/usr/local/include -I/usr/local/include -Wall -O2
> -D_FORTIFY_SOURCE=2 -o bccmd
> gcc: no input files
> make: *** [bccmd] Error 1
> make: Leaving directory
> `/media/usbdisk/goo/home/bmidgley/src/bluez/utils/tools'

Call configure with --enable-bccmd and then call make in the common and
tools directory. That should work fine.

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
