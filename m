Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: =?KOI8-R?B?7snLz8zByiDrz83B0s/X?= <k1sk@yandex.ru>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <713121184940586@webmail17.yandex.ru>
Date: Fri, 20 Jul 2007 18:09:46 +0400
Subject: [Bluez-devel] printing with blueZ on Maemo (Nokia N800)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi!

I need to make it possible to print documents via Bluetooth on the

Nokia N800 device (based on ARM with Debian-like OS installed, see

http://maemo.org/development/ for developer details).

There are these libs in the system: bluez-cups 3.7osso11,

bluez-hcidump 1.36-0osso1, bluez-utils 3.9-osso4 , bluez-utils-test

3.9-osso4. ( http://tablets-dev.nokia.com/3.2/content_comparison.html )



First of all, I assured that the printer is visible from

N800:

I perform 'hcitool scan --scan' under root console and see

this printer with its BD address, name, and class.



I found a code example (in Python, here:

http://wiki.bluez.org/wiki/HOWTO/SerialConnections) that

allows communicate to the printer using SPP. I have Python

installed, so I run the example script (I called file

dbus.py) and receive error:



File "./dbus.py", line 3, in <module>

import dbus

File "/media/mmc1/dbus.py", line 7, in <module>

bus= dbus.SystemBus()

AttributeError: 'module' has no attribute 'System.Bus'



Someone advised me to check that there are 'necessary python D-Bus

bindings' installed but I have no idea where to look for it. I only

have a simple Python installation from here:

http://pymaemo.garage.maemo.org/installation.html 



I can't understand whether there are enough libs to print to a

bluetooth-enabled printer using 'serial port' bluetooth profile. 



If there's someone who has experience with using bluez in Maemo,

please contact me. What's the best language to use in this case? What

could this error message mean?



Best regards,

 Nikolay Komarov

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
