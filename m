Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ullrich Martini <mailbox@ullrich.martini.name>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403232153.26004.mailbox@ullrich.martini.name>
Subject: [Bluez-users] l2ping Can't connect.: Permission denied
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
Date: Tue, 23 Mar 2004 21:53:25 +0100

Dear all,

bluez does not work for me. I tried to produce a simple problem with l2ping 
only. Other things like hcitool cc also don't work. 
The connection is ok under Windows XP.

local device is an AVM BlueFritz!, remote device is an AVM ISDN Access Point

# hcitool scan
Scanning ...
        00:04:0E:84:15:F5       Bluetooth ISDN Access Point
# l2ping 00:04:0E:84:15:F5
Can't connect.: Permission denied

# hcitool cc 0 00:04:0E:84:15:F5
Can't create connection: Connection timed out


hcidump of hcitool scan:
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Inquiry Result(0x02) plen 15
> HCI Event: Inquiry Result(0x02) plen 15
> HCI Event: Inquiry Result(0x02) plen 15
> HCI Event: Inquiry Result(0x02) plen 15
> HCI Event: Inquiry Result(0x02) plen 15
> HCI Event: Inquiry Complete(0x01) plen 1
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Remote Name Req Complete(0x07) plen 255


hcidump of l2ping 00:04:0E:84:15:F5
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11

hcidump of hcitool cc 00:04:0E:84:15:F5
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11

System info:
# uname -a
Linux luna 2.6.4-mh2 #1 Mon Mar 22 00:24:55 CET 2004 i686 GNU/Linux
# lsmod
Module                  Size  Used by
cmtp                   16000  0
hci_usb                 8832  0
parport_pc             34496  1
lp                      9672  0
parport                34376  2 parport_pc,lp
bfusb                  10496  3
firmware_class          7552  1 bfusb
8250_pci               15616  0
8250                   17056  1 8250_pci
serial_core            18432  1 8250
intel_agp              15772  1
evdev                   7424  0
rfcomm                 32284  1
l2cap                  19204  4 cmtp,rfcomm
ipv6                  212544  8
radeon                113068  0
ntfs                   94956  0
snd_pcm_oss            47652  0
snd_mixer_oss          17152  1 snd_pcm_oss
snd_intel8x0           28420  1
snd_ac97_codec         58244  1 snd_intel8x0
snd_pcm                81188  2 snd_pcm_oss,snd_intel8x0
snd_timer              20228  1 snd_pcm
snd_page_alloc          9348  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         5888  1 snd_intel8x0
snd_rawmidi            18976  1 snd_mpu401_uart
snd                    43108  10 
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi
soundcore               7008  1 snd
capi                   14912  0
kernelcapi             42528  2 cmtp,capi
ds                     11140  0
pcmcia_core            49728  1 ds
rtc                     9656  0

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:04:0E:83:53:DC ACL MTU: 4096:2  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:3676 acl:0 sco:0 events:122 errors:0
        TX bytes:1130 acl:0 sco:0 commands:54 errors:0
        Features: 0x2f 0xbe 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'luna-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1135 LMP Ver: 1.1 (0x1) LMP Subver: 0x1
        Manufacturer: AVM Berlin (31)

the bluez-stack is 2.4 from debian unstable, but 2.5 manually compiled doesn't 
work either. 

thanks in advance, Ullrich



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
