Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
Date: Fri, 23 Jan 2004 12:18:50 +0100
References: <200401221042.53134.mtortonesi@ing.unife.it> <200401221231.10350.mtortonesi@ing.unife.it> <1074771846.19046.19.camel@pegasus>
In-Reply-To: <1074771846.19046.19.camel@pegasus>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aMQEAw5HyosZ4jE"
Message-Id: <200401231218.50364.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>


--Boundary-00=_aMQEAw5HyosZ4jE
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 22 January 2004 12:44, you wrote:
> Hi Mauro,
>
> > what do you mean when you say that SCO is not for data transfer? what are
> > the limits of SCO sockets?
>
> this is not a limit of the SCO socket, it is a limit of the Bluetooth
> design itself. A SCO link can have a different air coding and it is
> possible that packets get dropped. The mailing list archive for more
> details on it. The guys from CSR explained this very well.

do you mean this thread:

http://sourceforge.net/mailarchive/message.php?msg_id=6447630

?

> > for the dlink dbt120 usb dongle:
> >
> > [root@giskard root]# hciconfig hci0 version
> > hci0:   Type: USB
> >         BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver:
> > 0x1bb Manufacturer: Cambridge Silicon Radio (10)
> > [root@giskard root]# hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
> >         HCI 15.3 (bc02x)
> >
> > for the anycom 220 usb dongle:
> >
> > [root@giskard root]# hciconfig hci0 version
> > hci0:   Type: USB
> >         BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver:
> > 0x93 Manufacturer: Transilica, Inc. (24)
> > [root@giskard root]# hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
> >         Unsupported manufacturer
> >
> > i am using hciconfig from bluez-utils 2.3.
>
> Install the latest bluez-libs and bluez-utils and do it again. Or use
> the scoinfo utility from my website.

here it is. for the dlink dbt120 usb dongle:

[root@giskard test]# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)
[root@giskard test]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 15.3
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

for the anycom 220 usb dongle:

[root@giskard test]# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
        HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
        Manufacturer: Transilica, Inc. (24)
[root@giskard test]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
        Unsupported manufacturer

> The Anycom dongle is problematic, because of the Transilica chip. I
> don't know anything special about it. Please show us the content of
> /proc/bus/usb/devices.

it is included in attachment.

> > BTW: clearly, when the usb/bluez subsystem hangs after trying to perform
> > sco transfers, hciconfig does not recognize any bluetooth interface.
>
> What kind of USB chipset do you use? I heard of some problems with VIA
> or ALI chipsets (can't remember what manufacturer it was).

i have an epox 8K5A mainboard with a VIA KT333 chipset. the usb chip is a VIA 
VT8235:

[mauro@giskard mauro]$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
[...]
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
[...]


-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it




--Boundary-00=_aMQEAw5HyosZ4jE
Content-Type: text/plain;
  charset="iso-8859-15";
  name="usbdevices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbdevices.txt"

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 27/900 us ( 3%), #Int=  1, #Iso=  2
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=a400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=16 #Cfgs=  1
P:  Vendor=0f4d ProdID=1000 Rev= 4.01
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 26mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

--Boundary-00=_aMQEAw5HyosZ4jE--
