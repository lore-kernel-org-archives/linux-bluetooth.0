Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c34db00708210446k64253502w5dd9c7b49b5064ca@mail.gmail.com>
References: <b5c34db00708210446k64253502w5dd9c7b49b5064ca@mail.gmail.com>
Date: Fri, 24 Aug 2007 14:20:01 +0200
Message-Id: <1187958001.15402.160.camel@violet>
Mime-Version: 1.0
Cc: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] bluetooth compilation
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

> I work on Au1200 processor (its an MMU processor),ported linux-2.6.11
> kernel and i want to test usb blutooth dongle on this board when i
> compiled bluetooth libraries and utils (i downloaded the following
> versions bluez-libs-2.25.tar.gz,bluez-libs-2.25.tar.gz ) and followed
> compilation procedure,
> Compiling bluetooth libraries
> >./configure --host=mipsel --prefix=/usr --enable-shared=no
> --enable-static=yes
> >make
> >make install DESTDIR=/home/busybox/bluez/bluez- libs-2.25/install
> 
> Compiling bluetooth utils
> >./configure --host=mipsel
> --with-bluez=/home/busybox/bluez/bluez-libs-2.25/install/usr
> CPPFLAGS="-D__KERNEL__ $(LINUXINCLUDE)" LDDFLAGS="Wl,-elf2flt" 
> >make
> >make install DESTDIR=/home/busybox/bluez/bluez-utils-2.25/install
> 
> it doesnot execute and says binary file cannot be executed and when i
> remove LDDFLAGS  it leads to following errors,

this kernel version is no longer supported. Use something more recent
like 2.6.22 and BlueZ 2.x is also no longer supported. Use BlueZ 3.15.

However bluez-utils does not need any special kernel includes. It only
needs the includes from bluez-libs.

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
