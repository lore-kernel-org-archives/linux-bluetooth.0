Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 05 Mar 2007 16:46:17 +0000
Message-Id: <1173113177.23027.34.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Subject: [Bluez-devel] More thoughts on bluez-gnome
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Heya,

I was taking a look at the bluez-gnome source code on Friday, and this
week-end, as well as the interface in general.

I wanted to know what the target use of the bluetooth-applet (and
-properties) was.

The sort of thing that I'd like to see in a GNOME bluetooth applet:
- remove class of device drop-down menus (made a GConf-only option if
really necessary).
- add some integration into HAL (Software on/off, state restoration
after sleep)
- always display the bluetooth icon if a bluetooth device is present,
grayed out if the device is disabled (see above), removed if no adapter
is present at all
- more integration into existing GNOME software (gnome-vfs2-obexftp to
browse phones with Nautilus, gnome-obex-send and gnome-obex-server to
send and receive files).

The applet and the properties windows could also use a lot of cleanup,
codewise, to follow the GNOME style a bit more closely (separate the
auth/passkey code, make the "applet" into an object, use Glade when
possible to generate the interface).

Finally, I'd like to see convenience dialogues (as currently badly
implemented in gnome-bluetooth) for selecting particular Bluetooth
devices. Something aking to MacOS X' Bluetooth UI classes:
http://developer.apple.com/documentation/DeviceDrivers/Reference/IOBluetoothUI/index.html
and
http://developer.apple.com/documentation/DeviceDrivers/Conceptual/Bluetooth/BT_Bluetooth_On_MOSX/chapter_3_section_7.html#//apple_ref/doc/uid/TP30000997-CH215-TPXREF110

If the plan of bluez-gnome is to cater for the advanced Bluetooth
user[1], or the users of desktops other than GNOME, then I think I'll
move my focus onto bringing functionality to gnome-bluetooth instead.

Otherwise, I'd kindly request a CVS account so that my trivial cleanups
can get in faster.

Cheers

[1]: who wants to enable his bluetooth adapters as routers, need to be
able to enable/disable notification area icons, or change device
classes, etc.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
