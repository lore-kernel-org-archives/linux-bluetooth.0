Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4235806E.4020008@gmx.it>
From: Lorenzo Ferrara <lorenzo.ferrara@gmx.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Does the Trust BT180 (Broadcom 0x200a) work? and question on bnep0
 device.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 14 Mar 2005 13:15:42 +0100

Hello,

1) Does the Trust BT180 Class 1 Bluetooth Adapter work correctly, 
without loading any firmware?

2) I tried to configure my Adapter so I could run ifconfing bnep0 ....
The only problem is that I don't have a bnep0 device. I read that I
need at list 2 working computers with a bluetooth adapter (working)
on both, and that I will have the bnep0 adapter only after I have run

pand --connect xx:xx:xx:xx:xx:xx --service GN

               |__SERVER ADDRESS_|

Is that true?



Here is some info, if you ned anything else please ask.

--------------------------------------------------------------------
Kernel info:
--------------------------------------------------------------------

I have compiled as module everything under
Device Drivers -> Networking support -> Bluetooth subsystem support

uname -a :
Linux port0 2.6.11 #3 Sat Mar 12 12:32:53 CET 2005 i686 GNU/Linux

--------------------------------------------------------------------

lsmod:

Module                  Size  Used by
hci_uart               15228  0
hci_vhci                5248  0
bcm203x                 5124  0
bnep                   12800  2
hidp                   12544  0
rfcomm                 35740  0
isofs                  32952  1
hci_usb                10888  2
udf                    85892  0
ppp_deflate             5120  0
zlib_deflate           21400  1 ppp_deflate
zlib_inflate           17408  2 isofs,ppp_deflate
bsd_comp                5632  0
ppp_async               9472  1
ppp_generic            22932  7 ppp_deflate,bsd_comp,ppp_async
slhc                    6912  1 ppp_generic
binfmt_misc             9096  1
l2cap                  23556  10 bnep,hidp,rfcomm
bluetooth              45060  11 
hci_uart,hci_vhci,bnep,hidp,rfcomm,hci_usb,l2cap
powernow_k7             7464  0
cpufreq_userspace       3676  1
cpufreq_stats           4356  0
freq_table              3588  2 powernow_k7,cpufreq_stats
cpufreq_powersave       1664  0
cpufreq_ondemand        5404  0
thermal                11144  0
processor              18868  2 powernow_k7,thermal
fan                     3332  0
button                  5136  0
battery                 8452  0
ac                      3588  0
usbhid                 31424  0
via_rhine              20484  0
i2c_viapro              6800  0
i2c_core               18704  1 i2c_viapro
via_ircc               23572  0
irda                  119352  1 via_ircc
ehci_hcd               29192  0
uhci_hcd               29840  0
yenta_socket           19976  0
rsrc_nonstatic          9216  1 yenta_socket
pcmcia_core            42400  2 yenta_socket,rsrc_nonstatic
joydev                  8128  0
ntfs                  105968  1
ext2                   44292  1
radeon                 74624  1
drm                    60692  2 radeon
via_agp                 7680  1
agpgart                28712  2 drm,via_agp
parport_pc             25412  1
lp                      8900  0
parport                32840  2 parport_pc,lp
sr_mod                 14244  0

--------------------------------------------------------------------
This is the usb adapter:
--------------------------------------------------------------------

lsusb  -v:

Bus 002 Device 005: ID 0a5c:200a Broadcom Corp.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass          224 Wireless
   bDeviceSubClass         1 Radio Frequency
   bDeviceProtocol         1 Bluetooth
   bMaxPacketSize0        64
   idVendor           0x0a5c Broadcom Corp.
   idProduct          0x200a
   bcdDevice            0.04
   iManufacturer           1 Broadcom
   iProduct                2 BCM92035DGROM
   iSerial                 3 000B0D6049E8
   bNumConfigurations      1
[...]

--------------------------------------------------------------------

cat /proc/bus/usb/devices:

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=200a Rev= 0.04
S:  Manufacturer=Broadcom
S:  Product=BCM92035DGROM
S:  SerialNumber=000B0D6049E8
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms

--------------------------------------------------------------------

hciconfig :

hci0:   Type: USB
         BD Address: 00:0B:0D:60:49:E8 ACL MTU: 377:10  SCO MTU: 16:0
         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
         RX bytes:338 acl:0 sco:0 events:48 errors:0
         TX bytes:1440 acl:0 sco:0 commands:46 errors:0


-- 
       ____________________________________________
      / Lorenzo Ferrara                           /\
     | lorenzo.ferrara <at> gmx <dot> it         |_/
     |___________________________________________|
     | www.lorenzoferrara.net                    |
     | www.aldebaransoftware.net                 |
     | www.pot-pourri.zzn.com                    |
  ___|________________________________________   |
  \___________________________________________\__/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
