Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matias Pablo Brutti <matiasbrutti@ciudad.com.ar>
Reply-To: matiasbrutti@ciudad.com.ar
To: "Nicholas A. Preyss" <nalp@gmx.net>, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with Logitech MX 900 and Apple keyboard
References: <200404282247.31825.matiasbrutti@ciudad.com.ar> <200404291209.16830.matiasbrutti@ciudad.com.ar> <20040429205222.GA8324@gmx.net>
In-Reply-To: <20040429205222.GA8324@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200404300024.51331.matiasbrutti@ciudad.com.ar>
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
Date: Fri, 30 Apr 2004 00:24:35 -0300

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 29 April 2004 17:52, Nicholas A. Preyss wrote:
> On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> > On Thursday 29 April 2004 06:36, Nicholas A. Prey=DF wrote:
> > > On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> > > > I'm running Mandrake 10.0 official with a 2.6.3-7 ... I just bougth=
 a
> > > > MX900 and the apple bluetooth keyboard .. the mouse ... was working
> > > > when I plugged .. like if was a plug and play devide . I didn't have
> > > > to install anything .. although .. i did not have any bluetooth
> > > > installatin and if I serch for bluetooth devices . it says that I
> > > > have no devides .. I'm pretty new on the subject .. and I think I
> > > > have to load modules to the kernel .. which ones should I load for =
my
> > > > Logitech hub .. so It will be able to recognize all my bluetooth ..
> > > > When I try to start bthid it says that I have no uimput .. or some
> > > > modules .. what should I do .. or where should I read .. to get my
> > > > thing working ... I really like bluetooth .. and I would like to wo=
rk
> > > > on linux too
> > > > if you need more info so you can help please email me ...
> > >
> > > It sounds like your bluetooth chip is equipped with a hid proxy.
> > > Look here:
> > > http://www.holtmann.org/linux/bluetooth/hid.html
> > > Look in the CVS "bluez/utils2/hid/" there is a hid service utility.
> >
> > Thanks for.. the info is very helpful Now I understand a little more on
> > the HID implementation . that should be step 2  I think .. .. the
> > problems .. is that ... I haven been able to figure out .. step one .
> > load some module . so when I do hcitool scan .... or  use some tool for
> > scanning .  It will actually appear something . rigth now .. nothing
> > appears not even the mouse that is working ...
> > Thanks a lot . Nicholas . the info was extremelly helpful .. now I get a
> > lot more than before .. :)
>
> I have no clue which of your problems are solved, but at least you seem
> more happy :). Maybe you can give me a some more consistent and ordered
> summary of what problems you still face. And we will be glad to help you.
>
> nicholas
>
> P.S.: Output of lsmod and hciconfig would be helpful.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


Hello Nicholas:

Here goes a list of the thing I have been trying to do lately=20

1) I install my MX900 on the PC and it staterd working perfectly .. with no=
=20
need of seetup or anything .

2) I installed all the Bluez-liz and Bluez-utlis ....

3) I try to do some of the hepful how-to in the bluez website but won't wor=
k=20

4) I realice that I have no modules configure to make it work with the bthi=
d=20
that says that I need uimput .. becuase in the syslogs says that I cannot=20
find uimput module or device ..=20

5) you email for the first time and everything for part 2 whichi will be th=
e=20
actual discovery and configuration of the devices with their addresses .. e=
tc=20
using HID ..=20

6) I have no idea how to make apple wireless keyboard to work .. ;)

here goes a buncho of outputs . hopefully it will help=20

Thanks a lot again !!!!!!!! really apreaciate your help guys !!!=20


[root@ShuttleX bluetooth]# lsmod
Module =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Size =A0Used by
ppdev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A010400 =A00
isofs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A035804 =A00
zlib_inflate =A0 =A0 =A0 =A0 =A0 23648 =A01 isofs
udf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A098756 =A00
appletalk =A0 =A0 =A0 =A0 =A0 =A0 =A040272 =A02
ax25 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 66020 =A02
ipx =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A033220 =A02
sg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 40028 =A00
sr_mod =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18116 =A00
parport_pc =A0 =A0 =A0 =A0 =A0 =A0 34304 =A01
lp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 13256 =A00
parport =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A041032 =A03 ppdev,parport_pc,lp
md5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 4864 =A01
ipv6 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0251392 =A012
rfcomm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 39288 =A00
l2cap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025888 =A03 rfcomm
bluetooth =A0 =A0 =A0 =A0 =A0 =A0 =A050308 =A04 rfcomm,l2cap
snd-seq-oss =A0 =A0 =A0 =A0 =A0 =A033568 =A00
snd-seq-midi-event =A0 =A0 =A08704 =A01 snd-seq-oss
snd-seq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A055696 =A04 snd-seq-oss,snd-seq-midi-=
event
snd-pcm-oss =A0 =A0 =A0 =A0 =A0 =A053316 =A00
snd-mixer-oss =A0 =A0 =A0 =A0 =A019008 =A01 snd-pcm-oss
snd-intel8x0 =A0 =A0 =A0 =A0 =A0 34440 =A01
snd-ac97-codec =A0 =A0 =A0 =A0 59588 =A01 snd-intel8x0
snd-pcm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A097440 =A02 snd-pcm-oss,snd-intel8x0
snd-timer =A0 =A0 =A0 =A0 =A0 =A0 =A026660 =A02 snd-seq,snd-pcm
gameport =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05664 =A01 snd-intel8x0
snd-page-alloc =A0 =A0 =A0 =A0 12996 =A02 snd-intel8x0,snd-pcm
snd-mpu401-uart =A0 =A0 =A0 =A0 8320 =A01 snd-intel8x0
snd-rawmidi =A0 =A0 =A0 =A0 =A0 =A025248 =A01 snd-mpu401-uart
snd-seq-device =A0 =A0 =A0 =A0 =A09032 =A03 snd-seq-oss,snd-seq,snd-rawmidi
snd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A055492 =A014=20
snd-seq-oss,snd-seq-midi-event,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-intel8=
x0,snd-ac97-codec,snd-pcm,snd-timer,snd-mpu401-uart,snd-rawmidi,snd-seq-dev=
ice
soundcore =A0 =A0 =A0 =A0 =A0 =A0 =A010560 =A01 snd
af_packet =A0 =A0 =A0 =A0 =A0 =A0 =A022632 =A02
raw =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8640 =A01
ide-floppy =A0 =A0 =A0 =A0 =A0 =A0 19776 =A00
ide-tape =A0 =A0 =A0 =A0 =A0 =A0 =A0 36752 =A00
ide-cd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 41764 =A00
cdrom =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A038272 =A02 sr_mod,ide-cd
floppy =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 61620 =A00
8139too =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025760 =A00
mii =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5984 =A01 8139too
evdev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A010496 =A00
tsdev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8160 =A00
usbmouse =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06208 =A00
hid =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A055360 =A00
ohci1394 =A0 =A0 =A0 =A0 =A0 =A0 =A0 35684 =A00
ieee1394 =A0 =A0 =A0 =A0 =A0 =A0 =A0290480 =A01 ohci1394
prism2_usb =A0 =A0 =A0 =A0 =A0 =A0 78116 =A00
p80211 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 32912 =A01 prism2_usb
nls_iso8859-1 =A0 =A0 =A0 =A0 =A0 4896 =A01
nls_cp850 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5728 =A01
vfat =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 15680 =A01
fat =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A047360 =A01 vfat
supermount =A0 =A0 =A0 =A0 =A0 =A0 39856 =A01
intel-agp =A0 =A0 =A0 =A0 =A0 =A0 =A018364 =A01
agpgart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A032460 =A01 intel-agp
usb-storage =A0 =A0 =A0 =A0 =A0 =A074596 =A00
quickcam =A0 =A0 =A0 =A0 =A0 =A0 =A0110880 =A00
videodev =A0 =A0 =A0 =A0 =A0 =A0 =A0 10592 =A01 quickcam
ehci-hcd =A0 =A0 =A0 =A0 =A0 =A0 =A0 25572 =A00
uhci-hcd =A0 =A0 =A0 =A0 =A0 =A0 =A0 31856 =A00
usbcore =A0 =A0 =A0 =A0 =A0 =A0 =A0 103228 =A09=20
usbmouse,hid,prism2_usb,usb-storage,quickcam,ehci-hcd,uhci-hcd
rtc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A013640 =A00
ext3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0114216 =A04
jbd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A061976 =A01 ext3
sd_mod =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 17696 =A00
ata_piix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08836 =A00
libata =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 40256 =A01 ata_piix,[permanent]
scsi_mod =A0 =A0 =A0 =A0 =A0 =A0 =A0117104 =A05 sg,sr_mod,usb-storage,sd_mo=
d,libata





[root@ShuttleX bluetooth]# hciconfig

[root@ShuttleX bluetooth]# hciconfig

[root@ShuttleX bluetooth]# hciattach
hciattach - HCI UART driver initialization utility
Usage:
=A0 =A0 =A0 =A0 hciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <t=
ty> <type |=20
id> [speed] [flow]
=A0 =A0 =A0 =A0 hciattach -l
[root@ShuttleX bluetooth]# hcidump
HCIDump - HCI packet analyzer ver 1.8
Can't attach to device hci0. No such device(19)
[root@ShuttleX bluetooth]# hcitool inq
Inquiring ...
Inquiry failed.: No such device
[root@ShuttleX bluetooth]# lsusb
Bus 005 Device 002: ID 07cc:0320 Carry Computer Eng., Co., Ltd
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 002: ID 124a:168b
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 003: ID 046d:c705 Logitech, Inc.
Bus 002 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 003: ID 046d:0840 Logitech, Inc. QuickCam Express
Bus 001 Device 001: ID 0000:0000
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQJHG+2XJj+mzTB70AQKfMgf/e5Slg3WnEN+oH6JoIotKZlIXu7XS3evb
LEGdlUYvxcnKJQq7CkL/KcdF9JI4w546M2dKgpulP71uojgOmf3APx57IPjVL7sk
UWlwlIxs+8WPfwHJXdk/BbNdTiBit90wsrY/FVU0B5JZEhm/GeJaTA+NAkZlxU0L
4h6IHpDuBuil72KkTnQofR4BdwmMPWTxVb1kCbB3acRVRIApVWQe/cGJ+f8B3M4O
Wy4dykY6ySfOg6iMBwtEQPBKN61TCJsGG7QoDovxqVzGT9ms2LquUiMUs6JpqI2Q
79ZS/drsHdKyVhM4DeflMFVByYlNhBrBjWg4jZG3Ew2cgxwq/Q0xEg=3D=3D
=3Dxs4A
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
