Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problem with hstest
From: cuanyu <s4048156@student.uq.edu.au>
Reply-To: s4048156@student.uq.edu.au
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1084875050.5833.84.camel@pegasus>
References: <2260c2221e01.221e012260c2@uq.edu.au>
	 <1084875050.5833.84.camel@pegasus>
Content-Type: multipart/alternative; boundary="=-3xzmLBWVb922YLq8UxA+"
Message-Id: <1085047543.4556.18.camel@tom.mshome>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 20 May 2004 20:05:44 +1000


--=-3xzmLBWVb922YLq8UxA+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gum.itee.uq.edu.au id i4KA7Aca025614

I have changed my bluetooth dongle and it is based on CSR chip:
[cuanyu@tom sbin]$ ./hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:02:72:02:02:E7 ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)
[cuanyu@tom sbin]$ ./hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:02:02:E7 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4 (bc02x)
right now I can record very well and replay it by sox like this:
[root@tom sbin]# sox -t raw -r 8000 -c 1 -w -s recorded -t ossdsp -w -s
/dev/dsp

But I still can't replay the recorded file. What I heard is just very
sharp noise. I can't tell it is the original audio because I can still
tell when the speaker stopped and when he started again. But it is just
some noise. I am using the default 0x0060 voice setting. Here is the
content of my usb devices:
T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 4
B:  Alloc=3D120/900 us (13%), #Int=3D  2, #Iso=3D  1
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB OHCI Root Hub
S:  SerialNumber=3Dcc87b000
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D1.5 M=
xCh=3D 0
D:  Ver=3D 1.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D05e3 ProdID=3D1205 Rev=3D 2.30
S:  Product=3DUSB Mouse
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 48mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   4 Ivl=3D10ms
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D12  M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D 5.25
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)

I am using the default kernel image of Fedora core 1 and all the USB
Bluetooth option are selected as module. Here is the list of loaded
module:
ppp_mppe               13848   2 (autoclean)
ppp_async               9472   1 (autoclean)
ppp_generic            24612   3 (autoclean) [ppp_mppe ppp_async]
slhc                    6756   1 (autoclean) [ppp_generic]
trident                33620   1 (autoclean)
ac97_codec             17192   0 (autoclean) [trident]
pcigame                 2952   0 (autoclean) [trident]
gameport                3380   0 (autoclean) [pcigame]
soundcore               6468   2 (autoclean) [trident]
parport_pc             19076   1 (autoclean)
lp                      9060   0 (autoclean)
parport                37056   1 (autoclean) [parport_pc lp]
autofs                 13364   0 (autoclean) (unused)
rfcomm                 38016   0 (autoclean)
l2cap                  19948   2 (autoclean) [rfcomm]
3c574_cs               12612   1
ds                      8680   1 [3c574_cs]
yenta_socket           13664   1
pcmcia_core            57216   0 [3c574_cs ds yenta_socket]
natsemi                19552   1
floppy                 58012   0 (autoclean)
sg                     36492   0 (autoclean)
sr_mod                 18168   1 (autoclean)
microcode               4700   0 (autoclean)
ide-scsi               12208   0
scsi_mod              108168   3 [sg sr_mod ide-scsi]
ide-cd                 35776   0
cdrom                  33728   0 [sr_mod ide-cd]
ohci1394               29160   0 (unused)
ieee1394              204676   0 [ohci1394]
usbdfu                 10220   0 (unused)
hci_usb                 9752   1
bluez                  40324   3 [rfcomm l2cap hci_usb]
keybdev                 2976   0 (unused)
hid                    24708   0 (unused)
usb-ohci               21512   0 (unused)
usbcore                79168   1 [usbdfu hci_usb hid usb-ohci]
thermal                 8224   0 (unused)
processor              10712   0 [thermal]
fan                     2496   0 (unused)
button                  3692   0 (unused)
battery                 7072   0 (unused)
asus_acpi               9820   0 (unused)
ac                      2752   0 (unused)
mousedev                5556   1 (autoclean)
input                   5888   0 (autoclean) [keybdev hid mousedev]
ext3                   71300   2
jbd                    52084   2 [ext3]

What else should I do for this?

Liu Jie

=E5=9C=A82004=E5=B9=B405=E6=9C=8818=E6=97=A5=E7=9A=8420:10=EF=BC=8CMarcel=
 Holtmann=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>=20
> >   I am using Anycom's USB 220 and it is not based on CSR chip. Here i=
s the device information of it on my computer:
> > [root@tom sbin]# ./hciconfig hci0 version
> > hci0:   Type: USB
> >         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subve=
r: 0x93
> >         Manufacturer: Transilica, Inc. (24)
> > [root@tom sbin]# ./hciconfig hci0 features
> > hci0:   Type: USB
> >         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
> >         Features: 0xff 0xff 0x3d 0x00
> >                 <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
> >                 <timing accuracy> <role switch> <hold mode> <sniff mo=
de>
> >                 <park mode> <RSSI> <channel quality> <SCO link>
> >                 <HV2 packets> <HV3 packets> <u-law log> <A-law log>
> >                 <CVSD> <power control> <transparent SCO>
> > [root@tom sbin]# ./hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
> >         Unsupported manufacturer
> >=20
> > Is there any other way I could figure out if the sco packets are rout=
ed through HCI or PCM interface? Can I trace it by hcidump?
>=20
> I don't have any detailed information about the Transilica chip. Run
> "hcidump -x" as root and if you see SCO packets then this dongles route=
s
> the SCO data over HCI, otherwise it goes over the PCM.
>=20
> And btw. do you activated the HCIUSB_SCO kernel option and do this
> dongle really have the needed ISOC interface? You must check the conten=
t
> of /proc/bus/usb/devices.
>=20
> Regards
>=20
> Marcel
>=20
>=20

--=-3xzmLBWVb922YLq8UxA+
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.9">
</HEAD>
<BODY>
I have changed my bluetooth dongle and it is based on CSR chip:<BR>
[cuanyu@tom sbin]$ ./hciconfig hci0 version<BR>
hci0:&nbsp;&nbsp; Type: USB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:72:02:02:E7 ACL MTU: 192:8&nbsp; SCO MTU: 64:8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<BR>
[cuanyu@tom sbin]$ ./hciconfig hci0 revision<BR>
hci0:&nbsp;&nbsp; Type: USB<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:72:02:02:E7 ACL MTU: 192:8&nbsp; SCO MTU: 64:8<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI 16.4 (bc02x)<BR>
right now I can record very well and replay it by sox like this:<BR>
[root@tom sbin]# sox -t raw -r 8000 -c 1 -w -s recorded -t ossdsp -w -s /dev/dsp<BR>
<BR>
But I still can't replay the recorded file. What I heard is just very sharp noise. I can't tell it is the original audio because I can still tell when the speaker stopped and when he started again. But it is just some noise. I am using the default 0x0060 voice setting. Here is the content of my usb devices:<BR>
T:&nbsp; Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=&nbsp; 1 Spd=12&nbsp; MxCh= 4<BR>
B:&nbsp; Alloc=120/900 us (13%), #Int=&nbsp; 2, #Iso=&nbsp; 1<BR>
D:&nbsp; Ver= 1.10 Cls=09(hub&nbsp; ) Sub=00 Prot=00 MxPS= 8 #Cfgs=&nbsp; 1<BR>
P:&nbsp; Vendor=0000 ProdID=0000 Rev= 0.00<BR>
S:&nbsp; Product=USB OHCI Root Hub<BR>
S:&nbsp; SerialNumber=cc87b000<BR>
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=&nbsp; 0mA<BR>
I:&nbsp; If#= 0 Alt= 0 #EPs= 1 Cls=09(hub&nbsp; ) Sub=00 Prot=00 Driver=hub<BR>
E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp; 2 Ivl=255ms<BR>
T:&nbsp; Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=&nbsp; 2 Spd=1.5 MxCh= 0<BR>
D:&nbsp; Ver= 1.00 Cls=00(&gt;ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=&nbsp; 1<BR>
P:&nbsp; Vendor=05e3 ProdID=1205 Rev= 2.30<BR>
S:&nbsp; Product=USB Mouse<BR>
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 48mA<BR>
I:&nbsp; If#= 0 Alt= 0 #EPs= 1 Cls=03(HID&nbsp; ) Sub=01 Prot=02 Driver=hid<BR>
E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp; 4 Ivl=10ms<BR>
T:&nbsp; Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=&nbsp; 3 Spd=12&nbsp; MxCh= 0<BR>
D:&nbsp; Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=&nbsp; 1<BR>
P:&nbsp; Vendor=0a12 ProdID=0001 Rev= 5.25<BR>
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=&nbsp; 0mA<BR>
I:&nbsp; If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp; 16 Ivl=1ms<BR>
E:&nbsp; Ad=02(O) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<BR>
E:&nbsp; Ad=82(I) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<BR>
I:&nbsp; If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<BR>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<BR>
I:&nbsp; If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<BR>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<BR>
I:&nbsp; If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<BR>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<BR>
I:&nbsp; If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 25 Ivl=1ms<BR>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 25 Ivl=1ms<BR>
I:&nbsp; If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 33 Ivl=1ms<BR>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 33 Ivl=1ms<BR>
I:&nbsp; If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<BR>
E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 49 Ivl=1ms<BR>
E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 49 Ivl=1ms<BR>
I:&nbsp; If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)<BR>
<BR>
I am using the default kernel image of Fedora core 1 and all the USB Bluetooth option are selected as module. Here is the list of loaded module:<BR>
ppp_mppe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13848&nbsp;&nbsp; 2 (autoclean)<BR>
ppp_async&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9472&nbsp;&nbsp; 1 (autoclean)<BR>
ppp_generic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24612&nbsp;&nbsp; 3 (autoclean) [ppp_mppe ppp_async]<BR>
slhc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6756&nbsp;&nbsp; 1 (autoclean) [ppp_generic]<BR>
trident&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33620&nbsp;&nbsp; 1 (autoclean)<BR>
ac97_codec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17192&nbsp;&nbsp; 0 (autoclean) [trident]<BR>
pcigame&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2952&nbsp;&nbsp; 0 (autoclean) [trident]<BR>
gameport&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3380&nbsp;&nbsp; 0 (autoclean) [pcigame]<BR>
soundcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6468&nbsp;&nbsp; 2 (autoclean) [trident]<BR>
parport_pc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19076&nbsp;&nbsp; 1 (autoclean)<BR>
lp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9060&nbsp;&nbsp; 0 (autoclean)<BR>
parport&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37056&nbsp;&nbsp; 1 (autoclean) [parport_pc lp]<BR>
autofs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13364&nbsp;&nbsp; 0 (autoclean) (unused)<BR>
rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38016&nbsp;&nbsp; 0 (autoclean)<BR>
l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19948&nbsp;&nbsp; 2 (autoclean) [rfcomm]<BR>
3c574_cs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12612&nbsp;&nbsp; 1<BR>
ds&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8680&nbsp;&nbsp; 1 [3c574_cs]<BR>
yenta_socket&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13664&nbsp;&nbsp; 1<BR>
pcmcia_core&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 57216&nbsp;&nbsp; 0 [3c574_cs ds yenta_socket]<BR>
natsemi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19552&nbsp;&nbsp; 1<BR>
floppy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 58012&nbsp;&nbsp; 0 (autoclean)<BR>
sg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36492&nbsp;&nbsp; 0 (autoclean)<BR>
sr_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18168&nbsp;&nbsp; 1 (autoclean)<BR>
microcode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4700&nbsp;&nbsp; 0 (autoclean)<BR>
ide-scsi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12208&nbsp;&nbsp; 0<BR>
scsi_mod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 108168&nbsp;&nbsp; 3 [sg sr_mod ide-scsi]<BR>
ide-cd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35776&nbsp;&nbsp; 0<BR>
cdrom&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33728&nbsp;&nbsp; 0 [sr_mod ide-cd]<BR>
ohci1394&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29160&nbsp;&nbsp; 0 (unused)<BR>
ieee1394&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 204676&nbsp;&nbsp; 0 [ohci1394]<BR>
usbdfu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10220&nbsp;&nbsp; 0 (unused)<BR>
hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9752&nbsp;&nbsp; 1<BR>
bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 40324&nbsp;&nbsp; 3 [rfcomm l2cap hci_usb]<BR>
keybdev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2976&nbsp;&nbsp; 0 (unused)<BR>
hid&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 24708&nbsp;&nbsp; 0 (unused)<BR>
usb-ohci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 21512&nbsp;&nbsp; 0 (unused)<BR>
usbcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 79168&nbsp;&nbsp; 1 [usbdfu hci_usb hid usb-ohci]<BR>
thermal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8224&nbsp;&nbsp; 0 (unused)<BR>
processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10712&nbsp;&nbsp; 0 [thermal]<BR>
fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2496&nbsp;&nbsp; 0 (unused)<BR>
button&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3692&nbsp;&nbsp; 0 (unused)<BR>
battery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7072&nbsp;&nbsp; 0 (unused)<BR>
asus_acpi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9820&nbsp;&nbsp; 0 (unused)<BR>
ac&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2752&nbsp;&nbsp; 0 (unused)<BR>
mousedev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5556&nbsp;&nbsp; 1 (autoclean)<BR>
input&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5888&nbsp;&nbsp; 0 (autoclean) [keybdev hid mousedev]<BR>
ext3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 71300&nbsp;&nbsp; 2<BR>
jbd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 52084&nbsp;&nbsp; 2 [ext3]<BR>
<BR>
What else should I do for this?<BR>
<BR>
Liu Jie<BR>
<BR>
&#22312;2004&#24180;05&#26376;18&#26085;&#30340;20:10&#65292;Marcel Holtmann&#20889;&#36947;&#65306;
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Hi,

&gt;   I am using Anycom's USB 220 and it is not based on CSR chip. Here is the device information of it on my computer:
&gt; [root@tom sbin]# ./hciconfig hci0 version
&gt; hci0:   Type: USB
&gt;         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
&gt;         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
&gt;         Manufacturer: Transilica, Inc. (24)
&gt; [root@tom sbin]# ./hciconfig hci0 features
&gt; hci0:   Type: USB
&gt;         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
&gt;         Features: 0xff 0xff 0x3d 0x00
&gt;                 &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt;
&gt;                 &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;
&gt;                 &lt;park mode&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt;
&gt;                 &lt;HV2 packets&gt; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt;
&gt;                 &lt;CVSD&gt; &lt;power control&gt; &lt;transparent SCO&gt;
&gt; [root@tom sbin]# ./hciconfig hci0 revision
&gt; hci0:   Type: USB
&gt;         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
&gt;         Unsupported manufacturer
&gt; 
&gt; Is there any other way I could figure out if the sco packets are routed through HCI or PCM interface? Can I trace it by hcidump?

I don't have any detailed information about the Transilica chip. Run
&quot;hcidump -x&quot; as root and if you see SCO packets then this dongles routes
the SCO data over HCI, otherwise it goes over the PCM.

And btw. do you activated the HCIUSB_SCO kernel option and do this
dongle really have the needed ISOC interface? You must check the content
of /proc/bus/usb/devices.

Regards

Marcel

</I></FONT></PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-3xzmLBWVb922YLq8UxA+--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
