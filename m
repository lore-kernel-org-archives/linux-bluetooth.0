Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sf.net
Date: Thu, 2 Nov 2006 08:30:33 +0100
MIME-Version: 1.0
Message-Id: <200611020830.33466.cijoml@volny.cz>
Subject: [Bluez-users] How to setup BT keyboard operated by evdev device
	driver?
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

Hi Marcel,

how to set BT keyboard operated by evdev driver? If I do it so, som keys 
returns wrong scancodes (arrow up for example).
My keyboard si Microsoft BT desktop for Bluetooth first generation.

This setting I made for mouse, looks like works all buttons sends scancodes 
1-6

Section "InputDevice"
        Identifier              "Bluetooth Mouse"
        Driver                  "evdev"
        Option "Name"           "Bluetooth HID Boot Protocol Device"
        Option          "SendCoreEvents"        "true"
        Option  "Vendor"        "1118"
        Option  "Product"       "124"
EndSection

And this is for BT keyboard which returns wrong scancodes:

Section "InputDevice"
        Identifier  "Bluetooth Keyboard"
        #Driver      "kbd"
	Driver      "evdev"
        Option  "Name"  "Bluetooth HID Boot Protocol Device"
        Option  "Vendor"        "1118"
        Option  "Product"       "123"
        Option      "XkbRules"  "xfree86"
        Option      "XkbModel"  "pc105"
        Option      "XkbLayout" "us"
        #Option     "Xleds"     "1 2 3"
        #Option     "XkbVariant"        "nodeadkeys"
        #Option "evBits"  "+1"
        #Option "keyBits" "~1-255 ~352-511"
        #Option "Pass"    "3"
EndSection

Thanks a lot for your help

Michal

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
