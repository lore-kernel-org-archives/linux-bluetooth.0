Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matias Pablo Brutti <matiasbrutti@ciudad.com.ar>
To: nalp@gmx.net, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with Logitech MX900 and Apple Keyboard
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404300002.49720.matiasbrutti@ciudad.com.ar>
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
Date: Fri, 30 Apr 2004 00:02:49 -0300

Hello Nicholas:

Here goes a list of the thing I have been trying to do lately 

1) I install my MX900 on the PC and it staterd working perfectly .. with no 
need of seetup or anything .

2) I installed all the Bluez-liz and Bluez-utlis ....

3) I try to do some of the hepful how-to in the bluez website but won't work 

4) I realice that I have no modules configure to make it work with the bthid 
that says that I need uimput .. becuase in the syslogs says that I cannot 
find uimput module or device .. 

5) you email for the first time and everything for part 2 whichi will be the 
actual discovery and configuration of the devices with their addresses .. etc 
using HID .. 

6) I have no idea how to make apple wireless keyboard to work .. ;)

here goes a buncho of outputs . hopefully it will help 

Thanks a lot again !!!!!!!! really apreaciate your help guys !!! 


[root@ShuttleX bluetooth]# lsmod
Module                  Size  Used by
ppdev                  10400  0
isofs                  35804  0
zlib_inflate           23648  1 isofs
udf                    98756  0
appletalk              40272  2
ax25                   66020  2
ipx                    33220  2
sg                     40028  0
sr_mod                 18116  0
parport_pc             34304  1
lp                     13256  0
parport                41032  3 ppdev,parport_pc,lp
md5                     4864  1
ipv6                  251392  12
rfcomm                 39288  0
l2cap                  25888  3 rfcomm
bluetooth              50308  4 rfcomm,l2cap
snd-seq-oss            33568  0
snd-seq-midi-event      8704  1 snd-seq-oss
snd-seq                55696  4 snd-seq-oss,snd-seq-midi-event
snd-pcm-oss            53316  0
snd-mixer-oss          19008  1 snd-pcm-oss
snd-intel8x0           34440  1
snd-ac97-codec         59588  1 snd-intel8x0
snd-pcm                97440  2 snd-pcm-oss,snd-intel8x0
snd-timer              26660  2 snd-seq,snd-pcm
gameport                5664  1 snd-intel8x0
snd-page-alloc         12996  2 snd-intel8x0,snd-pcm
snd-mpu401-uart         8320  1 snd-intel8x0
snd-rawmidi            25248  1 snd-mpu401-uart
snd-seq-device          9032  3 snd-seq-oss,snd-seq,snd-rawmidi
snd                    55492  14 
snd-seq-oss,snd-seq-midi-event,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-intel8x0,snd-ac97-codec,snd-pcm,snd-timer,snd-mpu401-uart,snd-rawmidi,snd-seq-device
soundcore              10560  1 snd
af_packet              22632  2
raw                     8640  1
ide-floppy             19776  0
ide-tape               36752  0
ide-cd                 41764  0
cdrom                  38272  2 sr_mod,ide-cd
floppy                 61620  0
8139too                25760  0
mii                     5984  1 8139too
evdev                  10496  0
tsdev                   8160  0
usbmouse                6208  0
hid                    55360  0
ohci1394               35684  0
ieee1394              290480  1 ohci1394
prism2_usb             78116  0
p80211                 32912  1 prism2_usb
nls_iso8859-1           4896  1
nls_cp850               5728  1
vfat                   15680  1
fat                    47360  1 vfat
supermount             39856  1
intel-agp              18364  1
agpgart                32460  1 intel-agp
usb-storage            74596  0
quickcam              110880  0
videodev               10592  1 quickcam
ehci-hcd               25572  0
uhci-hcd               31856  0
usbcore               103228  9 
usbmouse,hid,prism2_usb,usb-storage,quickcam,ehci-hcd,uhci-hcd
rtc                    13640  0
ext3                  114216  4
jbd                    61976  1 ext3
sd_mod                 17696  0
ata_piix                8836  0
libata                 40256  1 ata_piix,[permanent]
scsi_mod              117104  5 sg,sr_mod,usb-storage,sd_mod,libata





[root@ShuttleX bluetooth]# hciconfig

[root@ShuttleX bluetooth]# hciconfig

[root@ShuttleX bluetooth]# hciattach
hciattach - HCI UART driver initialization utility
Usage:
        hciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | 
id> [speed] [flow]
        hciattach -l
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



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
