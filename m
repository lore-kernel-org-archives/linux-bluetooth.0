Return-Path: <welpan@gmx.de>
From: Alex <welpan@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Error message
Date: Fri, 21 May 2004 19:40:07 +0200
References: <200405211611.38038.welpan@gmx.de> <200405211909.59769.welpan@gmx.de> <1085160363.22191.24.camel@pegasus>
In-Reply-To: <1085160363.22191.24.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200405211940.07538.welpan@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>

Am Freitag, 21. Mai 2004 19:26 schrieben Sie:
> Hi Alex,
>
> > > this looks very weird. Give us more information about your hardware and
> > > what kind of dongle you are using.
> >
> > Dongle : with CSR Chip, Seller WIDCOMM
> >
> > hciconfig -a
> > hci0:   Type: USB
> >         BD Address: 08:00:17:13:82:61 ACL MTU: 339:4  SCO MTU: 60:9
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:128797 acl:0 sco:37800 events:14 errors:0
> >         TX bytes:300 acl:0 sco:0 commands:13 errors:0
> >         Features: 0xff 0x3a 0x05 0x00 0x00 0x00 0x00 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >         Link policy: HOLD SNIFF PARK
> >         Link mode: SLAVE ACCEPT
> >         Name: 'welpix-0'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x178 LMP Ver: 1.1 (0x1) LMP Subver:
> > 0x178 Manufacturer: RTX Telecom A/S (21)
>
> there is no CSR chip in this dongle.

KMelektronik cheat, thats not fine.

>
> > System:  AMD Duron 1600
> > 	      ASROCK Motherboard with SIS USB-Controller
>
> What is the content of /proc/bus/usb/devices with the dongle attached?

E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6 ohci_hcd
S:  Product=Silicon Integrated Systems [SiS] USB 1.0 Controller
S:  SerialNumber=0000:00:03.0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=82(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

>
> > Kernel with Bluez-modules and USB drivers
>
> Use patch-2.6.6-mh1 to prevent some USB related bugs.

I use the patch ( I did it like the description), so that was my last hope to 
find the error by myself

In KDE Shell I cannot plug in, plug out, plug in the dongle, is only found by 
the first attemp.

>
> Regards
>
> Marcel

Best Regards 
Alex
