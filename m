Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45C0D032.1000309@windmillcomputers.ca>
Date: Wed, 31 Jan 2007 11:21:54 -0600
From: Mike Kornelson <mike@windmillcomputers.ca>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Having problems with the BCM2045 USB device
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

I have a Rocketfish RF-BTAPDT Bluetooth 2.0 EDR USB dongle. It's using 
the Broadcom BCM2045B3 chipset.

I can get it working about every 30 or so tries with a lot of fiddling. 
Here are the details:

Hardware: Dell Inspiron 9400
OS/Kernel: Ubuntu Edgy 2.6.17-10-generic

I have the bluez-utils, libbluetooth2, and kdebluetooth packages installed.

When I initially plug in the dongle my syslog spits out:

    Jan 31 10:57:44 localhost kernel: [17182235.196000] usb 3-2: new
    full speed USB device using uhci_hcd and address 54
    Jan 31 10:57:44 localhost kernel: [17182235.372000] usb 3-2:
    configuration #1 chosen from 1 choice
    Jan 31 10:57:44 localhost kernel: [17182235.372000] hub 3-2:1.0: USB
    hub found
    Jan 31 10:57:44 localhost kernel: [17182235.376000] hub 3-2:1.0: 3
    ports detected
    Jan 31 10:57:44 localhost kernel: [17182235.688000] usb 3-2.2: new
    full speed USB device using uhci_hcd and address 55
    Jan 31 10:57:44 localhost kernel: [17182235.820000] usb 3-2.2:
    configuration #1 chosen from 1 choice
    Jan 31 10:57:44 localhost kernel: [17182235.828000] input: Broadcom
    Corp BCM2045B3 ROM as /class/input/input43
    Jan 31 10:57:44 localhost kernel: [17182235.828000] input: USB HID
    v1.11 Keyboard [Broadcom Corp BCM2045B3 ROM] on usb-0000:00:1d.2-2.2
    Jan 31 10:57:45 localhost kernel: [17182236.032000] usb 3-2.3: new
    full speed USB device using uhci_hcd and address 56
    Jan 31 10:57:45 localhost kernel: [17182236.172000] usb 3-2.3:
    configuration #1 chosen from 1 choice
    Jan 31 10:57:45 localhost kernel: [17182236.180000] input: Broadcom
    Corp BCM2045B3 ROM as /class/input/input44
    Jan 31 10:57:45 localhost kernel: [17182236.180000] input: USB HID
    v1.11 Mouse [Broadcom Corp BCM2045B3 ROM] on usb-0000:00:1d.2-2.3

It seems like it is detecting as a keyboard and mouse. I've found this 
thread which has helped me getting it work only occasionally. 
(http://sourceforge.net/mailarchive/message.php?msg_id=37697403)

In lsmod i have these modules running:

    bcm203x                 7300  0
    bluetooth              53476  4 hci_usb,bnep,rfcomm,l2cap
    hci_usb                18068  0
    ...list truncated...

I've tried loading hci_usb with the reset=1 parameter. I've also tried 
the hid2hci utility but it always says: "No devices in HCI mode found" 
(which is odd because shouldn't that say No devices in HID mode found 
because i'm running it as "sudo hid2hci --tohci"?)

lsusb outputs:

    Bus 005 Device 002: ID 413c:a005 Dell Computer Corp.
    Bus 005 Device 001: ID 0000:0000
    Bus 004 Device 002: ID 046d:c501 Logitech, Inc. Cordless Mouse Receiver
    Bus 004 Device 001: ID 0000:0000
    Bus 002 Device 002: ID 0425:0106 Motorola Semiconductors HK, Ltd
    Bus 002 Device 001: ID 0000:0000
    Bus 003 Device 059: ID 0a5c:4503 Broadcom Corp.
    Bus 003 Device 058: ID 0a5c:4502 Broadcom Corp.
    Bus 003 Device 057: ID 0a5c:4500 Broadcom Corp.
    Bus 003 Device 002: ID 046d:0a01 Logitech, Inc.
    Bus 003 Device 001: ID 0000:0000
    Bus 001 Device 004: ID 413c:2003 Dell Computer Corp.
    Bus 001 Device 001: ID 0000:0000

If i remember correctly (from when the dongle did work) there was a 
fourth Broadcom device.

The Broadcom devices in /proc/bus/usb/devices are: (i cut out the other 
devices, let me know if you need more detail)

    T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#= 57 Spd=12  MxCh= 3
    D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
    P:  Vendor=0a5c ProdID=4500 Rev= 1.00
    S:  Manufacturer=Broadcom
    S:  Product=BCM2045B2
    C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
    E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

    T:  Bus=03 Lev=02 Prnt=57 Port=01 Cnt=01 Dev#= 58 Spd=12  MxCh= 0
    D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
    P:  Vendor=0a5c ProdID=4502 Rev= 1.00
    S:  Manufacturer=Broadcom Corp
    S:  Product=BCM2045B3 ROM
    C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
    E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

    T:  Bus=03 Lev=02 Prnt=57 Port=02 Cnt=02 Dev#= 59 Spd=12  MxCh= 0
    D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
    P:  Vendor=0a5c ProdID=4503 Rev= 1.00
    S:  Manufacturer=Broadcom Corp
    S:  Product=BCM2045B3 ROM
    C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
    E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10msl

And running hciconfig display nothing until it actually detects. Then it 
will show the hci0 device. So until it is detected and working running 
any of the "hciconfig hci0 up" or "hciconfig hci0 reset" just gives a 
"Can't get device info: No such device".

In the thread i mentioned above Marcel posts:

     >Yours looks like an HID proxy mode device it might need some extra
    love
     >to switch it from HID into HCI mode. However that is always a magic
     >sequence and for some devices the reset=1 is fully enough. Some others
     >need some crazy init command.

That seems to be my problem. Can anyone shed any more light on what the 
init sequence might be?

Any help on this problem would be much appreciated.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
