Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <db972f430708302356x1bcdbd6bn31369092d8ad7f58@mail.gmail.com>
References: <db972f430708302356x1bcdbd6bn31369092d8ad7f58@mail.gmail.com>
Date: Fri, 31 Aug 2007 16:06:38 +0200
Message-Id: <1188569198.13373.92.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] newbie questions on Bluez installation
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

Hi Ricky,

> I have just downloaded bluez-lib and bluez-utils-3.16 and ported to
> FC6 linux 2.6.18-1.2798.
> 
> After i did the ./configure, i did the usual "make" for both. This is
> the error for blue-utils-3.16 :
> 
> Entering the directory '/root/bluez-utils-3.16/hci'
> /bin/sh ../libtool --tag=CC   --mode=link gcc -I/usr/include/dbus-1.0
> -I/usr/lib/dbus-1.0/include   -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib
> -Wall -O2 -D_FORTIFY_SOURCE=2   -o hcid main.o
> libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a ../eglib/libeglib.la -L/lib -ldbus-1   -lbluetooth   -lexpat 
> gcc -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
> -DDBUS_API_SUBJECT_TO_CHANGE -I../eglib -Wall -O2 -D_FORTIFY_SOURCE=2
> -o hcid main.o
> libhciserver.a ../sdpd/libsdpserver.a ../common/libhelper.a ../eglib/.libs/libeglib.a -L/lib -ldbus-1 /usr/lib/libbluetooth.so /usr/lib/libexpat.so  
> libhciserver.a(device.o): In function `start_adapter':
> device.c:(.text+0x10c1): undefined reference to
> `hci_read_simple_pairing_mode'
> libhciserver.a(dbus-common.o): In function `unregister_sdp_record':
> dbus-common.c:(.text+0x90): undefined reference to
> `sdp_device_record_unregister_binary' 

you are not compiling against the latest bluez-libs.

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
