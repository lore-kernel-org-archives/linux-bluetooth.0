Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: jbarnett@pobox.com, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1167843929.3164.1.camel@localhost>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost> <1167816533.20568.12.camel@violet>
	<1167843929.3164.1.camel@localhost>
Date: Wed, 03 Jan 2007 18:14:21 +0100
Message-Id: <1167844461.20568.18.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
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

Hi Jon,

> > please show us the content of /proc/bus/usb/devices for this dongle.
> 
> T:  Bus=05 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=413c ProdID=8126 Rev= 1.00
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM2045
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> 
> (Note this dongle is actually internally fitted on the Inspiron.)
> 
> > Does normal operation like scanning for other devices work if you don't
> > give the reset=1 quirk? If yes, then this one is not needed at all.
> 
> I didn't think it was needed and scanning works fine for devices that
> aren't paired.
> 
> > If you load the hci_usb driver without force_scofix=1, what does
> > hciconfig show you.
> 
> Removing all options, hciconfig -a hci0 gives the following:
> hci0:   Type: USB
>         BD Address: 00:16:CF:CE:C2:75 ACL MTU: 1017:8 SCO MTU: 64:8
>         UP RUNNING PSCAN 
>         RX bytes:659 acl:0 sco:0 events:19 errors:0
>         TX bytes:323 acl:0 sco:0 commands:19 errors:0
>         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'BlueZ (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing, Object
> Transfer, Audio
>         Device Class: Computer, Uncategorized
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x20da LMP Ver: 2.0 (0x3) LMP
> Subver: 0x4182
>         Manufacturer: Broadcom Corporation (15)

did you reload the driver or reboot your system? This would have been
the first Broadcom chip where the values are correct. Can you
check /sys/class/module/parameters/* that no quirk is actually active.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
