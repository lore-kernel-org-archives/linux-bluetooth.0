Return-Path: <sdc695@yahoo.com>
Message-ID: <20040809050753.17815.qmail@web60801.mail.yahoo.com>
Date: Sun, 8 Aug 2004 22:07:53 -0700 (PDT)
From: Tom Watson <sdc695@yahoo.com>
Reply-To: tsw@johana.com
Subject: Re: [Bluez-users] IOGear GBU301 and Kernel 2.4.20
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4116f4a0.johana@johana.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel...
The saga continues...
--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tom,
> 
> > > why don't include the content of /proc/bus/usb/devices?
> > > 
> > Your wish is my command....
> > 
> > >>>>>
> > T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
> > D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=0a5c ProdID=2033 Rev= 0.a0
> > C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
> > I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> > I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> > E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> > E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> > <<<<<
> > 
> > The above is just the part that is different between plugging in the IOGear
> > adapter and not.  I didn't want to complicate things with too much clutter
> 
> this is a Broadcom BCM2033 dongle without firmware loaded. Install the
> bluez-firmware package and use the bcm203x kernel driver from a recent
> 2.6 kernel or compile bluez-utils-2.9 with bcm203x support.
> 
> Regards
> 
> Marcel
> 

OK, This ought to be simple but...
[ bluez-utils-2.9]# ./configure --prefix=/usr --mandir=/usr/share/man
--sysconfdir=/etc --enable-bcm203x

Then...
make clean    {I hadn't done the 'enable-bcm...'}

and then
make

But it goes for a while and I get...
gcc -DHAVE_CONFIG_H -I. -I. -I..    -I/usr/include -Wall -g -O2 -c `test -f
'bcm203x.c' || echo './'`bcm203x.c
cc1: warning: changing search order for system directory "/usr/include"
cc1: warning:   as it has already been specified as a non-system directory
bcm203x.c: In function `load_firmware':
bcm203x.c:118: warning: implicit declaration of function `usb_interrupt_read'
gcc -I/usr/include -Wall -g -O2   -o bcm203x  bcm203x.o -L/usr/lib -lusb
bcm203x.o: In function `load_firmware':
...../bluez-utils-2.9/extra/bcm203x.c:118: undefined reference to
`usb_interrupt_read'
...../bluez-utils-2.9/extra/bcm203x.c:133: undefined reference to
`usb_interrupt_read'

This doesn't look too good.  Am I doing something wrong here??

Thanks.

=====
-- 
Tom Watson
tsw@johana.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
