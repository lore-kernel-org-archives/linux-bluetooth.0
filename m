Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IOGear GBU301 and Kernel 2.4.20
From: Marcel Holtmann <marcel@holtmann.org>
To: tsw@johana.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040809231313.17901.qmail@web60806.mail.yahoo.com>
References: <20040809231313.17901.qmail@web60806.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1092124756.4564.61.camel@pegasus>
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
Date: Tue, 10 Aug 2004 09:59:16 +0200

Hi Tom,

> > > > this is a Broadcom BCM2033 dongle without firmware loaded. Install the
> > > > bluez-firmware package and use the bcm203x kernel driver from a recent
> > > > 2.6 kernel or compile bluez-utils-2.9 with bcm203x support.
> > > > 
> 
> Well, I did compile bluez-utils (and installed it) as well as bluez-firmware. 
> That now seems to go well.  Now when I plug in the dongle I get the following
> in '/var/log/messages':
> Aug  9 16:00:02 xyzzy kernel: hub.c: new USB device 00:10.1-2, assigned address
> 6
> Aug  9 16:00:02 xyzzy kernel: usb.c: USB device 6 (vend/prod 0xa5c/0x2033) is
> not claimed by any active driver.
> Aug  9 16:00:05 xyzzy /etc/hotplug/usb.agent: Setup hci_usb for USB product
> a5c/2033/a0
> 
> But I still get the following in /proc/bus/usb/devices
> >>>>>
> < T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  7 Spd=12  MxCh= 0
> < D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> < P:  Vendor=0a5c ProdID=2033 Rev= 0.a0
> < C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
> < I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> < E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> < E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> < I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> < E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> < I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=83(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
> < E:  Ad=03(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
> < I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> < E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> < I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> < E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> < I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> < E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> < I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> < E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> < E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> < I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> < E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> < E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> <<<<<
> 
> Do I need to add something to load the firmware into the dongle??
> It appears that the ...utils... added something to the hotplug stuff for the
> broadcom chipset, and it should work.  Obviously it isn't.

I thought this was already answered. You must use --enable-bcm203x to
compile the firmware loader. After installation you will see

        /etc/hotplug/usb/bcm203x.usermap
        /etc/hotplug/usb/bcm203x

in the hotplug directories. Maybe your hotplug scripts are too old and
they can't work with extra entries under /etc/hotplug/usb/.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
