Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IOGear GBU301 and Kernel 2.4.20
From: Marcel Holtmann <marcel@holtmann.org>
To: Tom Watson <tsw@johana.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <411733d1.johana@johana.com>
References: <411733d1.johana@johana.com>
Content-Type: text/plain
Message-Id: <1092046722.21815.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 09 Aug 2004 12:18:42 +0200

Hi Tom,

> > > > this is a Broadcom BCM2033 dongle without firmware loaded. Install the
> > > > bluez-firmware package and use the bcm203x kernel driver from a recent
> > > > 2.6 kernel or compile bluez-utils-2.9 with bcm203x support.
> > > > 
> > > OK, This ought to be simple but...
> > > [ bluez-utils-2.9]# ./configure --prefix=/usr --mandir=/usr/share/man
> > > --sysconfdir=/etc --enable-bcm203x
> > > 
> > > Then...
> > > make clean    {I hadn't done the 'enable-bcm...'}
> > > 
> > > and then
> > > make
> > > 
> > > But it goes for a while and I get...
> > > gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include -Wall -g -O2 -c `test -f
> > > 'bcm203x.c' || echo './'`bcm203x.c
> > > cc1: warning: changing search order for system directory "/usr/include"
> > > cc1: warning:   as it has already been specified as a non-system directory
> > > bcm203x.c: In function `load_firmware':
> > > bcm203x.c:118: warning: implicit declaration of function `usb_interrupt_read'
> > > gcc -I/usr/include -Wall -g -O2   -o bcm203x  bcm203x.o -L/usr/lib -lusb
> > > bcm203x.o: In function `load_firmware':
> > > ...../bluez-utils-2.9/extra/bcm203x.c:118: undefined reference to
> > > `usb_interrupt_read'
> > > ...../bluez-utils-2.9/extra/bcm203x.c:133: undefined reference to
> > > `usb_interrupt_read'
> > > 
> > > This doesn't look too good.  Am I doing something wrong here??
> > 
> > you must install the development package of the USB library.
> > 
> 
> Well, I thought I had installed it.  I've got a RedHat system and I
> installed 'libusb-devel-0.1.6-3.i386.rpm' (from RH9.0 CD set).  I then
> again attempted the 'make' to only get the same results (no routine
> 'usb_interrupt_read').
> 
> Hopefully I haven't done anything more silly.
> I looked in /usr/lib and saw 'libusb.a' is this the correct library module?
> 
> If not, where should it be, and its name??

I never checked this before, but it seems that you need at least version
0.1.8 of that library. Prior versions don't have support for reading
from interrupt endpoints.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
