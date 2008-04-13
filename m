Return-Path: <cyrus@holtmann.org>
Message-ID: <4802424D.4060901@powercraft.nl>
Date: Sun, 13 Apr 2008 19:26:37 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------080506020101020107000008"
Subject: [Bluez-users] Bluetooth - Bluetake Presenter BTU-01
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080506020101020107000008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This message contains the following attachment(s):
Bluetooth - Bluetake Presenter BTU-01.txt
data.bin

Hello everybody,

Thank you for all the work on the bluetooth stack for linux.

I bought a new device named "Bluetake Presenter BTU-01". However I cant 
get it fuctioning. And I was hoping somebody can tell me wat to do. I 
attaced information about the device as attacements.

When the device is connected with hidd it makes a input event. But i 
cant get a functional device out of it. I think its a sort of keyboard 
but i dont really know.

Does somebody know what to do?

Kind regards,

Jelle

--------------080506020101020107000008
Content-Type: text/plain;
 name="Bluetooth - Bluetake Presenter BTU-01.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="Bluetooth - Bluetake Presenter BTU-01.txt"

#!/bin/sh

# linux how-to for bluetake bluetooth presenter type BTU-01
# http://formosa21.manufacturer.globalsources.com/si/6008822424696/pdtl/Remote-control/1001769282/Bluetooth-Slim-Remote-Control.htm

sudo apt-get install bluez-utils

sudo hciconfig hci0 down
sudo hciconfig hci0 up

sudo /etc/init.d/bluetooth restart

# make sure the device is in pairing mode so it can be detected and connected
# press and hold the button "bluethooth" until it start flashing very fast

hcitool scan
# output: 00:18:83:10:00:92 Bluetooth Presenter

sdptool browse 00:18:83:10:00:92

sudo hidd --killall
sudo hidd --search

sudo hidd --connect 00:18:83:10:00:92


sdptool browse 00:18:83:10:00:92

echo 'HIDD_OPTIONS="--connect 00:18:83:10:00:92 --server"' | sudo tee --append /etc/default/bluetooth
cat /etc/default/bluetooth



Browsing 00:18:83:10:00:92 ...
Service Name: Bluetooth Presenter
Service Description: Consumer
Service Provider: Formosa21 Inc.
Service RecHandle: 0x10000
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100


xinput list
sudo apt-get install xinput

ls -hal /dev/input/by-path/
total 0
drwxr-xr-x 2 root root 180 Apr 11 19:50 .
drwxr-xr-x 3 root root 320 Apr 11 19:50 ..
lrwxrwxrwx 1 root root   9 Apr 11 19:50 pci-0000:00:1d.1-usb-0:acl001883100092-event- -> ../event9
lrwxrwxrwx 1 root root   9 Apr 11 18:39 pci-0000:00:1d.1-usb-0:acl111111111795- -> ../mouse1
lrwxrwxrwx 1 root root   9 Apr 11 18:39 pci-0000:00:1d.1-usb-0:acl111111111795-event- -> ../event8
lrwxrwxrwx 1 root root   9 Apr 11 18:23 platform-i8042-serio-0-event-kbd -> ../event0
lrwxrwxrwx 1 root root   9 Apr 11 18:23 platform-i8042-serio-1-event-mouse -> ../event7
lrwxrwxrwx 1 root root   9 Apr 11 18:23 platform-i8042-serio-1-mouse -> ../mouse0
lrwxrwxrwx 1 root root   9 Apr 11 18:23 platform-pcspkr-event-spkr -> ../event6

# this is the bluetooth presenter
/dev/input/by-path/spci-0000:00:1d.1-usb-0:acl001883100092-event-
/dev/input/event9

InputDevice    "presenter"

Section "InputDevice"
    Identifier  "presenter"
    Driver      "evdev"
    Option      "Device"            "/dev/input/event9"
EndSection

sudo cat /dev/input/event9 > data.bin

--------------080506020101020107000008
Content-Type: application/octet-stream;
 name="data.bin"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="data.bin"

8dH/R7IRCQAEAAQA5wAJAPHR/0e4EQkAAQAGAQAAAADx0f9HvREJAAAAAAAAAAAA8dH/R01x
CgAEAAQA4gAJAPHR/0dScQoAAQABAQEAAADx0f9HWXEKAAAAAAAAAAAA8dH/Rx7LCgAEAAQA
4gAJAPHR/0ciywoAAQABAQAAAADx0f9HJ8sKAAAAAAAAAAAA8dH/RwghCwAEAAQA4gAJAPHR
/0cMIQsAAQABAQEAAADx0f9HEiELAAAAAAAAAAAA8dH/R7AqDAAEAAQA4AAJAPHR/0e0KgwA
AQAPAQAAAADx0f9HvSoMAAAAAAAAAAAA8dH/R0uKDQAEAAQA4wAJAPHR/0dQig0AAQACAQEA
AADx0f9HVooNAAAAAAAAAAAA8dH/R97pDgAEAAQA4QAJAPHR/0fj6Q4AAQAAAQAAAADx0f9H
6+kOAAAAAAAAAAAA8tH/R4sWAwAEAAQA4gAJAPLR/0eQFgMAAQABAQAAAADy0f9HlxYDAAAA
AAAAAAAA8tH/R4FsAwAEAAQA5AAJAPLR/0eFbAMAAQADAQEAAADy0f9Hi2wDAAAAAAAAAAAA
8tH/R957BQAEAAQA4wAJAPLR/0fiewUAAQACAQAAAADy0f9H6XsFAAAAAAAAAAAA8tH/R6wr
BgAEAAQA5QAJAPLR/0exKwYAAQAEAQEAAADy0f9HtisGAAAAAAAAAAAA8tH/R0uLBwAEAAQA
5gAJAPLR/0dRiwcAAQAFAQEAAADy0f9HV4sHAAAAAAAAAAAA8tH/RxM7CAAEAAQA5AAJAPLR
/0caOwgAAQADAQAAAADy0f9HITsIAAAAAAAAAAAA8tH/R3z0CQAEAAQA5wAJAPLR/0eB9AkA
AQAGAQEAAADy0f9HhvQJAAAAAAAAAAAA8tH/R2pKCgAEAAQA5QAJAPLR/0duSgoAAQAEAQAA
AADy0f9HdEoKAAAAAAAAAAAA8tH/R6SzDAAEAAQA5gAJAPLR/0epswwAAQAFAQAAAADy0f9H
rrMMAAAAAAAAAAAA8tH/R2xjDQAEAAQA4AAJAPLR/0dxYw0AAQAPAQEAAADy0f9HemMNAAAA
AAAAAAAA8tH/R+gYDwAEAAQA4QAJAPLR/0ftGA8AAQAAAQEAAADy0f9H9RgPAAAAAAAAAAAA
89H/R4MwAAAEAAQA5wAJAPPR/0eHMAAAAQAGAQAAAADz0f9HizAAAAAAAAAAAAAA89H/R+E/
AgAEAAQA4gAJAPPR/0fmPwIAAQABAQEAAADz0f9H7D8CAAAAAAAAAAAA89H/R2L1AwAEAAQA
4AAJAPPR/0dn9QMAAQAPAQAAAADz0f9Hb/UDAAAAAAAAAAAA89H/R9YEBgAEAAQA4wAJAPPR
/0faBAYAAQACAQEAAADz0f9H4AQGAAAAAAAAAAAA89H/R7BeBgAEAAQA4QAJAPPR/0e1XgYA
AQAAAQAAAADz0f9Hx14GAAAAAAAAAAAA89H/R3RkBwAEAAQA4gAJAPPR/0d6ZAcAAQABAQAA
AADz0f9HgmQHAAAAAAAAAAAA89H/R0y+BwAEAAQA5AAJAPPR/0dSvgcAAQADAQEAAADz0f9H
Wb4HAAAAAAAAAAAA89H/RzIUCAAEAAQA4wAJAPPR/0c3FAgAAQACAQAAAADz0f9HPhQIAAAA
AAAAAAAA89H/R/TDCAAEAAQA5AAJAPPR/0f4wwgAAQADAQAAAADz0f9H/cMIAAAAAAAAAAAA

--------------080506020101020107000008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------080506020101020107000008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------080506020101020107000008--
