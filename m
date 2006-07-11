Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 11 Jul 2006 15:39:56 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060711133956.GD13809@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152617098.15028.16.camel@localhost>
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1 SCO packet
	for	unknown connection handle 0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Tue, Jul 11, 2006 at 01:24:58PM +0200, Marcel Holtmann wrote:
> Hi Stefan,
> =

> > i have an el-cheapo USB BT dongle in front of me that throws an endless
> > stream of
> > kernel: hci_scodata_packet: hci1 SCO packet for unknown connection hand=
le 0
> > after inserting it into the USB port, unless i do
> > echo 1 > /sys/module/hci_usb/parameters/isoc
> > =

> > I don't know about the usual practice in such cases: do those devices g=
et
> > blacklisted in the drivers? If yes, what information should i provide to
> > get it into the blacklist?
> =

> what does "hciconfig -a" tells you about this dongle? The content

root@strolchi:~# hciconfig -a hci1
hci1:   Type: USB
        BD Address: 00:0C:78:31:11:0A ACL MTU: 339:4 SCO MTU: 60:9
        UP RUNNING
        RX bytes:419 acl:0 sco:0 events:19 errors:0
        TX bytes:319 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x81 0x00 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ strolchi (1)'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x222 LMP Ver: 1.2 (0x2) LMP Subver: 0x=
222
        Manufacturer: RTX Telecom A/S (21)

> from /proc/bus/usb/devices for this device might also be helpful.

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  3 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0400 ProdID=3D080a Rev=3D 1.00
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3D80 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

This is all with isoc=3D1, as otherwise my syslog fills quicker than i am
able to free space on my drive :-)


Thanks,

    Stefan
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
