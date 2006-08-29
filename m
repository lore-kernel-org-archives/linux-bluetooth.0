Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F4A0FC.3090809@pracucci.com>
Date: Tue, 29 Aug 2006 20:18:04 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <10d5a94bb15.squonimo@virgilio.it>
In-Reply-To: <10d5a94bb15.squonimo@virgilio.it>
Subject: Re: [Bluez-devel] problem with bluez-utils 3.4 and dbus
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

Hi Alex,

> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-
> linux/bin/ld:
> cannot find -ldbus-glib-1
> collect2: ld returned 1 exit 
> status

Have you cross compiled dbus?
If you have cross compiled dbus you should add -L<dbus library path> to
LDFLAG, where <dbus library path> is the path to the cross compiled dbus
library.

Moreover, if you have cross compiled dbus, can you tell us how you have
successfully run the configure script?

Regards,
Marco Pracucci


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
