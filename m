Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Gael Beaudoin <mailinglists@gaboo.org>
To: bluez-users@lists.sourceforge.net
Date: Mon, 31 Jul 2006 02:43:22 +0200
MIME-Version: 1.0
Message-Id: <200607310243.22194.mailinglists@gaboo.org>
Subject: [Bluez-users] logitech dinovo media desktop laser doesn't work
Reply-To: gaboo@gaboo.org, BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I tried for several hours now to make my linux system recognize the logitech bluetooth receiver. I failed :)

First of all, here's what I've done :

- patched my gentoo 2.6.17 kernel with the patch given on the bluez site.
- recompiled my kernel with everything bluetooth related enabled

Rebooted and tried hid2hci : 
---------
muadib gaboo # hid2hci
Switching device 046d:0b02 to HCI mode was successful
---------
But hciconfig returns nothing.

Then I tried to apply this patch :

--- drivers/bluetooth/hci_usb.orig      2005-10-21 23:37:25.000000000 -0400
+++ drivers/bluetooth/hci_usb.c 2005-10-21 22:11:02.000000000 -0400
 <at>  <at>  -119,6 +119,9  <at>  <at> 
        /* Kensington Bluetooth USB adapter */
        { USB_DEVICE(0x047d, 0x105d), .driver_info = HCI_RESET },

+       /* Logitech diNovo Media Desktop Laser Transceiver for Bluetooth 2.0 */
+        { USB_DEVICE(0x046d, 0xc709), .driver_info = HCI_RESET },
+
        /* ISSC Bluetooth Adapter v3.1 */
        { USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },

Rebooted, hid2hci, hciconfig : nothing.

My system is an up to date gentoo :
uname -a : Linux muadib 2.6.17-gentoo-r4-mh5 #1 SMP PREEMPT Mon Jul 31 01:27:43 CEST 2006 i686 AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ GNU/Linux
bluez version :
-------------
muadib gaboo # equery list bluez
[ Searching for package 'bluez' in all categories among: ]
 * installed packages
[I--] [  ] net-wireless/bluez-firmware-1.1 (0)
[I--] [  ] net-wireless/bluez-libs-2.25 (0)
[I--] [  ] net-wireless/bluez-utils-2.25-r1 (0)
-------------

I checked that bluez-utils/tools/hid2hci.c contains :   "{ HCI, 0x046d, 0x0b02, switch_logitech },       /* Logitech diNovo Media Desktop Laser */"

And here is my /proc/bus/usb/devices  (I don't think hid2hci changed something because hid2hci -1 telle me : "No devices in HID mode found")
------------------------------------------
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh=10
B:  Alloc=  6/900 us ( 1%), #Int=  3, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17-gentoo-r4-mh5 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:02.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=0b02 Rev=40.02
S:  Manufacturer=Logitech
S:  Product=Logitech BT Mini-Receiver
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c70b Rev=40.02
S:  Manufacturer=Logitech
S:  Product=Logitech BT Mini-Receiver
S:  SerialNumber=00076141F47E
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=02 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c70c Rev=40.02
S:  Manufacturer=Logitech
S:  Product=Logitech BT Mini-Receiver
S:  SerialNumber=00076141F47E
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=5ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh=10
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.17-gentoo-r4-mh5 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:02.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
------------------------------------------

Do you know what are the  ProdID=c70c and  ProdID=c70b product ?
Maybe I could try to change the hid2hci patch with these product ids ?

And meybe this can be useful:
------------------------------
muadib tools # dmesg |grep -i bluetooth
Bluetooth: Core ver 2.10
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1-mh1
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
------------------------------

So, do you have any idea ? It seems it should work, but I cannot manage to find what's wrong.

Thanks !
Gael Beaudoin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
