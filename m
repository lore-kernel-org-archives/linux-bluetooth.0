Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060711133956.GD13809@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost> <20060711133956.GD13809@suse.de>
Date: Tue, 11 Jul 2006 15:46:31 +0200
Message-Id: <1152625591.15028.35.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1 SCO
	packet	for	unknown connection handle 0
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

Hi Stefan,

> > > i have an el-cheapo USB BT dongle in front of me that throws an endless
> > > stream of
> > > kernel: hci_scodata_packet: hci1 SCO packet for unknown connection handle 0
> > > after inserting it into the USB port, unless i do
> > > echo 1 > /sys/module/hci_usb/parameters/isoc
> > > 
> > > I don't know about the usual practice in such cases: do those devices get
> > > blacklisted in the drivers? If yes, what information should i provide to
> > > get it into the blacklist?
> > 
> > what does "hciconfig -a" tells you about this dongle? The content
> 
> root@strolchi:~# hciconfig -a hci1
> hci1:   Type: USB
>         BD Address: 00:0C:78:31:11:0A ACL MTU: 339:4 SCO MTU: 60:9
>         UP RUNNING
>         RX bytes:419 acl:0 sco:0 events:19 errors:0
>         TX bytes:319 acl:0 sco:0 commands:17 errors:0
>         Features: 0xff 0xff 0x81 0x00 0x18 0x18 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ strolchi (1)'
>         Class: 0x100100
>         Service Classes:
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x222 LMP Ver: 1.2 (0x2) LMP Subver: 0x222
>         Manufacturer: RTX Telecom A/S (21)
> 
> > from /proc/bus/usb/devices for this device might also be helpful.
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0400 ProdID=080a Rev= 1.00
> C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
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
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> This is all with isoc=1, as otherwise my syslog fills quicker than i am
> able to free space on my drive :-)

actually with isco=1 the SCO transfers are still on, but limited to
8-bit instead of 16-bit with isoc=2. So if you have isoc=2 it fills up
your syslog. Can you extract some of these SCO packets with hcidump for
me.

My problem is now that I can only fully blacklist the SCO support for
this dongle. I can't force the Bluetooth core into using 8-bit only.

Any chance of a name or identification of this dongle?

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
