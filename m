Return-Path: <pfavr@mip.sdu.dk>
Message-ID: <40E478EF.4040206@mip.sdu.dk>
Date: Thu, 01 Jul 2004 22:49:51 +0200
From: Peter Favrholdt <pfavr@mip.sdu.dk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] snd-bt-sco
References: <40E33BF2.7010705@mip.sdu.dk>  <40E346A8.2050209@mip.sdu.dk> <1088691001.4540.230.camel@pegasus>
In-Reply-To: <1088691001.4540.230.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Thank you very much for the reply. I have included the information you 
requested at the bottom. First a little more information that might help you 
help me :-)

When I start the user space "btsco" program the headset goes "off the hook" - 
I hear a beep, the led starts blinking three blinks at a time, and I can hear 
some "static" noise (mostly silent but occasionally some lsb "clicks"). I take 
this as a good sign since it was mentioned in the readme for the snd-bt-sco 
package:
"There seems to be some unexplained noise that's noticeable when a program has
the device open but is not sending audio data. Instead of seeing all silence,
the driver is receiving the occasional non-zero byte. I've added a temporary
filter to eliminate this, but I'd really like to know what's causing it."

As I said earlier, the buttons on the headset works - I can disconnect and 
change the volume (can be seen in alsamixer :-)

dmesg has lots of these messages. Sometimes the number following handle is not 
zero but a "random" integer.
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0

Besides adding the snd-bt-sco alsa driver to the kernel tree, I have patched 
the hci_usb.c of the 2.6.6 kernel with this patch (which was meant for 2.6.4):

<patch>
--- linux-2.6.4-orig/drivers/bluetooth/hci_usb.c 2004-03-11 02:55:44
+++ linux-2.6.4/drivers/bluetooth/hci_usb.c     2004-03-13 23:52:27
@@ -851,7 +851,12 @@

#ifdef CONFIG_BT_HCIUSB_SCO
                   case USB_ENDPOINT_XFER_ISOC:
-                        if (ep->desc.wMaxPacketSize < size || a > 2)
+                        /* Use only the 9 byte
+                           "One voice channel with 8 bit encoding"
+                           endpoint until there is support for changing
+                           the endpoint dynamically. See
+                           Bluetooth 1.1 Part H:2, section 2.1 */
+                        if (ep->desc.wMaxPacketSize != 9)
                                  break;
                          size = ep->desc.wMaxPacketSize;
</patch>

One further note: I had to increment the magic numbers in sndmagic.h because 
the ones in the patch was already used in kernel 2.6.6. I assume this isn't a 
problem as I have compiled both kernel and the btsco program with these 
numbers... but something else might need to be changed also?

After having "used" the headset and turned it off I have trouble getting it 
online again (without rebooting Linux). After putting the headset in "pairing 
mode" I can do "hcitool scan"
Scanning ...
         00:0D:44:00:76:07       Logitech HS01

But it fails with one of two error messages when I try to setup a connection:
hcitool cc 00:0D:44:00:76:07
Can't create connection: Input/output error
or:
Can't create connection: Connection timed out

But still "hcitool con" shows no connections.

Any ideas/suggestions welcome,

BR Peter


Marcel Holtmann wrote:
> and I am not sure that your USB dongle supports SCO over HCI. Show us
> the output of "hciconfig -a" and "cat /proc/bus/usb/devices".

At the moment the headset is not turned on (don't know if that makes a 
difference). Also I noted that sometimes the headset will be master and 
sometimes slave. Not sure what that means though:-)

how4:~# hciconfig -a
hci0:   Type: USB
         BD Address: 00:0B:0D:20:79:21 ACL MTU: 339:4  SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:665056950 acl:108 sco:216472402 events:222 errors:0
         TX bytes:2507 acl:87 sco:0 commands:66 errors:0
         Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'how4-0.'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
         Manufacturer: Transilica, Inc. (24)

how4:~# cat /proc/bus/usb/devices

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=143/900 us (16%), #Int=  2, #Iso=  2
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.6 uhci_hcd
S:  Product=Intel Corp. 82801AA USB
S:  SerialNumber=0000:00:1f.2
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

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

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c408 Rev=14.00
S:  Manufacturer=Logitech
S:  Product=USB Trackball
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
