Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Jeffrey Bridge <jeffrey+bluez@firehead.org>
To: bluez-users@lists.sf.net
Date: Tue, 06 Mar 2007 10:32:19 -0600
Message-Id: <1173198739.25660.0.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] bcm2045 issue
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

I'm not sure if this is supposed to work yet or not, but I'm having
trouble getting a Dell Wireless 355 module (AKA BCM2045) working in an
e1705 under Gentoo. Here is the error message generated upon 'modprobe
hci_usb':

Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb ffff81007a5c4ea8
err -28
hci_cmd_task: hci0 command tx timeout


If I then try to run 'hciconfig hci0 up', it says:

Can't init device hci0: Input/output error (5)

And the kernel also outputs another:

hci_usb_intr_rx_submit: hci0 intr rx submit failed urb ffff8100763848e8
err -28



Here's all the system info I know of which may be relevant.

$ uname -a
Linux myhostname 2.6.20.1-64 #1 SMP PREEMPT Tue Feb 27 10:07:05 GMT+6 2007
x86_64 Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz GenuineIntel
GNU/Linux

bluez packages installed via Gentoo:

net-wireless/bluez-bluefw-1.0
net-wireless/bluez-firmware-1.2
net-wireless/bluez-libs-2.25
net-wireless/bluez-utils-2.25-r1

>>From /proc/bus/usb/devices:

T:  Bus=01 Lev=03 Prnt=15 Port=00 Cnt=01 Dev#= 16 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8126 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=BCM2045
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

I saw some other people asking about this, but I was unable to find any
definite answers. Does anyone how to get this to work? Please let me know
if I need to supply more info about my configuration.

Jeff


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
