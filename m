Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c34db00708072235j3954de14icb69e75bde3d7b72@mail.gmail.com>
References: <b5c34db00708072235j3954de14icb69e75bde3d7b72@mail.gmail.com>
Date: Wed, 08 Aug 2007 10:17:51 +0200
Message-Id: <1186561071.20129.85.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez-utils and bluez-libs
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

>    I am working on Au1200 processor and i use linux-2.6.11 and now i
> am trying USB Bluetooth in it .I need to compile bluetooth libraries
> and bluetooth utils for it.I downloaded the following files,
> bluez-libs-3.13.tar.gz
> 
> bluez-utils-3.13.tar.gz
> 
> I compile the library as follows,
> ./configure --host=mipsel --prefix=/usr --enable-shared=no
> --enable-static=yes
> make
> make install DESTDIR=$PWD/bluez1
> 
> it compiled and next to compile bluez-utils
> 
> ./configure \
> --host=mipsel \
> --with-bluez=$PWD/../bluez-libs-2.25/install/usr \
> CPPFLAGS="-DLINUX" \
> LDFLAGS="-Wl,-elf2flt"
> 
> then make
> 
> following are the errors ,
> 
> make[3]: Entering directory
> `/home/busybox/bluez/bluez-utils-3.13/hcid'
> gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd -DLINUX
> -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
> -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2
> -MT device.o -MD -MP -MF .deps/device.Tpo -c -o device.o device.c
> device.c: In function 'start_device':
> device.c:271: error: 'LMP_PAUSE_ENC' undeclared (first use in this
> function)
> device.c:271: error: (Each undeclared identifier is reported only once
> device.c:271: error: for each function it appears in.)
> device.c:277: error: 'LMP_NFLUSH_PKTS' undeclared (first use in this
> function)
> device.c:280: error: 'LMP_LSTO' undeclared (first use in this
> function)
> make[3]: *** [device.o] Error 1
> make[3]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13/hcid'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13/hcid'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/busybox/bluez/bluez-utils-3.13'
> make: *** [all] Error 2
> 
> could anyone tell me where am going wrong.

your includes are screwed up. You need to make sure it uses the headers
of bluez-utils-3.13 and not some older ones installed one your system.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
