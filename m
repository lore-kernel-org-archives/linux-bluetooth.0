Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040902141108.99034.qmail@web52807.mail.yahoo.com>
From: gonzalo briceno <gonzalohbriceno@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Key step in bluetonium setup, bcm203x does not load firmware
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
Date: Thu, 2 Sep 2004 07:11:08 -0700 (PDT)

I would like to know if you have instructions on
getting the bluetonium to work with linux.  I have
searched a lot of places and I know exactly what the
problem is.  It is bet summarized in sourceforge as
follows:
"
The Broadcom Blutonium devices need a firmware
download before they will work like any other H:2
compatible Bluetooth USB device. The bcm203x requests
the firmware files BCM2033-MD.hex and BCM2033-FW.bin
and loads them into the device. After this procedure
the device will disconnect from the USB bus and
reconnects as a standard H:2 device which will be
recognized by the hci_usb driver. The firmware files
are distributed in the bluez-firmware package.

An alternate way of loading the firmware onto such a
device is the bcm203x program from the bluez-utils
package, because the bcm203x kernel driver is only a
Linux 2.6 feature. It is necessary to install hotplug
for this. 
"

I installed bluez-firmware-1.0 and bluez-utils-2.9,
however, the problem is not fixed.  When I look at
/proc/bus/usb/devices the bluetonium chip is listed
but sure enough, it does not load the usb_hci module.

Any help? 

=====
--
Gonzalo Briceno
gonzalohbriceno@yahoo.com
267.679.1289


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
