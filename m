Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4462172D.3040604@ihep.ru>
From: Anton Gusev <Anton.Gusev@ihep.ru>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=KOI8-R
Subject: [Bluez-users] Intellimouse transmission lost
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
Date: Wed, 10 May 2006 20:39:09 +0400

Hi all!

  As I see, my mouse (MS Intellimouse for bluetooth) works automatically
after system up without starting bluetooth daemon on my distro
(ALT-Linux3.0).
So, the kernel (2.6.16) determines devices themselves and initialize
modules.
  But everytime my bt-mouse suspends after 20-40 minutes for some
reason, which
I can't determine. Linux installed on Toshiba Satellite M40-289 laptop.
  Please, help me if You have some ideas.
Thanks in advance,
Anton.

- part of lsmod issue:
...
ohci1394               35120  0
psmouse                40072  0
hci_usb                15764  0
bluetooth              49252  1 hci_usb
usbhid                 39264  0
ohci_hcd               21508  0
ehci_hcd               33416  0
usbcore               130948  5 hci_usb,usbhid,ohci_hcd,ehci_hcd
...

- part of dmesg:
....
usbcore: registered new driver hiddev
input: HID 045e:00bf as /class/input/input1
input: USB HID v1.11 Keyboard [HID 045e:00bf] on usb-0000:00:13.1-1.2
input: HID 045e:00be as /class/input/input2
input: USB HID v1.11 Mouse [HID 045e:00be] on usb-0000:00:13.1-1.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
....

- part of xorg.conf
...
Section "ServerLayout"
        Identifier     "Default Layout"
        Screen         "Screen at Device0" 0 0
        InputDevice    "ruwin_ct_sh" "CoreKeyboard"
        InputDevice    "mouseTP"  "CorePointer"
        InputDevice    "mouseBT"  "AlwaysCore"
EndSection

Section "InputDevice"
        Identifier "mouseBT"
        Driver "mouse"
        Option "Protocol" "ExplorerPS/2"
        Option "Device" "/dev/mouse"
        Option "Buttons" "7"
        Option "ZAxisMapping" "6 7"
EndSection

Section "InputDevice"
        Identifier  "mouseTP"
        Driver      "synaptics"
        Option      "Device" "/dev/input/mice"
        Option      "Protocol" "auto-dev"
        Option      "LeftEdge" "1700"
        Option      "RightEdge" "5300"
        Option      "TopEdge" "1700"
        Option      "BottomEdge" "4200"
        Option      "FingerLow" "25"
        Option      "FingerHigh" "30"
        Option      "MaxTapTime" "180"
        Option      "MaxTapMove" "220"
        Option      "VertScrollDelta" "100"
        Option      "MinSpeed" "0.06"
        Option      "MaxSpeed" "0.12"
        Option      "AccelFactor" "0.0010"
        Option      "SHMConfig" "on"
EndSection



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
